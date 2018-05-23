//
//  ZYFTopicVioceView.m
//  百思不得姐
//
//  Created by HH on 2017/10/16.
//  Copyright © 2017年 HH. All rights reserved.
//

#import "ZYFTopicVioceView.h"
#import "ZYFTopicModel.h"
#import "SDWebImage/UIImageView+WebCache.h"

@interface ZYFTopicVioceView()
@property (weak, nonatomic) IBOutlet UILabel *playcountLabel;
@property (weak, nonatomic) IBOutlet UILabel *voiceTimeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;



@end

@implementation ZYFTopicVioceView

- (void)awakeFromNib
{
    // 清楚自动伸缩
    self.autoresizingMask = UIViewAutoresizingNone;
}

- (void)setTopic:(ZYFTopicModel *)topic
{
    _topic = topic;
    
    // 设置显示数据
      [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.image0] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
           CGFloat progress = 1.0 * receivedSize / expectedSize;
//             self.progressView.progress = progress;
//             self.progressView.hidden = NO;
         } completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
//            self.progressView.hidden = YES;
    
         }];
    self.playcountLabel.text = [NSString stringWithFormat:@"%zd播放",self.topic.playcount];
    
    NSInteger minute = self.topic.voicetime / 60;
    CGFloat second = self.topic.voicetime % 60;
    // %02zd表示保留两位数，且不足时用0补齐
    self.voiceTimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd",minute,second];
}

@end
