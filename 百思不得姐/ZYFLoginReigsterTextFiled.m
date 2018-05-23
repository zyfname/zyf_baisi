//
//  ZYFLoginReigsterTextFiled.m
//  百思不得姐
//
//  Created by HH on 2017/10/8.
//  Copyright © 2017年 HH. All rights reserved.
//

#import "ZYFLoginReigsterTextFiled.h"

@implementation ZYFLoginReigsterTextFiled


-(void)awakeFromNib{
    self.tintColor=[UIColor whiteColor];
    
    //修改占位文字
    NSMutableDictionary *attribus=[NSMutableDictionary dictionary];
    attribus[NSForegroundColorAttributeName]=[UIColor whiteColor];
    self.attributedPlaceholder = [[NSAttributedString alloc]initWithString:self.placeholder
                                                                attributes:attribus];

}

@end
