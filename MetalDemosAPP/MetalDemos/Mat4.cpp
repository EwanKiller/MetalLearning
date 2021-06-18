//
//  Mat4.cpp
//  MetalDemos
//
//  Created by ThisEwan on 2021/6/18.
//

#include "Mat4.hpp"

Mat4::Mat4()
{
}
Mat4::~Mat4()
{
}
Mat4::Mat4(const float m11, const float m12, const float m13, const float m14, const float m21, const float m22, const float m23, const float m24, const float m31, const float m32, const float m33, const float m34, const float m41, const float m42, const float m43, const float m44)
{
    m[0] = m11;
    m[1] = m21;
    m[2] = m31;
    m[3] = m41;
    
    m[4] = m12;
    m[5] = m22;
    m[6] = m32;
    m[7] = m42;
    
    m[8] = m13;
    m[9] = m23;
    m[10] = m33;
    m[11] = m43;
    
    m[12] = m14;
    m[13] = m24;
    m[14] = m34;
    m[15] = m44;
}
Mat4::Mat4(const float *array)
{
    m[0] = array[0];
    m[1] = array[4];
    m[2] = array[8];
    m[3] = array[12];
    
    m[4] = array[1];
    m[5] = array[5];
    m[6] = array[9];
    m[7] = array[13];
    
    m[8] = array[2];
    m[9] = array[6];
    m[10] = array[10];
    m[11] = array[14];
    
    m[12] = array[3];
    m[13] = array[7];
    m[14] = array[11];
    m[15] = array[15];
}
