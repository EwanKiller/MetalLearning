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
vertexShader(uint vertexID[[vertex_id]],constant Vertex *vertices [[buffer(VertexInputIndexVertices)]],constant Uniforms *uniform [[buffer(VertexInputIndexUniforms)]])
{
    VertexData out;
    vector_float4 pos = vertices[vertexID].position;
    out.position =  uniform->projectinMatrix * uniform->viewMatrix * uniform->modelMatrix *pos;
//    out.position.x /= out.position.w;
//    out.position.y /= out.position.w;
//    out.position.z /= out.position.w;
//    out.position.w /= out.position.w;
    out.color = vertices[vertexID].color;
    return out;
}

fragment float4
fragmentShader(VertexData in [[stage_in]])
{
    return in.color;
}
