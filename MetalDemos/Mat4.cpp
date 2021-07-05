//
//  Mat4.cpp
//  MetalDemos
//
//  Created by ThisEwan on 2021/6/18.
//

#include "Mat4.hpp"

Mat4::Mat4()
{
    *this = IDENTITY;
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
Mat4::Mat4(const Mat4 &mat)
{
    m[0] = mat.m[0];
    m[1] = mat.m[1];
    m[2] = mat.m[2];
    m[3] = mat.m[3];
    m[4] = mat.m[4];
    m[5] = mat.m[5];
    m[6] = mat.m[6];
    m[7] = mat.m[7];
    m[8] = mat.m[8];
    m[9] = mat.m[9];
    m[10] = mat.m[10];
    m[11] = mat.m[11];
    m[12] = mat.m[12];
    m[13] = mat.m[13];
    m[14] = mat.m[14];
    m[15] = mat.m[15];
}

Mat4& Mat4::operator>>(const float *item)
{
    m[0] = item[0];
    m[1] = item[4];
    m[2] = item[8];
    m[3] = item[12];
    
    m[4] = item[1];
    m[5] = item[5];
    m[6] = item[9];
    m[7] = item[13];
    
    m[8] = item[2];
    m[9] = item[6];
    m[10] = item[10];
    m[11] = item[14];
    
    m[12] = item[3];
    m[13] = item[7];
    m[14] = item[11];
    m[15] = item[15];
    
    return *this;
}
void Mat4::multiply(const Mat4 &lhs, const Mat4 &rhs, Mat4 &outResult)
{
    outResult.m[0] = lhs.m[0] * rhs.m[0] + lhs.m[4] * rhs.m[1] + lhs.m[8] * rhs.m[2] + lhs.m[12] * rhs.m[3];
    outResult.m[1] = lhs.m[1] * rhs.m[0] + lhs.m[5] * rhs.m[1] + lhs.m[9] * rhs.m[2] + lhs.m[13] * rhs.m[3];
    outResult.m[2] = lhs.m[2] * rhs.m[0] + lhs.m[6] * rhs.m[1] + lhs.m[10] * rhs.m[2] + lhs.m[14] * rhs.m[3];
    outResult.m[3] = lhs.m[3] * rhs.m[0] + lhs.m[7] * rhs.m[1] + lhs.m[11] * rhs.m[2] + lhs.m[15] * rhs.m[3];
    outResult.m[4] = lhs.m[0] * rhs.m[4] + lhs.m[4] * rhs.m[5] + lhs.m[8] * rhs.m[6] + lhs.m[12] * rhs.m[7];
    outResult.m[5] = lhs.m[1] * rhs.m[4] + lhs.m[5] * rhs.m[5] + lhs.m[9] * rhs.m[6] + lhs.m[13] * rhs.m[7];
    outResult.m[6] = lhs.m[2] * rhs.m[4] + lhs.m[6] * rhs.m[5] + lhs.m[10] * rhs.m[6] + lhs.m[14] * rhs.m[7];
    outResult.m[7] = lhs.m[3] * rhs.m[4] + lhs.m[7] * rhs.m[5] + lhs.m[11] * rhs.m[6] + lhs.m[15] * rhs.m[7];
    outResult.m[8] = lhs.m[0] * rhs.m[8] + lhs.m[4] * rhs.m[9] + lhs.m[8] * rhs.m[10]+ lhs.m[12] * rhs.m[11];
    outResult.m[9] = lhs.m[1] * rhs.m[8] + lhs.m[5] * rhs.m[9] + lhs.m[9] * rhs.m[10] + lhs.m[13] * rhs.m[11];
    outResult.m[10] = lhs.m[2] * rhs.m[8] + lhs.m[6] * rhs.m[9] + lhs.m[10] * rhs.m[10] + lhs.m[14] * rhs.m[11];
    outResult.m[11] = lhs.m[3] * rhs.m[8] + lhs.m[7] * rhs.m[9] + lhs.m[11] * rhs.m[10] + lhs.m[15] * rhs.m[11];
    outResult.m[12] = lhs.m[0] * rhs.m[12] + lhs.m[4] * rhs.m[13] + lhs.m[8] * rhs.m[14] + lhs.m[12] * rhs.m[15];
    outResult.m[13] = lhs.m[1] * rhs.m[12] + lhs.m[5] * rhs.m[13] + lhs.m[9] * rhs.m[14] + lhs.m[13] * rhs.m[15];
    outResult.m[14] = lhs.m[2] * rhs.m[12] + lhs.m[6] * rhs.m[13] + lhs.m[10] * rhs.m[14] + lhs.m[14] * rhs.m[15];
    outResult.m[15] = lhs.m[3] * rhs.m[12] + lhs.m[7] * rhs.m[13] + lhs.m[11] * rhs.m[14] + lhs.m[15] * rhs.m[15];
//    /**矩阵乘法的记忆方法：row行col列的结果是由左边矩阵的row行中的0123列四个数分别去乘以右边矩阵的col列中的0123行的四个数 */
//    for (int row = 0; row < 4; row++) {
//        for (int col = 0; col < 4; col++) {
//            outResult.item[row][col] = lhs.item[row][0] * rhs.item[0][col] + lhs.item[row][1] * rhs.item[1][col] + lhs.item[row][2] * rhs.item[2][col] + lhs.item[row][3] * rhs.item[3][col];
//        }
//    }
}

const Mat4 Mat4::IDENTITY = Mat4(
                                 1.0f, 0.0f, 0.0f, 0.0f,
                                 0.0f, 1.0f, 0.0f, 0.0f,
                                 0.0f, 0.0f, 1.0f, 0.0f,
                                 0.0f, 0.0f, 0.0f, 1.0f);
const Mat4 Mat4::ZERO = Mat4(
                             0.0f, 0.0f, 0.0f, 0.0f,
                             0.0f, 0.0f, 0.0f, 0.0f,
                             0.0f, 0.0f, 0.0f, 0.0f,
                             0.0f, 0.0f, 0.0f, 0.0f);

matrix_float4x4 Mat4::transformToSimdMat()
{
    simd_float4 col1;
    col1.x = m[0];
    col1.y = m[1];
    col1.z = m[2];
    col1.w = m[3];
    simd_float4 col2;
    col2.x = m[4];
    col2.y = m[5];
    col2.z = m[6];
    col2.w = m[7];
    simd_float4 col3;
    col3.x = m[8];
    col3.y = m[9];
    col3.z = m[10];
    col3.w = m[11];
    simd_float4 col4;
    col4.x = m[12];
    col4.y = m[13];
    col4.z = m[14];
    col4.w = m[15];
    return simd_matrix(col1, col2, col3, col4);
}
