//
//  Renderer.h
//  MetalDemos
//
//  Created by ThisEwan on 2021/6/19.
//

#ifndef Renderer_h
#define Renderer_h
#import <MetalKit/MetalKit.h>

@interface Renderer : NSObject<MTKViewDelegate>

-(nonnull instancetype)initWithMetalKitView:(nonnull MTKView*)view;

@end

#endif /* Renderer_h */
