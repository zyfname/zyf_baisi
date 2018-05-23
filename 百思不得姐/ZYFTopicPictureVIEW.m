//
//  ZYFTopicPictureVIEW.m
//  百思不得姐
//
//  Created by HH on 2017/10/16.
//  Copyright © 2017年 HH. All rights reserved.
//

#import "ZYFTopicPictureVIEW.h"
#import "ZYFTopicModel.h"
#import "UIImageView+WebCache.h"
#import "AFNetworking.h"
#import "XMGSeeBigViewController.h"

#import "DALabeledCircularProgressView.h"
@interface ZYFTopicPictureVIEW()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *seeBigButton;
@property (weak, nonatomic) IBOutlet UIImageView *gifView;
@property (weak, nonatomic) IBOutlet DALabeledCircularProgressView *progressView;

@end
@implementation ZYFTopicPictureVIEW

- (void)awakeFromNib
{
    // 从xib中加载进来的控件的autoresizingMask默认是UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight
    
    self.autoresizingMask = UIViewAutoresizingNone;
    
    self.progressView.roundedCorners = 5;
    self.progressView.progressLabel.textColor = [UIColor whiteColor];
    self.imageView.userInteractionEnabled = YES;
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(seeBig)]];
}

- (void)seeBig
{
    XMGSeeBigViewController *seeBig = [[XMGSeeBigViewController alloc] init];
    seeBig.topic = self.topic;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:seeBig animated:YES completion:nil];
}

  // 由于是模拟器(直接显示大图)
- (void)setTopic:(ZYFTopicModel *)topic
{
    _topic = topic;
   
    //不是动态图隐藏
    if (topic.is_gif) {
        self.gifView.hidden=NO;
        
    }else
    {
        self.gifView.hidden=YES;
    }
    if (topic.isBigPicture) {
        self.seeBigButton.hidden=NO;
        self.imageView.contentMode=UIViewContentModeTop;
        self.imageView.clipsToBounds=YES;

    }else
    {
        self.seeBigButton.hidden=YES;
        self.imageView.contentMode=UIViewContentModeScaleToFill;
         self.imageView.clipsToBounds=NO;
    }
    
    self.seeBigButton.hidden=!topic.isBigPicture;
    
 // [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.image0]];
    
     [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.image1] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
         CGFloat progress = 1.0 * receivedSize / expectedSize;
         self.progressView.progress = progress;
         
         self.progressView.progressLabel.text = [NSString stringWithFormat:@"%.0f%%", progress * 100];
         self.progressView.hidden = NO;
         } completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            self.progressView.hidden = YES;

         }];

  
    

    // gif
//    self.gifView.hidden = !topic.is_gif;
    
    // 查看大图
    if (topic.isBigPicture) { // 超长图片
        self.seeBigButton.hidden = NO;
        self.imageView.contentMode = UIViewContentModeTop;
        self.imageView.clipsToBounds = YES;
    } else {
        self.seeBigButton.hidden = YES;
        self.imageView.contentMode = UIViewContentModeScaleToFill;
        self.imageView.clipsToBounds = NO;
    }
}


@end

//
