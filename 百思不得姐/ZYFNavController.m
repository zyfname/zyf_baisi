//
//  ZYFNavController.m
//  百思不得姐
//
//  Created by HH on 2017/10/6.
//  Copyright © 2017年 HH. All rights reserved.
//

#import "ZYFNavController.h"
@interface ZYFNavController() <UIGestureRecognizerDelegate>

@end


@implementation ZYFNavController



-(void)viewDidLoad
{
    [super viewDidLoad];
    
    
    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
    
    //获取右滑识别手势，设置代理，退出当前控制器
    self.interactivePopGestureRecognizer.delegate =self;
    
}

//重写方法，拦截所有push进来的子控制器
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if(self.childViewControllers.count>0){
        //如果viewController不是最早push进来的控制器
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"navigationButtonReturnClick"]  forState:UIControlStateHighlighted];
        [button setTitle:@"返回" forState:UIControlStateNormal];
        [ button setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        [button sizeToFit];
       
        //设置按钮的内边距，放在[button sizeToFit]之后
        button.contentEdgeInsets=UIEdgeInsetsMake(0,-20, 0, 0);
    
        [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc]initWithCustomView:button];
        //隐藏底部工具条
        viewController.hidesBottomBarWhenPushed=YES;
    }
    
    
    //所有设置搞定在push控制器
     [super pushViewController:viewController animated:animated];
    

}

/**
 手势识别器会调用这个方法来决定手势是否有效
 **/
-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    
    
//    return self.childViewControllers.count>1;
    
    //判断手势在哪个控制器使用
    if(self.childViewControllers.count==1){//导航控制器中只有一个子控制器
        return NO;
    }
    return YES;
}


-(void)back{
    [self popViewControllerAnimated:YES];
}


@end
