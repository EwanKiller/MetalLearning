//
//  Renderer.m
//  CameraInGraphic
//
//  Created by ThisEwan on 2021/5/31.
//

#import <simd/simd.h>

#import "Renderer.h"

// Include header shared between C code here, which executes Metal API commands, and .metal files
#import "ShaderTypes.h"
#import "Rectangle.h"


@implementation Renderer
{
    id <MTLDevice> _device;
    id <MTLCommandQueue> _commandQueue;
    id <MTLRenderPipelineState> _pipelineState;
    vector_uint2 _viewportSize;
}

-(nonnull instancetype)initWithMetalKitView:(nonnull MTKView *)view;
{
    self = [super init];
    if(self)
    {
        NSError* error;
        _device = view.device;
        id<MTLLibrary> defaultLibrary = [_device newDefaultLibrary];
        id<MTLFunction> vertexFunction = [defaultLibrary newFunctionWithName:@"vertexShader"];
        id<MTLFunction> fragmentFunction = [defaultLibrary newFunctionWithName:@"fragmentShader"];
        MTLRenderPipelineDescriptor *pipelineStateDescriptor = [[MTLRenderPipelineDescriptor alloc] init];
        pipelineStateDescriptor.label = @"draw a triangle";
        pipelineStateDescriptor.vertexFunction = vertexFunction;
        pipelineStateDescriptor.fragmentFunction = fragmentFunction;
        // 一个attachments数组来存储颜色信息，设置颜色的像素格式为view的颜色像素格式
        pipelineStateDescriptor.colorAttachments[0].pixelFormat = view.colorPixelFormat;
        // 返回并创建渲染管线状态对象
        _pipelineState = [_device newRenderPipelineStateWithDescriptor:pipelineStateDescriptor error:&error];
        if (!_pipelineState) { // 渲染管线状态设置错误的话，会创建失败
            NSLog(@"Failed to create pipeline state, error %@", error);
        }
        // 创建指令队列
        _commandQueue = [_device newCommandQueue];
    }

    return self;
}


- (void)drawInMTKView:(nonnull MTKView *)view
{
    static const Vertex triangleVertices[] =
    {
        // 3D positions,    RGBA colors
        { { -100.0, 100.0, 100, 1.0 }, { 1, 0, 0, 1 } },
        { { 100.0 , 100.0, 100, 1.0 }, { 0, 1, 0, 1 } },
        { { 100.0, -100.0, 100, 1.0 }, { 0, 0, 1, 1 } },
        { { -100.0, -100.0, 100, 1.0 }, { 1, 0, 0, 1 } },
        { { 100.0 , 100.0, 100, 1.0 }, { 0, 1, 0, 1 } },
        { { -100.0, 100.0, 100, 1.0 }, { 1, 0, 0, 1 } },
        { { -100.0, -100.0, 100, 1.0 }, { 1, 0, 0, 1 } },
        { { 100.0, -100.0, 100, 1.0 }, { 0, 0, 1, 1 } },
    };
    static const UInt16 indices[] =
    {
        0, 1, 2, 2, 3, 0, // front
        4, 5, 6, 6, 7 ,4, // back
        0, 3, 7, 7, 5, 0, // left
        1, 4, 7, 7, 2, 1, // right
        0, 5, 4, 4, 1, 0, // top
        3, 2, 7, 7, 6, 3, // bottom
    };
    
    id<MTLCommandBuffer> commandBuffer = [_commandQueue commandBuffer];
    commandBuffer.label = @"EwanCommand";
    MTLRenderPassDescriptor *renderPassDescriptor = view.currentRenderPassDescriptor;
    
    if (renderPassDescriptor != nil) {
        id<MTLRenderCommandEncoder> renderEncoder = [commandBuffer renderCommandEncoderWithDescriptor:renderPassDescriptor];
        renderEncoder.label = @"EwanRenderEncoder";
        [renderEncoder setViewport:(MTLViewport){0.0, 0.0, _viewportSize.x, _viewportSize.y, 0.0, 1.0 }];
        [renderEncoder setRenderPipelineState:_pipelineState];
        [renderEncoder setVertexBytes:triangleVertices length:sizeof(triangleVertices) atIndex:VertexInputIndexVertices];
        [renderEncoder setVertexBytes:&_viewportSize length:sizeof(_viewportSize) atIndex:VertexInputIndexViewportSize];
        //[renderEncoder drawPrimitives:MTLPrimitiveTypeTriangle vertexStart:0 vertexCount:6];
        id<MTLBuffer> indicesBuffer = [_device newBufferWithBytes:indices length:sizeof(indices) options:MTLResourceStorageModeShared];
        [renderEncoder drawIndexedPrimitives:MTLPrimitiveTypeTriangle indexCount:36 indexType:MTLIndexTypeUInt16 indexBuffer:indicesBuffer indexBufferOffset:0];
        [renderEncoder endEncoding];
        [commandBuffer presentDrawable:view.currentDrawable];
    }
    [commandBuffer commit];
}

- (void)mtkView:(nonnull MTKView *)view drawableSizeWillChange:(CGSize)size
{
    _viewportSize.x = size.width;
    _viewportSize.y = size.height;
}

@end
