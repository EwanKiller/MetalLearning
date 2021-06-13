//
//  ShaderTypes.h
//  CameraInGraphic
//
//  Created by ThisEwan on 2021/5/31.
//

//
//  Header containing types and enum constants shared between Metal shaders and Swift/ObjC source
//
#ifndef ShaderTypes_h
#define ShaderTypes_h

#ifdef __METAL_VERSION__
#define NS_ENUM(_type, _name) enum _name : _type _name; enum _name : _type
#define NSInteger metal::int32_t
#else
#import <Foundation/Foundation.h>
#endif

#include <simd/simd.h>

typedef enum VertexInputIndex
{
    VertexInputIndexVertices     = 0,
    VertexInputIndexUniforms = 1,
} VertexInputIndex;

typedef struct
{
    vector_float4 position;
    vector_float4 color;
} Vertex;

typedef struct
{
    matrix_float4x4 modelMatrix;
    matrix_float4x4 viewMatrix;
    matrix_float4x4 projectinMatrix;
} Uniforms;

#endif /* ShaderTypes_h */

