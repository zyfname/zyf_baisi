//
//  UIBarButtonItem+ZYFUIBarButtonItem.m
//  百思不得姐
//
//  Created by HH on 2017/10/6.
//  Copyright © 2017年 HH. All rights reserved.
//

#import "UIBarButtonItem+ZYFUIBarButtonItem.h"

@implementation UIBarButtonItem (ZYFUIBarButtonItem)
+(UIBarButtonItem *)itemWithImage:(NSString *)image target:(id)target heightImage:(NSString *)heightImage action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [ button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [ button setImage:[UIImage imageNamed:heightImage] forState:UIControlStateHighlighted];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [button sizeToFit];
    
    return [[self alloc]initWithCustomView:button];
}
@end
