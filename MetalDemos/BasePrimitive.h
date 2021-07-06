//
//  BasePrimitive.hpp
//  MetalDemos
//
//  Created by ThisEwan on 2021/7/5.
//

#ifndef BasePrimitive_h
#define BasePrimitive_h
#include "Vec3.h"
#include "Vec4.h"
#include <simd/simd.h>
#include <MacTypes.h>
#include "ShaderTypes.h"


class Cube
{
public:
    Cube() = delete;
    Cube(Vec3 center, float lengthOfSide);
    ~Cube() = default;
    
    Vertex vertices[8];
    UInt16 indices[36];
};

#endif /* BasePrimitive_h */
