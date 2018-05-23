//
//  ZYFNewViewCont.m
//  百思不得姐
//
//  Created by HH on 2017/10/2.
//  Copyright © 2017年 HH. All rights reserved.
//

#import "ZYFNewViewCont.h"
#import "UIBarButtonItem+ZYFUIBarButtonItem.h"
@implementation ZYFNewViewCont

-(void)viewDidLoad
{
    [super viewDidLoad];
    ZYFLog(@"%s",__func__);
    self.view.backgroundColor= ZYFRa4ndomColor;
    self.navigationItem.titleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MainTitle"]];
  
self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon"
                                                                                     target:self heightImage:@"MainTagSubIconClick"  action:@selector(tagClick)];
}
-(void)tagClick
{
    ZYFLog(@"%s",__func__);
}
@end
