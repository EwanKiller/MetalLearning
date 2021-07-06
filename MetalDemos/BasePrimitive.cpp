//
//  BasePrimitive.cpp
//  MetalDemos
//
//  Created by ThisEwan on 2021/7/5.
//

#include "BasePrimitive.h"

Cube::Cube(Vec3 center, float lengthOfSide)
{
    float half = lengthOfSide * 0.5f;
    vertices[0].position = Vec4(center.x - half, center.y + half, center.z - half, 1.0f).transformSimdVec4f();
    vertices[0].color = Vec4(0.0f, 1.0f, 1.0f, 1.0f).transformSimdVec4f();
    vertices[1].position = Vec4(center.x + half, center.y + half, center.z - half, 1.0f).transformSimdVec4f();
    vertices[1].color = Vec4(0.0f, 0.0f, 1.0f, 1.0f).transformSimdVec4f();
    vertices[2].position = Vec4(center.x + half, center.y - half, center.z - half, 1.0f).transformSimdVec4f();
    vertices[2].color = Vec4(1.0f, 0.0f, 1.0f, 1.0f).transformSimdVec4f();
    vertices[3].position = Vec4(center.x - half, center.y - half, center.z - half, 1.0f).transformSimdVec4f();
    vertices[3].color = Vec4(1.0f, 1.0f, 1.0f, 1.0f).transformSimdVec4f();
    vertices[4].position = Vec4(center.x + half, center.y + half, center.z + half, 1.0f).transformSimdVec4f();
    vertices[4].color = Vec4(0.0f, 1.0f, 0.0f, 1.0f).transformSimdVec4f();
    vertices[5].position = Vec4(center.x - half, center.y + half, center.z + half, 1.0f).transformSimdVec4f();
    vertices[5].color = Vec4(0.0f, 0.0f, 0.0f, 1.0f).transformSimdVec4f();
    vertices[6].position = Vec4(center.x - half, center.y - half, center.z + half, 1.0f).transformSimdVec4f();
    vertices[6].color = Vec4(1.0f, 0.0f, 0.0f, 1.0f).transformSimdVec4f();
    vertices[7].position = Vec4(center.x + half, center.y - half, center.z + half, 1.0f).transformSimdVec4f();
    vertices[7].color = Vec4(1.0f, 1.0f, 0.0f, 1.0f).transformSimdVec4f();
    
    indices[0] = 0;
    indices[1] = 1;
    indices[2] = 2;
    indices[3] = 2;
    indices[4] = 3;
    indices[5] = 0;
    
    indices[6] = 4;
    indices[7] = 5;
    indices[8] = 6;
    indices[9] = 6;
    indices[10] = 7;
    indices[11] = 4;
    
    indices[12] = 0;
    indices[13] = 3;
    indices[14] = 6;
    indices[15] = 6;
    indices[16] = 5;
    indices[17] = 0;
    
    indices[18] = 1;
    indices[19] = 4;
    indices[20] = 7;
    indices[21] = 7;
    indices[22] = 2;
    indices[23] = 1;
    
    indices[24] = 0;
    indices[25] = 5;
    indices[26] = 4;
    indices[27] = 4;
    indices[28] = 1;
    indices[29] = 0;
    
    indices[30] = 3;
    indices[31] = 2;
    indices[32] = 7;
    indices[33] = 7;
    indices[34] = 6;
    indices[35] = 3;
}
