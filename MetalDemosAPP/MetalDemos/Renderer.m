//
//  Renderer.m
//  MetalDemos
//
//  Created by ThisEwan on 2021/6/19.
//
#import <simd/simd.h>
#import "Renderer.h"

@implementation Renderer
{
    id<MTLDevice> _device;
    id<MTLCommandQueue> _commandQueue;
    id<MTLRenderPipelineState> _renderPipelineState;
    vector_uint2 _viewportSize;
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
    }
    return self;
}
-(void)drawInMTKView:(MTKView *)view
{
    
}
-(void)mtkView:(MTKView *)view drawableSizeWillChange:(CGSize)size
{
    _viewportSize.x = size.width;
    _viewportSize.y = size.height;
}
@end
