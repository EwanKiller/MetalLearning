//
//  Camera.cpp
//  CameraInGraphic
//
//  Created by ThisEwan on 2021/6/7.
//

#include "Camera.h"
Camera::Camera()
{
    
}
Camera::~Camera()
{
    
}
Matrix4x4f Camera::getViewMatrix(const Vector3f &offset, const Vector3f &target, const Vector3f &up) const
{
    float items[16] =
    {
        1,0,0,-offset.x,
        0,1,0,-offset.y,
        0,0,1,-offset.z,
        0,0,0,1,
    };
    Matrix4x4f viewTranslateMatrix;
    viewTranslateMatrix>>items;
    Vector3f N;
    N = target - position;
    Vector3f U;
    Vector3f::cross(up, N, U);
    U.normalize();
    Vector3f V;
    Vector3f::cross(N, U, V);
    V.normalize();
    float items1[16] =
    {
        U.x,U.y,U.z,0,
        V.x,V.y,V.z,0,
        N.x,N.y,N.z,0,
        0,0,0,1,
    };
    Matrix4x4f viewRotateMatrix;
    viewRotateMatrix>>items1;
    Matrix4x4f viewMatrix;
    Matrix4x4f::multiply(viewTranslateMatrix, viewRotateMatrix, viewMatrix);
    return viewMatrix;
}
