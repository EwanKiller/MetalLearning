//
//  Vector.m
//  CameraInGraphic
//
//  Created by ThisEwan on 2021/6/6.
//

#include "Vector.h"

Vector3f::Vector3f():x(0.0f),y(0.0f),z(0.0f){ }
Vector3f::Vector3f(const Vector3f &vec):x(vec.x),y(vec.y),z(vec.z){}
Vector3f::Vector3f(float a, float b, float c):x(a),y(b),z(c){ }
Vector3f::~Vector3f(){ }
Vector3f& Vector3f::operator=(const Vector3f &vec)
{
    x = vec.x;
    y = vec.y;
    z = vec.z;
    return *this;
}
Vector3f Vector3f::operator+(const Vector3f &vec) const
{
    return Vector3f(x + vec.x, y + vec.y, z + vec.z);
}
Vector3f Vector3f::operator-(const Vector3f &vec) const
{
    return Vector3f(x - vec.x, y - vec.y, z - vec.z);
}
void Vector3f::normalize()
{
    float magnitude = sqrtf(x * x + y * y + z * z);
    if(magnitude > 0.0f)
    {
        float oneOverMag = 1.0f / magnitude;
        x *= oneOverMag;
        y *= oneOverMag;
        z *= oneOverMag;
    }
}
void Vector3f::cross(const Vector3f &lhs, const Vector3f &rhs, Vector3f &outResult)
{
    outResult.x = lhs.y * rhs.z - lhs.z * rhs.y;
    outResult.y = lhs.z * rhs.x - lhs.x * rhs.z;
    outResult.z = lhs.x * rhs.y - lhs.y * rhs.x;
}
