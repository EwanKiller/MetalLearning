# Camera In Graphic

- Project info
  - IDE : Xcode 12
  - ios - Game ;
  - Language ： Object - C ;
  - Game Technology： Metal ;
  - iOS Development Target ： 14.1 ;
- Project Description
  - Implement a roaming camera in 3D world ;
  - Roaming camera circles the target ;
  - iOS native UI control the camera ;

## 实现的功能

1. iOS native UI Button的响应事件；

- GameViewController.m  - (void) addMoveButton

2. iOS屏幕的点击事件；

- GameViewController.m  - (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *) event

## 项目总结

1. iOS的原生 UI Button ；

   - 创建UI Button的流程是：

     ```objective-c
     // 声明一个 UIButton*
     UIButton* buttonForwards = [UIButton buttonWithType:UIButtonTypeRoundedRect];
     // 设置Button的背景颜色
     buttonForwards.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
     // 设置Button 在view里的相对位置（x,y,width,height）
     [buttonForwards setFrame:CGRectMake(120, 350, 80, 60)];
     // setTitle 设置Button的显示名称
     // UIControlStateNormal代表平常状态
     // UIControlStateHighlighted代表被点击时的高亮状态
     [buttonForwards setTitle:@"forward" forState:UIControlStateNormal];
     [buttonForwards setTitle:@"pressed" forState:UIControlStateHighlighted];
     // 设置点击响应事件 selector内是事件响应的回调函数，forControlEvents是触发事件的种类
     [buttonForwards addTarget:self action:@selector(forwardButtonPressed) forControlEvents:UIControlEventTouchUpInside];
     // 最后需要把Button 添加到一个view下
     [self.view addSubview:buttonForwards];
     ```

2. 屏幕的点击事件：

   - 在继承了UIViewController的脚本中，实现如下方法

     ```objective-c
     	// 触摸开始
     - (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
       // 触摸结束
     - (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
       // 触摸移动
     - (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
       // 触摸取消
     - (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
     ```

     
