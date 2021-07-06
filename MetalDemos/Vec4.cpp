//
//  Vec4.cpp
//  MetalDemos
//
//  Created by ThisEwan on 2021/6/18.
//

#include "Vec4.h"

Vec4::Vec4()
{
}
Vec4::~Vec4()
{
}
Vec4::Vec4(const float x, const float y, const float z, const float w):x(x),y(y),z(z),w(w)
{
}
Vec4::Vec4(const float *array):x(array[0]),y(array[1]),z(array[2]),w(array[3])
{
}
Vec4::Vec4(const Vec4& vec):x(vec.x),y(vec.y),z(vec.z),w(vec.w)
{
}
Vec4 Vec4::operator-(const Vec4 &vec)const
{
    return Vec4(x - vec.x, y - vec.y, z - vec.z, w - vec.w);
}

simd_float4 Vec4::transformSimdVec4f() const
{
    simd_float4 sf4;
    sf4.x = x;
    sf4.y = y;
    sf4.z = z;
    sf4.w = w;
    return  sf4;
}
