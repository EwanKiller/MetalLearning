//
//  TransformSceneViewControllerOC.m
//  MetalDemos
//
//  Created by ThisEwan on 2021/6/21.
//
#import "TransformSceneViewControllerOC.h"
#import <Foundation/Foundation.h>
#import <Metal/Metal.h>
#import <MetalKit/MetalKit.h>
#import "TransformSceneRenderer.h"

@implementation TransformSceneViewControllerOC
{
    MTKView *_mtkView;
    TransformSceneRenderer *_renderer;
}

-(void)onViewDidload:(UIViewController *)vc
{
    _mtkView = (MTKView *)vc.view;
    _mtkView.device = MTLCreateSystemDefaultDevice();
    _mtkView.backgroundColor = UIColor.blackColor;
    if (!_mtkView.device) {
        NSLog(@"Metal is not supported on this device");
        vc.view = [[UIView alloc] initWithFrame:vc.view.frame];
        return;
    }
    _renderer = [[TransformSceneRenderer alloc] initWithMetalKitView:_mtkView];
    [_renderer mtkView:_mtkView drawableSizeWillChange:_mtkView.bounds.size];
    _mtkView.delegate = _renderer;
}

- (void)switchRotateX:(BOOL)isOn
{
    _renderer.xAxis = isOn;
}
-(void)switchRotateY:(BOOL)isOn
{
    _renderer.yAxis = isOn;
}
-(void)switchRotateZ:(BOOL)isOn
{
    _renderer.zAxis = isOn;
}
-(void)scaleModel:(float)scale
{
    _renderer.scale = scale;
}
@end
