//
//  Matrix.hpp
//  CameraInGraphic
//
//  Created by ThisEwan on 2021/6/6.
//
/**
 column matrix
 */
#ifndef Matrix_h
#define Matrix_h

class Matrix4x1f{
public:
    float col[4];
    
    Matrix4x1f();
    ~Matrix4x1f();
    Matrix4x1f(float x, float y, float z, float w);
    Matrix4x1f& operator>>(const float item[]);
};

class Matrix4x4f{
public:
    // [row][column]
    float item[4][4];
    Matrix4x4f();
    /** column matrix but write in as row matrix for float array*/
    Matrix4x4f& operator>>(const float item[]);
    
    static void multiply(const Matrix4x4f &lhs, const Matrix4x1f &rhs, Matrix4x1f &outResult);
    static void multiply(const Matrix4x4f &lhs, const Matrix4x4f &rhs, Matrix4x4f &outResult);
};

#endif /* Matrix_hpp */
