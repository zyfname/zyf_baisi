//
//  XMGTopicCell.m
//  5期-百思不得姐
//
//  Created by xiaomage on 15/11/19.
//  Copyright © 2015年 xiaomage. All rights reserved.
//

#import "XMGTopicCell.h"
#import "ZYFTopicModel.h"
#import "UIImageView+WebCache.h"
#import "ZYFTopicVideoView.h"
#import "ZYFTopicVioceView.h"
#import "ZYFTopicPictureVIEW.h"
#import "UIView+ZYFUIview.h"

@interface XMGTopicCell()
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *createdAtLabel;
@property (weak, nonatomic) IBOutlet UILabel *text_label;
@property (weak, nonatomic) IBOutlet UIButton *dingButton;
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
@property (weak, nonatomic) IBOutlet UIButton *repostButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
/** 最热评论-整体 */
@property (weak, nonatomic) IBOutlet UIView *topCmtView;
@property (weak, nonatomic) IBOutlet UILabel *topCmtContentLabel;

/* 中间控件 */
/** 图片控件 */
@property (nonatomic, weak) ZYFTopicPictureVIEW *pictureView;
/** 声音控件 */
@property (nonatomic, weak) ZYFTopicVioceView *voiceView;
/** 视频控件 */
@property (nonatomic, weak) ZYFTopicVideoView *videoView;
@end

@implementation XMGTopicCell


//#pragma mark---控件的懒加载
-(ZYFTopicPictureVIEW *)pictureView
{
    if (!_pictureView) {
        ZYFTopicPictureVIEW *pictureView = [ZYFTopicPictureVIEW viewFromXib];
        [self.contentView addSubview:pictureView];
        _pictureView=pictureView;
    }
    return _pictureView;
    
}

-(ZYFTopicVideoView *)videoView
{
    if (!_videoView) {
        ZYFTopicVideoView *videoView = [ZYFTopicVideoView viewFromXib];
        [self.contentView addSubview:videoView];
        _videoView=videoView;
    }
    return _videoView;
}
-(ZYFTopicVioceView *)voiceView
{
    if (!_voiceView) {
        ZYFTopicVioceView *voiceView = [ZYFTopicVioceView viewFromXib];
        [self.contentView addSubview:voiceView];
        _voiceView=voiceView;
    }
    return _voiceView;
}


- (IBAction)more {
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    [controller addAction:[UIAlertAction actionWithTitle:@"收藏" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击了[收藏]按钮");
    }]];
    
    [controller addAction:[UIAlertAction actionWithTitle:@"举报" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击了[举报]按钮");
    }]];
    
    [controller addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击了[取消]按钮");
    }]];
    
    [self.window.rootViewController presentViewController:controller animated:YES completion:nil];
}


//问题解决后记得取消注释
- (void)awakeFromNib
{
    self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
}

- (void)setTopic:(ZYFTopicModel *)topic
{
    _topic = topic;
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:topic.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.nameLabel.text = topic.name;
    self.createdAtLabel.text = topic.created_at; // 调用get方法[topic created_at];
    self.text_label.text = topic.text;
    
    [self setupButton:self.dingButton number:topic.ding placeholder:@"顶"];
    [self setupButton:self.caiButton number:topic.cai placeholder:@"踩"];
    [self setupButton:self.repostButton number:topic.repost placeholder:@"分享"];
    [self setupButton:self.commentButton number:topic.comment placeholder:@"评论"];
    

    // 中间内容
    if (topic.type == ZYFTopicTypeVideo) { // 视频
        self.videoView.hidden = NO;
        self.videoView.frame = topic.contentF;
        self.videoView.topic = topic;
        self.voiceView.hidden = YES;
        self.pictureView.hidden = YES;
    } else if (topic.type == ZYFTopicTypeVoice) { // 音频
        self.voiceView.hidden = NO;
        self.voiceView.frame = topic.contentF;
        self.voiceView.topic = topic;
        self.videoView.hidden = YES;
        self.pictureView.hidden = YES;

    } else if (topic.type == ZYFTopicTypeWord) { // 段子
        self.videoView.hidden = YES;
        self.voiceView.hidden = YES;
        self.pictureView.hidden = YES;
    } else if (topic.type == ZYFTopicTypePicture) { // 图片
      
        self.pictureView.hidden = NO;
        self.pictureView.frame = topic.contentF;
        self.pictureView.topic = topic;
        self.videoView.hidden = YES;
        self.voiceView.hidden = YES;
    }

}
-(void)layoutSubviews
{
    [super layoutSubviews];
    
}

    
/**
 *  设置按钮的数字 (placeholder是一个中文参数, 故意留到最后, 前面的参数就可以使用点语法等智能提示)
 */
- (void)setupButton:(UIButton *)button number:(NSInteger)number placeholder:(NSString *)placeholder
{
    if (number >= 10000) {
        [button setTitle:[NSString stringWithFormat:@"%.1f万", number / 10000.0] forState:UIControlStateNormal];
    } else if (number > 0) {
        [button setTitle:[NSString stringWithFormat:@"%zd", number] forState:UIControlStateNormal];
    } else {
        [button setTitle:placeholder forState:UIControlStateNormal];
    }
}

/**
 *  重写这个方法的目的: 能够拦截所有设置cell frame的操作
 */
- (void)setFrame:(CGRect)frame
{
    frame.size.height -= 10;
    frame.origin.y += 10;
    
    [super setFrame:frame];
}

@end
