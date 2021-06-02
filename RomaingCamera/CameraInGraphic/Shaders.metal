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
vertexShader(uint vertexID[[vertex_id]],constant Vertex *vertices [[buffer(0)]])
{
    VertexData out;
    out.position = vertices[vertexID].position;
    out.color = vertices[vertexID].color;
    return out;
}

fragment float4 fragmentShader(VertexData in [[stage_in]])
{
    return in.color;
}
