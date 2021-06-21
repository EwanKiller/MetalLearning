//
//  Renderer.h
//  MetalDemos
//
//  Created by ThisEwan on 2021/6/19.
//

#ifndef Renderer_h
#define Renderer_h
#import <MetalKit/MetalKit.h>
#import "ShaderTypes.h"

@interface TransformSceneRenderer : NSObject<MTKViewDelegate>

-(nonnull instancetype)initWithMetalKitView:(nonnull MTKView*)view;

@end

#endif /* Renderer_h */
