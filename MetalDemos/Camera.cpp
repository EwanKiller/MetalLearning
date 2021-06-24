//
//  Camera.cpp
//  MetalDemos
//
//  Created by ThisEwan on 2021/6/22.
//

#include "Camera.hpp"

Camera::Camera(const float viewportX, const float viewportY)
{
    position = Vec3(0.0f,0.0f,0.0f);
    rotation = Vec3(0.0f,0.0f,0.0f);
    scale = Vec3(1.0f,1.0f,1.0f);
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

Mat4 Camera::getViewMatrix() const
{
    float viewTransMatrixItems[16] =
    {
        1.0f,0.0f,0.0f,-position.x,
        0.0f,1.0f,0.0f,-position.y,
        0.0f,0.0f,1.0f,-position.z,
        0.0f,0.0f,0.0f,1.0f,
    };
    Mat4 viewTranslateMatrix;
    viewTranslateMatrix>>viewTransMatrixItems;
    Vec3 lookAt;
    lookAt = target - position;
    lookAt.normalize();
    Vec3 lookRight;
    Vec3::cross(up, lookAt, lookRight);
    lookRight.normalize();
    Vec3 lookUp;
    Vec3::cross(lookAt, lookRight, lookUp);
    lookUp.normalize();
    float viewRotateMatrixItems[16] =
    {
        lookRight.x,lookRight.y,lookRight.z,0.0f,
        lookUp.x,lookUp.y,lookUp.z,0.0f,
        lookAt.x,lookAt.y,lookAt.z,0.0f,
        0.0f,0.0f,0.0f,1.0f,
    };
    Mat4 viewRotateMatrix;
    viewRotateMatrix>>viewRotateMatrixItems;
    Mat4 viewMatrix;
    Mat4::multiply(viewTranslateMatrix, viewRotateMatrix, viewMatrix);
    
    Mat4 viewRotateY;
    float angle = rotation.y * (M_PI / 180.0f);
    float viewRotYitems[16] =
    {
        cosf(angle),0.0f,-sinf(angle),0.0f,
        0.0f,1.0f,0.0f,0.0f,
        sinf(angle),0.0f,cosf(angle),0.0f,
        0.0f,0.0f,0.0f,1.0f,
    };
    viewRotateY>>viewRotYitems;
    Mat4::multiply(viewRotateY, viewRotateMatrix, viewMatrix);
    Mat4::multiply(viewTranslateMatrix, viewMatrix, viewMatrix);
    return viewMatrix;
}

Mat4 Camera::getOrthonormalMatrix() const
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
    Mat4 orthoTranslateMatrix;
    orthoTranslateMatrix>>orthoTransMatrixItems;
    /** S_ortho  正交投影的frustum的缩放矩阵*/
    float orthoScaleMatrixItems[16] =
    {
        2.0f / (r - l),0.0f,0.0f,0.0f,
        0.0f,2.0f / (t - b),0.0f,0.0f,
        0.0f,0.0f,1.0f / (far -near),0.0f,  // 这里z只缩放1/(far-near)也是因为视锥Z方向上的距离是[0,1]而非[-1,1]
        0.0f,0.0f,0.0f,1.0f,
    };
    Mat4 orthoScaleMatrix;
    orthoScaleMatrix>>orthoScaleMatrixItems;
    /** 正交投影的Frustum矩阵*/
    Mat4 orthoProjectionMatrix;
    Mat4::multiply(orthoScaleMatrix, orthoTranslateMatrix, orthoProjectionMatrix);
    return orthoProjectionMatrix;
}

Mat4 Camera::getProjectioMatrix() const
{
    float height = 1.0f / tanf(fov * 0.5f * (M_PI/180.0f));
    float width = height * aspectRatio;
    Mat4 m;
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

