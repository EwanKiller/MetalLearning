//
//  Transform.cpp
//  CameraInGraphic
//
//  Created by ThisEwan on 2021/6/7.
//

#include "Transform.h"
#include <math.h>

void AffineTransform::Translate(const Vector3f &offset, Vector3f &pos)
{
    Matrix4x1f posMatrix = Matrix4x1f(pos.x,pos.y,pos.z,1.0f);
    float item[16] =
    {
        1.0f,0.0f,0.0f,offset.x,
        0.0f,1.0f,0.0f,offset.y,
        0.0f,0.0f,1.0f,offset.z,
        0.0f,0.0f,0.0f,1.0f,
    };
    Matrix4x4f translateMatrix;
    translateMatrix>>item;
    Matrix4x1f result;
    Matrix4x4f::multiply(translateMatrix, posMatrix, result);
    pos.x = result.col[0];
    pos.y = result.col[1];
    pos.z = result.col[2];
}

void AffineTransform::RotateAxisX(const float angle, Vector3f &pos)
{
    Matrix4x1f posMatrix = Matrix4x1f(pos.x,pos.y,pos.z,1.0f);
    float item[16] =
    {
        1.0f,0.0f,0.0f,0.0f,
        cosf(angle),sinf(angle),0.0f,0.0f,
        -sinf(angle),cosf(angle),0.0f,0.0f,
        0.0f,0.0f,0.0f,1.0f,
    };
    Matrix4x4f rotateMatrix;
    rotateMatrix>>item;
    Matrix4x1f result;
    Matrix4x4f::multiply(rotateMatrix, posMatrix, result);
    pos.x = result.col[0];
    pos.y = result.col[1];
    pos.z = result.col[2];
}
void AffineTransform::RotateAxisY(const float angle, Vector3f &pos)
{
    Matrix4x1f posMatrix = Matrix4x1f(pos.x,pos.y,pos.z,1.0f);
    float item[16] =
    {
        cosf(angle),-sinf(angle),0.0f,0.0f,
        0.0f,1.0f,0.0f,0.0f,
        sinf(angle),cosf(angle),0.0f,0.0f,
        0.0f,0.0f,0.0f,1.0f,
    };
    Matrix4x4f rotateMatrix;
    rotateMatrix>>item;
    Matrix4x1f result;
    Matrix4x4f::multiply(rotateMatrix, posMatrix, result);
    pos.x = result.col[0];
    pos.y = result.col[1];
    pos.z = result.col[2];
}
void AffineTransform::RotateAxisZ(const float angle, Vector3f &pos)
{
    Matrix4x1f posMatrix = Matrix4x1f(pos.x,pos.y,pos.z,1.0f);
    float item[16] =
    {
        cosf(angle),sinf(angle),0.0f,0.0f,
        -sinf(angle),cosf(angle),0.0f,0.0f,
        0.0f,0.0f,1.0f,0.0f,
        0.0f,0.0f,0.0f,1.0f,
    };
    Matrix4x4f rotateMatrix;
    rotateMatrix>>item;
    Matrix4x1f result;
    Matrix4x4f::multiply(rotateMatrix, posMatrix, result);
    pos.x = result.col[0];
    pos.y = result.col[1];
    pos.z = result.col[2];
}
void AffineTransform::Scale(const Vector3f &factor, Vector3f &pos)
{
    Matrix4x1f posMatrix = Matrix4x1f(pos.x,pos.y,pos.z,1.0f);
    float item[16] =
    {
        factor.x,0.0f,0.0f,0.0f,
        0.0f,factor.y,0.0f,0.0f,
        0.0f,0.0f,factor.z,0.0f,
        0.0f,0.0f,0.0f,1.0f,
    };
    Matrix4x4f scaleMatrix;
    scaleMatrix>>item;
    Matrix4x1f result;
    Matrix4x4f::multiply(scaleMatrix, posMatrix, result);
    pos.x = result.col[0];
    pos.y = result.col[1];
    pos.z = result.col[2];
}
