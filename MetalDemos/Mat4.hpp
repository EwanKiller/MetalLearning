//
//  Mat4.hpp
//  MetalDemos
//
//  Created by ThisEwan on 2021/6/18.
//

#ifndef Mat4_hpp
#define Mat4_hpp

#include <simd/simd.h>

class Mat4 {
public:
    float m[16];
    Mat4();
    ~Mat4();
    Mat4(const float m11, const float m12, const float m13, const float m14, const float m21, const float m22, const float m23, const float m24, const float m31, const float m32, const float m33, const float m34, const float m41, const float m42, const float m43, const float m44);
    Mat4(const float *array);
    Mat4(const Mat4 &mat);
    Mat4& operator>>(const float item[]);
    static void multiply(const Mat4 &lhs, const Mat4 &rhs, Mat4 &outResult);
    static const Mat4 IDENTITY;
    static const Mat4 ZERO;
    matrix_float4x4 transformToSimdMat();
};
#endif /* Mat4_hpp */
