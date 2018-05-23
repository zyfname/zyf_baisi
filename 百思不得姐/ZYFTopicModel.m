//
//  ZYFTopicModel.m
//  百思不得姐
//
//  Created by HH on 2017/10/14.
//  Copyright © 2017年 HH. All rights reserved.
//

#import "ZYFTopicModel.h"

@implementation ZYFTopicModel

-(CGFloat)cellHeight
{
    // 如果cell的高度已经计算过, 就直接返回
   if (_cellHeight) return _cellHeight;
    
    // 1.头像
    _cellHeight = 55;
    
    // 2.文字
    CGFloat textMaxW = [UIScreen mainScreen].bounds.size.width - 2 * 10;
    CGSize textMaxSize = CGSizeMake(textMaxW, MAXFLOAT);//MAXFLOAT=最大浮点数

    CGSize textSize = [self.text boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]} context:nil].size;
    _cellHeight += textSize.height + 10;

    

    
       if (self.type!= ZYFTopicTypeWord) {
      //中间内容的高度 = 中间内容宽度 * 图片真实高度 / 图片真实宽度
             CGFloat contentH = textMaxW * self.height / self.width;
           
      
           if (contentH >= [UIScreen mainScreen].bounds.size.height) { // 超长图片
               // 将超长图片的高度变为200
               contentH = 200;
               //判断是否进来过
               self.bigPicture = YES;
           }
           
           // 这里的cellHeight就是中间内容的y值
           self.contentF = CGRectMake(10, _cellHeight, textMaxW, contentH);
           
           // 累加中间内容的高度
           _cellHeight += contentH + 10;
       }

    
    //最热评论板块的高度
    int a=10+60;
    // 5.底部 - 工具条
    _cellHeight += 35 + a;

    
    return _cellHeight;
}
@end
