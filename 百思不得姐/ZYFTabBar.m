//
//  ZYFTabBar.m
//  百思不得姐
//
//  Created by HH on 2017/10/1.
//  Copyright © 2017年 HH. All rights reserved.
//

#import "ZYFTabBar.h"
#import "UIView+ZYFUIview.h"
@interface ZYFTabBar()

/** 中间的发布按钮 */
@property (nonatomic, weak) UIButton *publishButton;
@end

@implementation ZYFTabBar



-(instancetype)initWithFrame:(CGRect)frame
{
    if (self =[super initWithFrame:frame]) {
        self.backgroundImage = [UIImage imageNamed:@"tabbar-light"];
    }
    return self;
}


#pragma mark - 懒加载
/** 发布按钮 */
- (UIButton *)publishButton
{
    if (!_publishButton) {
        UIButton *publishButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [publishButton setImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [publishButton setImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        [publishButton addTarget:self action:@selector(publishClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:publishButton];
        _publishButton = publishButton;
    }
    return _publishButton;
}

#pragma mark - 初始化
/**
 *  布局子控件
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // NSClassFromString(@"UITabBarButton") == [UITabBarButton class]
    // NSClassFromString(@"UIButton") == [UIButton class]
    
    /**** 设置所有UITabBarButton的frame ****/
    // 按钮的尺寸
    CGFloat buttonW = self.zyf_width / 5;
    CGFloat buttonH = self.zyf_height;
    CGFloat buttonY = 0;
    // 按钮索引
    int buttonIndex = 0;
    
    for (UIView *subview in self.subviews) {
        // 过滤掉非UITabBarButton
        //        if (![@"UITabBarButton" isEqualToString:NSStringFromClass(subview.class)]) continue;
        if (subview.class != NSClassFromString(@"UITabBarButton")) continue;
        
        // 设置frame
        CGFloat buttonX = buttonIndex * buttonW;
        if (buttonIndex >= 2) { // 右边的2个UITabBarButton
            buttonX += buttonW;
        }
        subview.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        
        // 增加索引
        buttonIndex++;
    }
    
    /**** 设置中间的发布按钮的frame ****/
    self.publishButton.zyf_width = buttonW;
    self.publishButton.zyf_height = buttonH;
    self.publishButton.center = CGPointMake(self.zyf_width * 0.5, self.zyf_height * 0.5);
}

#pragma mark - 监听
- (void)publishClick
{
    ZYFLog(@"12334");
}


@end
