//
//  UIView+ZYFUIview.h
//  百思不得姐
//
//  Created by HH on 2017/10/2.
//  Copyright © 2017年 HH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ZYFUIview)
@property(nonatomic,assign)CGSize zyf_size;

@property(nonatomic,assign)CGFloat zyf_width;

@property(nonatomic,assign)CGFloat zyf_height;

@property(nonatomic,assign)CGFloat zyf_x;

@property(nonatomic,assign)CGFloat zyf_y;

@property(nonatomic,assign)CGFloat zyf_cnterX;

@property(nonatomic,assign)CGFloat zyf_centerY;


+(instancetype)viewFromXib; 
@end
