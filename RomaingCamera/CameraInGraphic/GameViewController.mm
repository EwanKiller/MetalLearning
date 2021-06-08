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
    
    Camera* camera = new Camera;
    Vector3f a = Vector3f(0,0,-10);
    Vector3f b = Vector3f(0,0,5);
    Vector3f c = Vector3f(0,1,0);
    Matrix4x4f mat;
    mat =  camera->getViewMatrix(a, b, c);
    Matrix4x1f point = Matrix4x1f(3.0f,1.0f,2.0f,1.0f);
    Matrix4x1f end = Matrix4x1f();
    Matrix4x4f::multiply(mat, point, end);
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
}
- (void)backwardButtonPressed
{
    NSLog(@"backwards!");
}
- (void)leftwardButtonPressed
{
    NSLog(@"leftwards!");
}
- (void)rightwardButtonPressed
{
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
