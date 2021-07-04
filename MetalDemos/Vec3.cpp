//
//  Vec3.cpp
//  MetalDemos
//
//  Created by ThisEwan on 2021/6/18.
//

#include "Vec3.hpp"

Vec3::Vec3():x(0.0f),y(0.0f),z(0.0f)
{
}
Vec3::~Vec3()
{
}
Vec3::Vec3(float x, float y, float z):x(x),y(y),z(z)
{
}
//Vec3::Vec3(const float x, const float y, const float z):x(x),y(y),z(z)
//{
//}
Vec3::Vec3(const float *array):x(array[0]),y(array[1]),z(array[2])
{
}
Vec3::Vec3(const Vec3 &vec):x(vec.x),y(vec.y),z(vec.z)
{
}
void Vec3::operator>>(Vec3 &vec)
{
    x = vec.x;
    y = vec.y;
    z = vec.z;
}
Vec3 Vec3::operator-(const Vec3 &vec) const
{
    return Vec3(x - vec.x, y - vec.y, z - vec.z);
}
void Vec3::normalize()
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
void Vec3::cross(const Vec3 &lhs, const Vec3 &rhs, Vec3 &outResult)
{
    outResult.x = lhs.y * rhs.z - lhs.z * rhs.y;
    outResult.y = lhs.z * rhs.x - lhs.x * rhs.z;
    outResult.z = lhs.x * rhs.y - lhs.y * rhs.x;
}
