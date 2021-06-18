//
//  Vec4.cpp
//  MetalDemos
//
//  Created by ThisEwan on 2021/6/18.
//

#include "Vec4.hpp"

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
