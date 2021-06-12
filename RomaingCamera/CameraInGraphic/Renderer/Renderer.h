//
//  Renderer.h
//  CameraInGraphic
//
//  Created by ThisEwan on 2021/5/31.
//

#import <MetalKit/MetalKit.h>

// Our platform independent renderer class.   Implements the MTKViewDelegate protocol which
//   allows it to accept per-frame update and drawable resize callbacks.
@interface Renderer : NSObject <MTKViewDelegate>

-(nonnull instancetype)initWithMetalKitView:(nonnull MTKView *)view;

-(void)sendKeboardValue:(int)keycode;

@end

