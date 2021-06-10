//
//  Camera.cpp
//  CameraInGraphic
//
//  Created by ThisEwan on 2021/6/7.
//

#include "Camera.h"
Camera::Camera()
{
    position = Vector3f(0.0f,0.0f,0.0f);
    rotation = Vector3f(0.0f,0.0f,0.0f);
    scale = Vector3f(1.0f,1.0f,1.0f);
    fov = 90;
    aspectRatio = 1.0;
    near = 0;
    far = 100;
}
Camera::~Camera()
{
    
}
Camera& Camera::operator=(const Camera &cam)
{
    this->position = cam.position;
    this->rotation = cam.rotation;
    this->scale = cam.scale;
    this->fov = cam.fov;
    this->aspectRatio = cam.aspectRatio;
    this->near = cam.near;
    this->far = cam.far;
    return *this;
}

Matrix4x4f Camera::getViewMatrix(const Vector3f &target, const Vector3f &up) const
{
    float viewTransMatrixItems[16] =
    {
        1,0,0,-position.x,
        0,1,0,-position.y,
        0,0,1,-position.z,
        0,0,0,1,
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
        lookRight.x,lookRight.y,lookRight.z,0,
        lookUp.x,lookUp.y,lookUp.z,0,
        lookAt.x,lookAt.y,lookAt.z,0,
        0,0,0,1,
    };
    Matrix4x4f viewRotateMatrix;
    viewRotateMatrix>>viewRotateMatrixItems;
    Matrix4x4f viewMatrix;
    Matrix4x4f::multiply(viewTranslateMatrix, viewRotateMatrix, viewMatrix);
    return viewMatrix;
}
