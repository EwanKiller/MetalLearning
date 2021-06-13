//
//  Camera.cpp
//  CameraInGraphic
//
//  Created by ThisEwan on 2021/6/7.
//

#include "Camera.h"

Camera::Camera(const float viewportX, const float viewportY)
{
    position = Vector3f(0.0f,0.0f,0.0f);
    rotation = Vector3f(0.0f,0.0f,0.0f);
    scale = Vector3f(1.0f,1.0f,1.0f);
    fov = 90.0f;
    aspectRatio = 1.0f;
    near = 1.0f;
    far = 500.0f;
    viewport_X = viewportX;
    viewport_Y = viewportY;
}
Camera::~Camera()
{
    
}
Matrix4x4f Camera::getModelMatrix() const
{
    Vector3f factor = Vector3f(1.0f, 1.0f, 1.0f);
    Matrix4x4f scaleM;
    float scaleItems[16] =
    {
        factor.x,0.0f,0.0f,0.0f,
        0.0f,factor.y,0.0f,0.0f,
        0.0f,0.0f,factor.z,0.0f,
        0.0f,0.0f,0.0f,1.0f,
    };
    scaleM>>scaleItems;
    float angle = rotation.x * (M_PI / 180.0f); // 这里借用下camera的rotation.x！
    Matrix4x4f rotateXM;
    float rotateXItems[16] =
    {
        1.0f,0.0f,0.0f,0.0f,
        0.0f,cosf(angle),sinf(angle),0.0f,
        0.0f,-sinf(angle),cosf(angle),0.0f,
        0.0f,0.0f,0.0f,1.0f,
    };
    rotateXM>>rotateXItems;
    Vector3f offset = Vector3f(0.0f,0.0f,0.0f);
    float translateItems[16] =
    {
        1.0f,0.0f,0.0f,offset.x,
        0.0f,1.0f,0.0f,offset.y,
        0.0f,0.0f,1.0f,offset.z,
        0.0f,0.0f,0.0f,1.0f,
    };
    Matrix4x4f translateM;
    translateM>>translateItems;
    
    Matrix4x4f modelMatrix;
    Matrix4x4f sr;
    Matrix4x4f::multiply(rotateXM, scaleM, sr);
    Matrix4x4f::multiply(translateM, sr, modelMatrix);
    return modelMatrix;
}
Matrix4x4f Camera::getViewMatrix() const
{
    float viewTransMatrixItems[16] =
    {
        1.0f,0.0f,0.0f,-position.x,
        0.0f,1.0f,0.0f,-position.y,
        0.0f,0.0f,1.0f,-position.z,
        0.0f,0.0f,0.0f,1.0f,
    };
    Matrix4x4f viewTranslateMatrix;
    viewTranslateMatrix>>viewTransMatrixItems;
    Vector3f lookAt;
    lookAt = target - position;
    lookAt.normalize();
    Vector3f lookRight;
    Vector3f::cross(up, lookAt, lookRight);
    lookRight.normalize();
    Vector3f lookUp;
    Vector3f::cross(lookAt, lookRight, lookUp);
    lookUp.normalize();
    float viewRotateMatrixItems[16] =
    {
        lookRight.x,lookRight.y,lookRight.z,0.0f,
        lookUp.x,lookUp.y,lookUp.z,0.0f,
        lookAt.x,lookAt.y,lookAt.z,0.0f,
        0.0f,0.0f,0.0f,1.0f,
    };
    Matrix4x4f viewRotateMatrix;
    viewRotateMatrix>>viewRotateMatrixItems;
    Matrix4x4f viewMatrix;
    Matrix4x4f::multiply(viewTranslateMatrix, viewRotateMatrix, viewMatrix);
    
    Matrix4x4f viewRotateY;
    float angle = rotation.y * (M_PI / 180.0f);
    float viewRotYitems[16] =
    {
        cosf(angle),0.0f,-sinf(angle),0.0f,
        0.0f,1.0f,0.0f,0.0f,
        sinf(angle),0.0f,cosf(angle),0.0f,
        0.0f,0.0f,0.0f,1.0f,
    };
    viewRotateY>>viewRotYitems;
    Matrix4x4f::multiply(viewRotateY, viewRotateMatrix, viewMatrix);
    Matrix4x4f::multiply(viewTranslateMatrix, viewMatrix, viewMatrix);
    return viewMatrix;
}

Matrix4x4f Camera::getOrthonormalMatrix() const
{
    /** T_ortho 正交投影的frustum的平移矩阵*/
    float halfViewX = viewport_X / 2.0f;
    float halfViewY = viewport_Y / 2.0f;
    float l = -halfViewX + position.x;
    float r = halfViewX + position.x;
    float b = -halfViewY + position.y;
    float t = halfViewY + position.y;
    float orthoTransMatrixItems[16] =
    {
        1.0f,0.0f,0.0f,-(r + l) / 2.0f,
        0.0f,1.0f,0.0f,-(t + b) / 2.0f,
        0.0f,0.0f,1.0f,-near,         // 这里z只平移near的原因是在Metal中，视锥Z方向上的距离是[0,1]而非[-1,1]
        0.0f,0.0f,0.0f,1.0f,
    };
    Matrix4x4f orthoTranslateMatrix;
    orthoTranslateMatrix>>orthoTransMatrixItems;
    /** S_ortho  正交投影的frustum的缩放矩阵*/
    float orthoScaleMatrixItems[16] =
    {
        2.0f / (r - l),0.0f,0.0f,0.0f,
        0.0f,2.0f / (t - b),0.0f,0.0f,
        0.0f,0.0f,1.0f / (far -near),0.0f,  // 这里z只缩放1/(far-near)也是因为视锥Z方向上的距离是[0,1]而非[-1,1]
        0.0f,0.0f,0.0f,1.0f,
    };
    Matrix4x4f orthoScaleMatrix;
    orthoScaleMatrix>>orthoScaleMatrixItems;
    /** 正交投影的Frustum矩阵*/
    Matrix4x4f orthoProjectionMatrix;
    Matrix4x4f::multiply(orthoScaleMatrix, orthoTranslateMatrix, orthoProjectionMatrix);
    return orthoProjectionMatrix;
}

Matrix4x4f Camera::getProjectioMatrix() const
{
    float height = 1.0f / tanf(fov * 0.5f * (M_PI/180.0f));
    float width = height * aspectRatio;
    Matrix4x4f m;
    float ms[16] =
    {
        1.0f/width,0,0,0.0f,
        0.0f,1.0f/height,0,0.0f,
        0.0f,0.0f,far/(far - near),-near*(far/(far-near)),
        0.0f,0.0f,1.0f,0.0f,
    };
//    float ms[16] =
//    {
//        near/width,0,0,0.0f,
//        0.0f,near/height,0,0.0f,
//        0.0f,0.0f,far/(far - near),-(2.0f*near*far)/(far-near),
//        0.0f,0.0f,1.0f,0.0f,
//    };
    m>>ms;
    return m;
}
