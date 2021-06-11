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
    near = 0.0f;
    far = 100.0f;
    viewport_X = viewportX;
    viewport_Y = viewportY;
}
Camera::~Camera()
{
    
}

Matrix4x4f Camera::getViewMatrix(const Vector3f &target, const Vector3f &up) const
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
    return viewMatrix;
}

Matrix4x4f Camera::getOrthonormalMatrix() const
{
    float orthoTransMatrixItems[16] =
    {
        0.0f,0.0f,0.0f,-viewport_X / 2,
        0.0f,0.0f,0.0f,-viewport_Y / 2,
        0.0f,0.0f,0.0f,-near,         // 这里z只平移near的原因是在Metal中，视锥Z方向上的距离是[0,1]而非[-1,1]
        0.0f,0.0f,0.0f,1.0f
    };
    Matrix4x4f orthoTranslateMatrix;
    orthoTranslateMatrix>>orthoTransMatrixItems;
    float orthoScaleMatrixItems[16] =
    {
        2 / viewport_X,0.0f,0.0f,0.0f,
        0.0f,2 / viewport_Y,0.0f,0.0f,
        0.0f,0.0f,1 / (far - near),0.0f,  // 这里z只缩放1/(far-near）也是因为视锥Z方向上的距离是[0,1]而非[-1,1]
        0.0f,0.0f,0.0f,1.0f,
    };
    Matrix4x4f orthoScaleMatrix;
    orthoScaleMatrix>>orthoScaleMatrixItems;
    Matrix4x4f orthoProjectionMatrix;
    Matrix4x4f::multiply(orthoTranslateMatrix, orthoScaleMatrix, orthoProjectionMatrix);
    return orthoProjectionMatrix;
}
Matrix4x4f Camera::getPerspectiveToOrthonormalMatrix() const
{
    float perspToOrthoItems[16] =
    {
        near,0.0f,0.0f,0.0f,
        0.0f,near,0.0f,0.0f,
        0.0f,0.0f,near + far,near/(near + far),
        0.0f,0.0f,1.0f,0.0f,
    };
    Matrix4x4f perspToOrthMatrix;
    perspToOrthMatrix>>perspToOrthoItems;
    return perspToOrthMatrix;
}
