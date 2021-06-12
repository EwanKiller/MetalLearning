//
//  GameViewController.m
//  CameraInGraphic
//
//  Created by ThisEwan on 2021/5/31.
//

#import "GameViewController.h"
#import "Renderer.h"
#import "Matrix.h"
#import "Camera.h"
#import "Vector.h"
#import <eigen3/Eigen/Eigen>

@implementation GameViewController
{
    MTKView *_view;

    Renderer *_renderer;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    _view = (MTKView *)self.view;

    _view.device = MTLCreateSystemDefaultDevice();

    if(!_view.device)
    {
        NSLog(@"Metal is not supported on this device");
        self.view = [[UIView alloc] initWithFrame:self.view.frame];
        return;
    }

    _renderer = [[Renderer alloc] initWithMetalKitView:_view];

    [_renderer mtkView:_view drawableSizeWillChange:_view.drawableSize];

    _view.delegate = _renderer;
    
    [self addMoveButton];
}

- (void)addMoveButton
{
    // forward button
    UIButton* buttonForwards = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    buttonForwards.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    [buttonForwards setFrame:CGRectMake(120, 350, 80, 60)];
    [buttonForwards setTitle:@"forward" forState:UIControlStateNormal];
    [buttonForwards setTitle:@"pressed" forState:UIControlStateHighlighted];
    [buttonForwards addTarget:self action:@selector(forwardButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonForwards];
    
    // backward button
    UIButton* buttonBackwards = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    buttonBackwards.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    [buttonBackwards setFrame:CGRectMake(120, 420, 80, 60)];
    [buttonBackwards setTitle:@"backwards" forState:UIControlStateNormal];
    [buttonBackwards setTitle:@"pressed" forState:UIControlStateHighlighted];
    [buttonBackwards addTarget:self action:@selector(backwardButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonBackwards];
    
    // leftward button
    UIButton* buttonLeftwards = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    buttonLeftwards.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
    [buttonLeftwards setFrame:CGRectMake(30, 385, 80, 60)];
    [buttonLeftwards setTitle:@"leftwards" forState:UIControlStateNormal];
    [buttonLeftwards setTitle:@"pressed" forState:UIControlStateHighlighted];
    [buttonLeftwards addTarget:self action:@selector(leftwardButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonLeftwards];
    
    // rightward button
    UIButton* buttonRightwards = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    buttonRightwards.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
    [buttonRightwards setFrame:CGRectMake(210, 385, 80, 60)];
    [buttonRightwards setTitle:@"rightwards" forState:UIControlStateNormal];
    [buttonRightwards setTitle:@"pressed" forState:UIControlStateHighlighted];
    [buttonRightwards addTarget:self action:@selector(rightwardButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonRightwards];
}

- (void)forwardButtonPressed
{
    NSLog(@"forwards!");
    [_renderer sendKeboardValue:1];
}
- (void)backwardButtonPressed
{
    NSLog(@"backwards!");
    [_renderer sendKeboardValue:2];
}
- (void)leftwardButtonPressed
{
    NSLog(@"leftwards!");
    [_renderer sendKeboardValue:3];
}
- (void)rightwardButtonPressed
{
    [_renderer sendKeboardValue:4];
    NSLog(@"rightwards");
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch* touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.view];
    NSLog(@"xg:%f,yg:%f",point.x,point.y);
}
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
}
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
}
-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
}
@end
