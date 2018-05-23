//
//  ZYFTopicVideoView.m
//  百思不得姐
//
//  Created by HH on 2017/10/16.
//  Copyright © 2017年 HH. All rights reserved.
//

#import "ZYFTopicVideoView.h"
#import "XMGSeeBigViewController.h"
#import "UIImageView+WebCache.h"
#import "ZYFTopicModel.h"

@interface ZYFTopicVideoView()
@property (weak, nonatomic) IBOutlet UILabel *playCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *videoTimeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end
@implementation ZYFTopicVideoView
- (void)awakeFromNib
{
    self.autoresizingMask = UIViewAutoresizingNone;
    
}

- (void)seeBig
{
    XMGSeeBigViewController *seeBig = [[XMGSeeBigViewController alloc] init];
    seeBig.topic = self.topic;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:seeBig animated:YES completion:nil];
}

- (void)setTopic:(ZYFTopicModel *)topic
{
    _topic = topic;
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.image0]];
    self.playCountLabel.text = [NSString stringWithFormat:@"%zd播放", topic.playcount];
    
    NSInteger minute = topic.videotime / 60;
    NSInteger second = topic.videotime % 60;
    
  //   %04zd - 占据4位,空出来的位用0来填补
    self.videoTimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd", minute, second];
    
}


@end
