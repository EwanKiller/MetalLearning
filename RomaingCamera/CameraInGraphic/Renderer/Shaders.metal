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
    out.color = vertices[vertexID].color;
    return out;
}

fragment float4
fragmentShader(VertexData in [[stage_in]])
{
    return in.color;
}
