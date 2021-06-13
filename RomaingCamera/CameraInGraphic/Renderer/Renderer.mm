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
#include "Camera.h"

typedef enum {
    forwardArrow = 1,
    backArrow = 2,
    leftArrow = 3,
    rightArrow = 4,
    rotatePositiveY = 5,
    rotateNegativeY = 6,
}keyName;

@implementation Renderer
{
    id <MTLDevice> _device;
    id <MTLCommandQueue> _commandQueue;
    id <MTLRenderPipelineState> _pipelineState;
    vector_uint2 _viewportSize;
    id <MTLBuffer> _uniformBuffer;
    id<MTLBuffer> _indicesBuffer;
    Uniforms* uniform;
    Camera* camera;
}

-(nonnull instancetype)initWithMetalKitView:(nonnull MTKView *)view;
{
    self = [super init];
    if(self)
    {
        NSError* error;
        _device = view.device;
        _viewportSize.x = view.drawableSize.width;
        _viewportSize.y = view.drawableSize.height;
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
        // 创建uniform buffer
        _uniformBuffer = [_device newBufferWithLength:sizeof(Uniforms) options:MTLResourceStorageModeShared];
        
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
        // 创建摄像机
        camera = new Camera(_viewportSize.x, _viewportSize.y);
        camera->position = Vector3f(0.0f,0.0f,-1000.0f);
        camera->near = 1.0f;
        camera->far = 1500.0f;
        camera->aspectRatio = (float)_viewportSize.x/(float)_viewportSize.y;
        camera->target = Vector3f(0,0,0);
        camera->up = Vector3f(0,1,0);
    }
    
    return self;
}


- (void)drawInMTKView:(nonnull MTKView *)view
{
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
    [self updateCameraState];
    
    id<MTLCommandBuffer> commandBuffer = [_commandQueue commandBuffer];
    commandBuffer.label = @"EwanCommand";
    MTLRenderPassDescriptor *renderPassDescriptor = view.currentRenderPassDescriptor;
    if (renderPassDescriptor != nil) {
        id<MTLRenderCommandEncoder> renderEncoder = [commandBuffer renderCommandEncoderWithDescriptor:renderPassDescriptor];
        renderEncoder.label = @"EwanRenderEncoder";
        [renderEncoder setFrontFacingWinding:MTLWindingClockwise];
        [renderEncoder setCullMode:MTLCullModeBack];
        [renderEncoder setRenderPipelineState:_pipelineState];
        [renderEncoder setVertexBuffer:_uniformBuffer offset:0 atIndex:1];
        [renderEncoder setVertexBytes:triangleVertices length:sizeof(triangleVertices) atIndex:0];
        [renderEncoder drawIndexedPrimitives:MTLPrimitiveTypeTriangle indexCount:36 indexType:MTLIndexTypeUInt16 indexBuffer:_indicesBuffer indexBufferOffset:0];
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
-(void)dealloc
{
    delete camera;
    delete uniform;
}
- (void)sendKeboardValue:(int)keycode
{
    switch (keycode) {
        case forwardArrow:
            camera->position.z += 10.0f;
            break;
        case backArrow:
            camera->position.z -= 10.0f;
            break;
        case leftArrow:
            camera->position.x -= 10.0f;
            break;
        case rightArrow:
            camera->position.x += 10.0f;
            break;
        case rotatePositiveY:
            camera->rotation.y -= 10.0f;
            break;
        case rotateNegativeY:
            camera->rotation.y += 10.0f;
            break;
        default:
            break;
    }
}
-(void)updateCameraState
{
    uniform = (Uniforms*)_uniformBuffer.contents;
    camera->rotation.x += 1.0f;
    uniform->modelMatrix = camera->getModelMatrix().transNativeMatrix();
    uniform->viewMatrix = camera->getViewMatrix().transNativeMatrix();
    uniform->projectinMatrix = camera->getProjectioMatrix().transNativeMatrix();
    //uniform->projectinMatrix = camera->getOrthonormalMatrix().transNativeMatrix();
}
@end
