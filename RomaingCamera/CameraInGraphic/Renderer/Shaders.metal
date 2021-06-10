//
//  Shaders.metal
//  CameraInGraphic
//
//  Created by ThisEwan on 2021/5/31.
//

// File for Metal kernel and shader functions

#include <metal_stdlib>
#include <simd/simd.h>

// Including header shared between this Metal shader code and Swift/C code executing Metal API commands
#import "ShaderTypes.h"

using namespace metal;

struct VertexData
{
    float4 position [[position]];
    float4 color;
};

vertex VertexData
vertexShader(uint vertexID[[vertex_id]],constant Vertex *vertices [[buffer(VertexInputIndexVertices)]])
{
    VertexData out;
    out.position.x = vertices[vertexID].position.x/200;
    out.position.y = vertices[vertexID].position.y/200;
    out.position.z = vertices[vertexID].position.z/200;
    out.position.w = vertices[vertexID].position.w;
//    Matrix4x1f pos = Matrix4x1f(vertices[vertexID].position.x,vertices[vertexID].position.y,vertices[vertexID].position.z,vertices[vertexID].position.w);
//    Matrix4x4f mv;
//    Matrix4x4f::multiply(transInfo.viewMatrix, transInfo.modelMatrix, mv);
//    Matrix4x4f mvp;
//    Matrix4x4f::multiply(transInfo.projectinMatrix, mv, mvp);
//    Matrix4x1f outPos;
//    Matrix4x4f::multiply(mvp, pos, outPos);
//    out.position = float4(outPos.col[0],outPos.col[1],outPos.col[2],outPos.col[3]);
    out.color = vertices[vertexID].color;
    return out;
}

fragment float4
fragmentShader(VertexData in [[stage_in]])
{
    return in.color;
}
