//
//  TransformSceneViewControllerOC.h
//  MetalDemos
//
//  Created by ThisEwan on 2021/6/21.
//

#import <UIKit/UIKit.h>

@interface TransformSceneViewControllerOC : NSObject

-(void)onViewDidload: (UIViewController *)view;
-(void)switchRotateX: (BOOL)isOn;
-(void)switchRotateY: (BOOL)isOn;
-(void)switchRotateZ: (BOOL)isOn;
-(void)scaleModel: (float)scale;
@end

