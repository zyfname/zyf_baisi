//
//  ZYFMeCell.m
//  百思不得姐
//
//  Created by HH on 2017/10/8.
//  Copyright © 2017年 HH. All rights reserved.
//

#import "ZYFMeCell.h"
#import "UIView+ZYFUIview.h"
#import "ZYFConst.h"
@implementation ZYFMeCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    //当明确图片是正方形，不用研究Mode
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        //能看到图片全部 UIViewContentModeScaleAspectFit
        //图片伸缩，能看到图片最先适应的那一边 UIViewContentModeScaleAspectFill
        self.imageView.contentMode=UIViewContentModeScaleAspectFit;
        
        //设置文字颜色
        self.textLabel.textColor = [UIColor darkGrayColor];
        //设置cell风格
        self.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        
        //设置cell背景显示
       self.backgroundView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
        
        
        //自定义cell右侧的显示控件
//        self.accessoryView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@""]];
        
    }
    
    return self;
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.imageView.image==nil)  return;
    //imageView
    self.imageView.zyf_y=ZYFSmallMargin ;
    self.imageView.zyf_height =self.contentView.zyf_height-2*ZYFSmallMargin;
    self.imageView.zyf_width=self.imageView.zyf_height;
    
    //Lable
    self.textLabel.zyf_x=self.imageView.zyf_x+self.imageView.zyf_width + ZYFMargin;
}



@end
