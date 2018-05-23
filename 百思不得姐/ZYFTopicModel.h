//
//  ZYFTopicModel.h
//  百思不得姐
//
//  Created by HH on 2017/10/14.
//  Copyright © 2017年 HH. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>


typedef enum {
    /** 全部 */
    ZYFTopicTypeAll = 1,
    /** 图片 */
    ZYFTopicTypePicture = 10,
    /** 段子 */
    ZYFTopicTypeWord = 29,
    /** 声音 */
    ZYFTopicTypeVoice = 31,
    ZYFTopicTypeVideo = 41
}ZYFTopicType;

@interface ZYFTopicModel : NSObject
/** id */
@property (nonatomic, copy) NSString *ID;
/** 用户的名字 */
@property (nonatomic, copy) NSString *name;
/** 用户的头像 */
@property (nonatomic, copy) NSString *profile_image;
/** 帖子的文字内容 */
@property (nonatomic, copy) NSString *text;
/** 帖子审核通过的时间 */
@property (nonatomic, copy) NSString *created_at;
/** 顶数量 */
@property (nonatomic, assign) NSInteger ding;
/** 踩数量 */
@property (nonatomic, assign) NSInteger cai;
/** 转发\分享数量 */
@property (nonatomic, assign) NSInteger repost;
/** 评论数量 */
@property (nonatomic, assign) NSInteger comment;
/** 帖子类型 */
@property (nonatomic, assign) ZYFTopicType type;
/** 图片的真实宽度 */
@property (nonatomic, assign) CGFloat width;
/** 图片的真实高度 */
@property (nonatomic, assign) CGFloat height;

/** 小图 */
@property (nonatomic, copy) NSString *image0;
/** 中图 */
@property (nonatomic, copy) NSString *image1;
/** 大图 */
@property (nonatomic, copy) NSString *image2;
/** 是否为gif动画图片 */
@property (nonatomic, assign) BOOL is_gif;

/** 音频时长 */
@property (nonatomic, assign) NSInteger voicetime;
/** 视频时长 */
@property (nonatomic, assign) NSInteger videotime;
/** 音频\视频的播放次数 */
@property (nonatomic, assign) NSInteger playcount;

//额外增加属性
@property (nonatomic, assign)CGFloat cellHeight;
/** 中间内容的frame */
@property (nonatomic, assign) CGRect contentF;
/** 是否为超长图片 */
@property (nonatomic, assign, getter=isBigPicture) BOOL bigPicture;
@end
