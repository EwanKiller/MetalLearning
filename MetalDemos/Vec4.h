//
//  Vec4.hpp
//  MetalDemos
//
//  Created by ThisEwan on 2021/6/18.
//

#ifndef Vec4_h
#define Vec4_h
#include <simd/simd.h>

class Vec4 {
public:
    float x;
    float y;
    float z;
    float w;
    
    Vec4();
    ~Vec4();
    Vec4(const float x,const float y,const float z,const float w);
    Vec4(const float *array);
    Vec4(const Vec4& vec);
    
    Vec4 operator-(const Vec4& vec) const;
    simd_float4 transformSimdVec4f() const;
};
#endif /* Vec4_h */
