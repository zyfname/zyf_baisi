//
//  ZYFGComment.h
//  百思不得姐
//
//  Created by HH on 2017/10/16.
//  Copyright © 2017年 HH. All rights reserved.
//

#import <Foundation/Foundation.h>
@class XMGUser;
@interface ZYFGComment : NSObject
/** 内容 */
@property (nonatomic, copy) NSString *content;
/** 用户(发表评论的人) */
@property (nonatomic, strong) XMGUser *user;

/** 被点赞数 */
@property (nonatomic, assign) NSInteger like_count;

/** 音频文件的时长 */
@property (nonatomic, assign) NSInteger voicetime;

/** 音频文件的路径 */
@property (nonatomic, copy) NSString *voiceuri;
@end
