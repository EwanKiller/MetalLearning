//
//  Matrix.cpp
//  CameraInGraphic
//
//  Created by ThisEwan on 2021/6/6.
//

#include "Matrix.h"

Matrix4x1f::Matrix4x1f(){
    col[0] = 0;
    col[1] = 0;
    col[2] = 0;
    col[3] = 0;
}
Matrix4x1f::~Matrix4x1f()
{
    
}
Matrix4x1f::Matrix4x1f(float x, float y, float z, float w)
{
    col[0] = x;
    col[1] = y;
    col[2] = z;
    col[3] = w;
}
Matrix4x1f& Matrix4x1f::operator>>(const float item[])
{
    col[0] = item[0];
    col[1] = item[1];
    col[2] = item[2];
    col[3] = item[3];
    return *this;
}


Matrix4x4f::Matrix4x4f()
{
    item[0][0] = 1.0;
    item[1][0] = 0.0;
    item[2][0] = 0.0;
    item[3][0] = 0.0;
    
    item[0][1] = 0.0;
    item[1][1] = 1.0;
    item[2][1] = 0.0;
    item[3][1] = 0.0;
    
    item[0][2] = 0.0;
    item[1][2] = 0.0;
    item[2][2] = 1.0;
    item[3][2] = 0.0;
    
    item[0][3] = 0.0;
    item[1][3] = 0.0;
    item[2][3] = 0.0;
    item[3][3] = 1.0;
}
Matrix4x4f& Matrix4x4f::operator>>(const float arg[])
{
    item[0][0] = arg[0];
    item[1][0] = arg[1];
    item[2][0] = arg[2];
    item[3][0] = arg[3];
    
    item[0][1] = arg[4];
    item[1][1] = arg[5];
    item[2][1] = arg[6];
    item[3][1] = arg[7];
    
    item[0][2] = arg[8];
    item[1][2] = arg[9];
    item[2][2] = arg[10];
    item[3][2] = arg[11];
    
    item[0][3] = arg[12];
    item[1][3] = arg[13];
    item[2][3] = arg[14];
    item[3][3] = arg[15];
    return *this;
}

void Matrix4x4f::multiply(const Matrix4x4f &lhs, const Matrix4x1f &rhs, Matrix4x1f &outResult)
{
    outResult.col[0] = lhs.item[0][0] * rhs.col[0] + lhs.item[0][1] * rhs.col[1] + lhs.item[0][2] * rhs.col[2] + lhs.item[0][3] * rhs.col[3];
    outResult.col[1] = lhs.item[1][0] * rhs.col[0] + lhs.item[1][1] * rhs.col[1] + lhs.item[1][2] * rhs.col[2] + lhs.item[1][3] * rhs.col[3];
    outResult.col[2] = lhs.item[2][0] * rhs.col[0] + lhs.item[2][1] * rhs.col[1] + lhs.item[2][2] * rhs.col[2] + lhs.item[2][3] * rhs.col[3];
    outResult.col[3] = lhs.item[3][0] * rhs.col[0] + lhs.item[3][1] * rhs.col[1] + lhs.item[3][2] * rhs.col[2] + lhs.item[3][3] * rhs.col[3];
}

void Matrix4x4f::multiply(const Matrix4x4f &lhs, const Matrix4x4f &rhs, Matrix4x4f &outResult)
{
    outResult.item[0][0] = lhs.item[0][0] * rhs.item[0][0] + lhs.item[0][1] * rhs.item[1][0] + lhs.item[0][2] * rhs.item[2][0] + lhs.item[0][3] * rhs.item[3][0];
    outResult.item[0][1] = lhs.item[0][0] * rhs.item[0][1] + lhs.item[0][1] * rhs.item[1][1] + lhs.item[0][2] * rhs.item[2][1] + lhs.item[0][3] * rhs.item[3][1];
    outResult.item[0][2] = lhs.item[0][0] * rhs.item[0][2] + lhs.item[0][1] * rhs.item[1][2] + lhs.item[0][2] * rhs.item[2][2] + lhs.item[0][3] * rhs.item[3][2];
    outResult.item[0][3] = lhs.item[0][0] * rhs.item[0][3] + lhs.item[0][1] * rhs.item[1][3] + lhs.item[0][2] * rhs.item[2][3] + lhs.item[0][3] * rhs.item[3][3];
    outResult.item[1][0] = lhs.item[1][0] * rhs.item[0][0] + lhs.item[1][1] * rhs.item[1][0] + lhs.item[1][2] * rhs.item[2][0] + lhs.item[1][3] * rhs.item[3][0];
    outResult.item[1][1] = lhs.item[1][0] * rhs.item[0][1] + lhs.item[1][1] * rhs.item[1][1] + lhs.item[1][2] * rhs.item[2][1] + lhs.item[1][3] * rhs.item[3][1];
    outResult.item[1][2] = lhs.item[1][0] * rhs.item[0][2] + lhs.item[1][1] * rhs.item[1][2] + lhs.item[1][2] * rhs.item[2][2] + lhs.item[1][3] * rhs.item[3][2];
    outResult.item[1][3] = lhs.item[1][0] * rhs.item[0][3] + lhs.item[1][1] * rhs.item[1][3] + lhs.item[1][2] * rhs.item[2][3] + lhs.item[1][3] * rhs.item[3][3];
    outResult.item[2][0] = lhs.item[2][0] * rhs.item[0][0] + lhs.item[2][1] * rhs.item[1][0] + lhs.item[2][2] * rhs.item[2][0] + lhs.item[2][3] * rhs.item[3][0];
    outResult.item[2][1] = lhs.item[2][0] * rhs.item[0][1] + lhs.item[2][1] * rhs.item[1][1] + lhs.item[2][2] * rhs.item[2][1] + lhs.item[2][3] * rhs.item[3][1];
    outResult.item[2][2] = lhs.item[2][0] * rhs.item[0][2] + lhs.item[2][1] * rhs.item[1][2] + lhs.item[2][2] * rhs.item[2][2] + lhs.item[2][3] * rhs.item[3][2];
    outResult.item[2][3] = lhs.item[2][0] * rhs.item[0][3] + lhs.item[2][1] * rhs.item[1][3] + lhs.item[2][2] * rhs.item[2][3] + lhs.item[2][3] * rhs.item[3][3];
    outResult.item[3][0] = lhs.item[3][0] * rhs.item[0][0] + lhs.item[3][1] * rhs.item[1][0] + lhs.item[3][2] * rhs.item[2][0] + lhs.item[3][3] * rhs.item[3][0];
    outResult.item[3][1] = lhs.item[3][0] * rhs.item[0][1] + lhs.item[3][1] * rhs.item[1][1] + lhs.item[3][2] * rhs.item[2][1] + lhs.item[3][3] * rhs.item[3][1];
    outResult.item[3][2] = lhs.item[3][0] * rhs.item[0][2] + lhs.item[3][1] * rhs.item[1][2] + lhs.item[3][2] * rhs.item[2][2] + lhs.item[3][3] * rhs.item[3][2];
    outResult.item[3][3] = lhs.item[3][0] * rhs.item[0][3] + lhs.item[3][1] * rhs.item[1][3] + lhs.item[3][2] * rhs.item[2][3] + lhs.item[3][3] * rhs.item[3][3];
//    /**矩阵乘法的记忆方法：row行col列的结果是由左边矩阵的row行中的0123列四个数分别去乘以右边矩阵的col列中的0123行的四个数 */
//    for (int row = 0; row < 4; row++) {
//        for (int col = 0; col < 4; col++) {
//            outResult.item[row][col] = lhs.item[row][0] * rhs.item[0][col] + lhs.item[row][1] * rhs.item[1][col] + lhs.item[row][2] * rhs.item[2][col] + lhs.item[row][3] * rhs.item[3][col];
//        }
//    }
}
