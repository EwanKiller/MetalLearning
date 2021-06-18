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
Vec3::Vec3(const float x, const float y, const float z):x(x),y(y),z(z)
{
}
Vec3::Vec3(const float *array):x(array[0]),y(array[1]),z(array[2])
{
}
Vec3::Vec3(const Vec3 &vec):x(vec.x),y(vec.y),z(vec.z)
{
}
