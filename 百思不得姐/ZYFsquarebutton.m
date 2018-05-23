//
//  ZYFsquarebutton.m
//  百思不得姐
//
//  Created by HH on 2017/10/10.
//  Copyright © 2017年 HH. All rights reserved.
//

#import "ZYFsquarebutton.h"
#import "UIView+ZYFUIview.h"
@implementation ZYFsquarebutton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame])
        {
            //不变的设置放在初始化方法里
            self.titleLabel.textAlignment=NSTextAlignmentCenter;
            [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
      
            [self setBackgroundImage:[UIImage imageNamed:@"mainCellBackground"] forState:UIControlStateNormal];
            self.titleLabel.font=[UIFont systemFontOfSize:13];

            //为什么不是用这个设置字体颜色
            // self.titleLabel.textColor=[UIColor blackColor];
          }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    //设置按钮图片位置、大小
    self.imageView.zyf_y=self.zyf_height*0.15;
    self.imageView.zyf_height=self.zyf_height*0.5;
    self.imageView.zyf_width=self.imageView.zyf_height;
    self.imageView.zyf_cnterX=self.zyf_width*0.5;
    
    //设置文字位置、大小
    self.titleLabel.zyf_x=0;
    self.titleLabel.zyf_y=self.imageView.zyf_y+self.imageView.zyf_height;
    self.titleLabel.zyf_width=self.zyf_width;
    self.titleLabel.zyf_height =self.zyf_height-self.titleLabel.zyf_y;
}

@end
