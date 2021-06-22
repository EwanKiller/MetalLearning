//
//  Renderer.m
//  MetalDemos
//
//  Created by ThisEwan on 2021/6/19.
//
#import <simd/simd.h>
#import "TransformSceneRenderer.h"
#import "Vec3.hpp"
#import "Mat4.hpp"
#import "Camera.hpp"

@implementation TransformSceneRenderer
{
    id<MTLDevice> _device;
    id<MTLCommandQueue> _commandQueue;
    id<MTLRenderPipelineState> _renderPipelineState;
    vector_uint2 _viewportSize;
    id<MTLBuffer> _vertexBuffer;
    id<MTLBuffer> _indicesBuffer;
    id<MTLBuffer> _uniformBuffer;
    Uniforms *uniform;
    Camera* camera;
    float modelRotation;
}

-(nonnull instancetype)initWithMetalKitView:(nonnull MTKView *)view;
{
    self = [super init];
    if (self) {
        NSError *error;
        _device = view.device;
        _viewportSize.x = view.drawableSize.width;
        _viewportSize.y = view.drawableSize.height;
        id<MTLLibrary> defaultLibrary = [_device newDefaultLibrary];
        id<MTLFunction> vertexFunction = [defaultLibrary newFunctionWithName:@"vertexShader"];
        id<MTLFunction> fragmentFunction = [defaultLibrary newFunctionWithName:@"fragmentShader"];
        MTLRenderPipelineDescriptor* pipelineDescriptor = [[MTLRenderPipelineDescriptor alloc] init];
        pipelineDescriptor.label = @"draw a 3D Cube";
        pipelineDescriptor.vertexFunction = vertexFunction;
        pipelineDescriptor.fragmentFunction = fragmentFunction;
        pipelineDescriptor.colorAttachments[0].pixelFormat = view.colorPixelFormat;
        _renderPipelineState = [_device newRenderPipelineStateWithDescriptor:pipelineDescriptor error:&error];
        if (!_renderPipelineState) {
            NSLog(@"Failed to create pipeline state, error %@", error);
        }
        _commandQueue = [_device newCommandQueue];
        
        static const Vertex triangleVertices[] =
        {
            // 3D positions,    RGBA colors
            { { -200.0, 200.0, -200.0f, 1.0 }, { 0, 1, 1, 1 } },
            { { 200.0 , 200.0, -200.0f, 1.0 }, { 0, 0, 1, 1 } },
            { { 200.0, -200.0, -200.0f, 1.0 }, { 1, 0, 1, 1 } },
            { { -200.0, -200.0, -200.0f, 1.0 }, { 1, 1, 1, 1 } },
            { { 200.0 , 200.0, 200.0f, 1.0 }, { 0, 1, 0, 1 } },
            { { -200.0, 200.0, 200.0f, 1.0 }, { 0, 0, 0, 1 } },
            { { -200.0, -200.0, 200.0f, 1.0 }, { 1, 0, 0, 1 } },
            { { 200.0, -200.0, 200.0, 1.0 }, { 1, 1, 0, 1 } },
        };
        
        _vertexBuffer = [_device newBufferWithBytes:triangleVertices length:sizeof(triangleVertices) options:MTLStorageModeShared];
        
        static const UInt16 indices[] =
        {
            0, 1, 2, 2, 3, 0, // front
            4, 5, 6, 6, 7, 4, // back
            0, 3, 6, 6, 5, 0, // left
            1, 4, 7, 7, 2, 1, // right
            0, 5, 4, 4, 1, 0, // top
            3, 2, 7, 7, 6, 3, // bottom
        };
        
        _indicesBuffer = [_device newBufferWithBytes:indices length:sizeof(indices) options:MTLResourceStorageModeShared];
        
        _uniformBuffer = [_device newBufferWithLength:sizeof(Uniforms) options:MTLResourceStorageModeShared];
        
        [self initCamera];
    }
    return self;
}
-(void)drawInMTKView:(MTKView *)view
{
    [self updateMVPMatrix];
    
    id<MTLCommandBuffer> commandBuffer = [_commandQueue commandBuffer];
    commandBuffer.label = @"TransformSceneCommandBuffer";
    MTLRenderPassDescriptor *renderPassDescripter = view.currentRenderPassDescriptor;
    if(renderPassDescripter != nil) {
        id<MTLRenderCommandEncoder> commandEncoder = [commandBuffer renderCommandEncoderWithDescriptor:renderPassDescripter];
        commandEncoder.label = @"TransformSceneCommandEncoder";
        [commandEncoder setFrontFacingWinding:MTLWindingClockwise];
        [commandEncoder setCullMode:MTLCullModeBack];
        [commandEncoder setRenderPipelineState:_renderPipelineState];
        [commandEncoder setVertexBuffer:_vertexBuffer offset:0 atIndex:VertexInputIndexVertices];
        [commandEncoder setVertexBuffer:_indicesBuffer offset:0 atIndex:VertextInputIndexIndices];
        [commandEncoder setVertexBuffer:_uniformBuffer offset:0 atIndex:VertexInputIndexUniforms];
        [commandEncoder drawIndexedPrimitives:MTLPrimitiveTypeTriangle indexCount:36 indexType:MTLIndexTypeUInt16 indexBuffer:_indicesBuffer indexBufferOffset:0];
        [commandEncoder endEncoding];
        [commandBuffer presentDrawable:view.currentDrawable];
    }
    [commandBuffer commit];
}

-(void)mtkView:(MTKView *)view drawableSizeWillChange:(CGSize)size
{
    _viewportSize.x = size.width;
    _viewportSize.y = size.height;
}

-(void)dealloc
{
    delete camera;
}

-(void)initCamera
{
    camera = new Camera(_viewportSize.x, _viewportSize.y);
    camera->position = Vec3(0.0f,0.0f,-1000.0f);
    camera->near = 1.0f;
    camera->far = 1500.0f;
    camera->aspectRatio = (float)_viewportSize.x/(float)_viewportSize.y;
    camera->target = Vec3(0,0,0);
    camera->up = Vec3(0,1,0);
}

-(void)updateMVPMatrix
{
    modelRotation += 1.0f;
    uniform = (Uniforms*)_uniformBuffer.contents;
    [self getModelMatrix:uniform];
    uniform->viewMatrix = camera->getViewMatrix().transNativeMatrix();
    uniform->projectinMatrix = camera->getProjectioMatrix().transNativeMatrix();
}

-(void)getModelMatrix:(Uniforms*)uniform
{
        Vec3 factor = Vec3(1.0f, 1.0f, 1.0f);
        Mat4 scaleM;
        float scaleItems[16] =
        {
            factor.x,0.0f,0.0f,0.0f,
            0.0f,factor.y,0.0f,0.0f,
            0.0f,0.0f,factor.z,0.0f,
            0.0f,0.0f,0.0f,1.0f,
        };
        scaleM>>scaleItems;
        float angle = modelRotation * (M_PI / 180.0f);
        Mat4 rotateXM;
        float rotateXItems[16] =
        {
            1.0f,0.0f,0.0f,0.0f,
            0.0f,cosf(angle),sinf(angle),0.0f,
            0.0f,-sinf(angle),cosf(angle),0.0f,
            0.0f,0.0f,0.0f,1.0f,
        };
        rotateXM>>rotateXItems;
        Vec3 offset = Vec3(0.0f,0.0f,0.0f);
        float translateItems[16] =
        {
            1.0f,0.0f,0.0f,offset.x,
            0.0f,1.0f,0.0f,offset.y,
            0.0f,0.0f,1.0f,offset.z,
            0.0f,0.0f,0.0f,1.0f,
        };
        Mat4 translateM;
        translateM>>translateItems;
    
        Mat4 modelMatrix;
        Mat4 sr;
        Mat4::multiply(rotateXM, scaleM, sr);
        Mat4::multiply(translateM, sr, modelMatrix);
        uniform->modelMatrix = modelMatrix.transNativeMatrix();
}

@end
