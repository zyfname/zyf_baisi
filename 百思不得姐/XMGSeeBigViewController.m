//
//  ZYFAllcontrollerTableViewController.h
//  百思不得姐
//
//  Created by HH on 2017/10/13.
//  Copyright © 2017年 HH. All rights reserved.
//

#import "XMGSeeBigViewController.h"
#import "ZYFTopicModel.h"
#import "UIView+ZYFUIview.h"
#import "UIImageView+WebCache.h"

#import <AssetsLibrary/AssetsLibrary.h> // iOS9开始废弃
#import <Photos/Photos.h> // iOS9开始推荐

@interface XMGSeeBigViewController () <UIScrollViewDelegate>
/** 图片控件 */
@property (nonatomic, weak) UIImageView *imageView;
@end

@implementation XMGSeeBigViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // scrollView
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.delegate = self;
    scrollView.frame = [UIScreen mainScreen].bounds;
    [self.view insertSubview:scrollView atIndex:0];
    
//     scrollView.backgroundColor = [UIColor whiteColor];
    // scrollView.frame = self.view.bounds;
    // scrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    // imageView
    UIImageView *imageView = [[UIImageView alloc] init];
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.topic.image0]];
    [scrollView addSubview:imageView];
    
    imageView.zyf_width = scrollView.zyf_width;
    imageView.zyf_height = self.topic.height * imageView.zyf_width / self.topic.width;
    imageView.zyf_x = 0;
    
    if (imageView.zyf_height >= scrollView.zyf_height) { // 图片高度超过整个屏幕
        imageView.zyf_y = 0;
        // 滚动范围
        scrollView.contentSize = CGSizeMake(0, imageView.zyf_height);
    } else { // 居中显示
        imageView.zyf_centerY = scrollView.zyf_height * 0.5;
    }
    self.imageView = imageView;

    // 缩放比例
    CGFloat scale =  self.topic.width / imageView.zyf_width;
    if (scale > 1.0) {
        scrollView.maximumZoomScale = scale;
    }
}

- (IBAction)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)save {
    
}

#pragma mark - <UIScrollViewDelegate>
/**
 *  返回一个scrollView的子控件进行缩放
 */
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}
@end
