//
//  ZYFRefreshHeader.m
//  百思不得姐
//
//  Created by HH on 2017/10/14.
//  Copyright © 2017年 HH. All rights reserved.
//

#import "ZYFRefreshHeader.h"

@implementation ZYFRefreshHeader

-(void)prepare
{
    [super prepare];
    self.automaticallyChangeAlpha = YES;
    [self setTitle:@"赶紧下拉吧" forState:MJRefreshStateIdle];
    [self setTitle:@"赶紧松开吧" forState:MJRefreshStatePulling];
    [self setTitle:@"正在加载数据..." forState:MJRefreshStateRefreshing];
    // self.lastUpdatedTimeLabel.hidden = YES;
    // self.stateLabel.hidden = YES;

    
    
  
}

@end
