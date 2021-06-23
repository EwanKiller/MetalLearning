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
@property bool xAxis;
@property bool yAxis;
@property bool zAxis;
@property float scale;
-(nonnull instancetype)initWithMetalKitView:(nonnull MTKView*)view;

@end

#endif /* Renderer_h */
