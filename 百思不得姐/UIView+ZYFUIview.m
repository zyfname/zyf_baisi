//
//  UIView+ZYFUIview.m
//  百思不得姐
//
//  Created by HH on 2017/10/2.
//  Copyright © 2017年 HH. All rights reserved.
//

#import "UIView+ZYFUIview.h"

@implementation UIView (ZYFUIview)


//加载与类同名xib
+(instancetype)viewFromXib
{
    return [[NSBundle mainBundle]  loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
    
}
-(CGFloat)zyf_width
{
    return self.frame.size.width;
}

-(CGFloat)zyf_height
{
    return self.frame.size.height;
}


-(CGFloat)zyf_x
{
    return self.frame.origin.x;
}

-(CGFloat)zyf_y
{
    return self.frame.origin.y;
}



-(CGFloat)zyf_centerY
{
    return self.center.y;
}


-(CGFloat)zyf_centerX
{
    return self.center.x;
}


-(CGSize)zyf_size
{
    return self.frame.size;
}





-(void)setZyf_size:(CGSize)zyf_size
{
    CGRect frame=self.frame;
    frame.size=zyf_size;
    self.frame=frame;
}




-(void)setZyf_width:(CGFloat)zyf_width{
    CGRect  frame=self.frame;
    frame.size.width=zyf_width;
    self.frame=frame;
}


-(void)setZyf_height:(CGFloat)zyf_height
{
    
    CGRect  frame=self.frame;
    frame.size.height=zyf_height;
    self.frame=frame;;
}


-(void)setZyf_x:(CGFloat)zyf_x
{
    CGRect  frame=self.frame;
    frame.origin.x=zyf_x;
    self.frame=frame;
}


-(void)setZyf_y:(CGFloat)zyf_y
{
    
    CGRect  frame=self.frame;
    frame.origin.y=zyf_y;
    self.frame=frame;;
}

-(void)setZyf_cnterX:(CGFloat)zyf_cnterX{
    CGPoint center =self.center;
    center.x=zyf_cnterX;
    self.center=center;
}


-(void)setZyf_centerY:(CGFloat)zyf_centerY
{
    
       CGPoint center=self.center;
       center.y=zyf_centerY;
    self.center=center;;
}




@end
