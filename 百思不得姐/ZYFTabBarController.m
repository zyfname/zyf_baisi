//
//  ZYFTabBarController.m
//  百思不得姐
//
//  Created by HH on 2017/9/30.
//  Copyright © 2017年 HH. All rights reserved.
//


#import "ZYFTabBarController.h"
#import "ZYFEssenceViewController.h"
#import "ZYFFollowViewController.h"
#import "ZYFMeViewController.h"
#import "ZYFNewViewCont.h"
#import "ZYFTabBar.h"
#import "ZYFNavController.h"
@interface ZYFTabBarController ()

@end

@implementation ZYFTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    /*文字属性*/
    //获取TabBarItem属性同意设置item属性
    UITabBarItem *item = [UITabBarItem appearance];
    
    //设置普通状态下的文字属性
    NSMutableDictionary *normalattrs = [NSMutableDictionary dictionary];
    normalattrs[NSForegroundColorAttributeName]=[UIColor grayColor];
    [item setTitleTextAttributes:normalattrs forState:UIControlStateNormal];
    
    //  设置选中状态下的文字属性
    NSMutableDictionary  *selectedAttrs = [NSMutableDictionary dictionary] ;
    selectedAttrs[NSForegroundColorAttributeName]=[UIColor darkGrayColor];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    //更滑TabBar
    [self setValue:[[ZYFTabBar alloc] init] forKeyPath:@"tabBar"];
    
    
    [self setUpOneChildViewController:[[ZYFNavController alloc]initWithRootViewController:[[ZYFEssenceViewController alloc]init]] title:@"精华" image:@"tabBar_essence_icon" selectImage:@"tabBar_essence_click_icon"] ;
    
    [self setUpOneChildViewController:[[ZYFNavController alloc]initWithRootViewController:[[ZYFNewViewCont alloc]init]] title:@"新帖" image:@"tabBar_new_icon" selectImage:@"tabBar_new_click_icon"];
    
   [self setUpOneChildViewController:[[ZYFNavController alloc]initWithRootViewController:[[ZYFFollowViewController alloc]init]] title:@"关注" image:@"tabBar_friendTrends_icon" selectImage:@"tabBar_friendTrends_click_icon"];
    
    
    [self setUpOneChildViewController:[[ZYFNavController alloc]initWithRootViewController:[[ZYFMeViewController alloc]init]] title:@"我" image:@"tabBar_me_icon" selectImage:@"tabBar_me_click_icon"];
    

  
    
    
}


/**
 
 为什么要在viewWillAppear：(BOOL)animated中添加发布按钮？
 当viewWillAppear:方法被调用时候，tabbar内部已经添加了五个UITabBarButton
 就可以实现一个效果：【发布按钮】改在其他UITabBarbutoon上面
 **/


////可被调用多次-----使用一次性代码或懒加载
//-(void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        UIButton  *publishButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        [publishButton setImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
//        [publishButton setImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
//        publishButton.frame = CGRectMake(0, 0, self.tabBar.frame.size.width/5, self.tabBar.frame.size.height);
//        publishButton.center = CGPointMake(self.tabBar.frame.size.width*0.5, self.tabBar.frame.size.height*0.5);
//        [publishButton addTarget:self action:@selector(publishClick) forControlEvents:UIControlEventTouchUpInside];
//        [self.tabBar addSubview:publishButton];
//    });
//   
//}


-(void)publishClick{
    ZYFLog(@"%s",__func__);
}

//代码重构
/*
    初始化一个子控制器
    1.抽取相同代码
 */

-(void)setUpOneChildViewController:(UIViewController *)vc  title:(NSString *)title  image:(NSString *)image selectImage:(NSString *)selectImage
{
   
    vc.tabBarItem.title = title;
    if (image.length) {
        vc.tabBarItem.image=[UIImage imageNamed:image];
        vc.tabBarItem.selectedImage=[UIImage imageNamed:selectImage];
    }
    
    [self addChildViewController:vc];
}













@end
