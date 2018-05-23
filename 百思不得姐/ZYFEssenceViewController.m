//
//  ZYFEssenceViewController.m
//  百思不得姐
//
//  Created by HH on 2017/10/2.
//  Copyright © 2017年 HH. All rights reserved.
//

#import "ZYFEssenceViewController.h"
#import "UIBarButtonItem+ZYFUIBarButtonItem.h"
#import "AFNetworking/AFHTTPSessionManager.h"
#import "UIView+ZYFUIview.h"
#import "ZYFTitleButton.h"
#import "ZYFAllcontrollerTableViewController.h"
#import "ZYFImageController.h"
#import "ZYFTVoiceController.h"
#import "ZYFWordController.h"
#import "ZYFTViewController.h"

@interface ZYFEssenceViewController()<UIScrollViewDelegate>
//当前选中的标题按钮
@property(nonatomic,weak)ZYFTitleButton *selectTitleButton;
/** 标题按钮底部的指示器 */
@property (nonatomic, weak) UIView *indicatorView;

@property (nonatomic, weak) UIScrollView *scrollview;

@property (nonatomic, weak) UIView *titleView;



@end
@implementation ZYFEssenceViewController

-(void)viewDidLoad
{
    
    [super viewDidLoad];
  
    [self setupNav];
    
    [self setupChildViewController];
    
    [self setupScrollView];

    [self setupTitlesView];

   }



-(void)setupNav
{
    self.navigationItem.titleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon"
                                                                    target:self heightImage:@"MainTagSubIconClick"  action:@selector(tagClick)];

}

//添加子控制器
-(void)setupChildViewController
{
    ZYFAllcontrollerTableViewController *all = [[ZYFAllcontrollerTableViewController alloc]init];
    [self addChildViewController:all];
    
    ZYFTViewController *viewcontroller = [[ZYFTViewController alloc]init];
    [self addChildViewController:viewcontroller];
    
    ZYFTVoiceController *voice = [[ZYFTVoiceController alloc]init];
    [self addChildViewController:voice];
    
    ZYFImageController *image = [[ZYFImageController alloc]init];
    [self addChildViewController:image];
    
    ZYFWordController *word = [[ZYFWordController alloc]init];
    [self addChildViewController:word];
    
    
    
}


-(void)setupScrollView
{
    // 不允许自动调整scrollView的内边距
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    UIScrollView *scrollview = [[UIScrollView alloc]init];
    
    scrollview.backgroundColor=ZYFRa4ndomColor;
    scrollview.frame=self.view.bounds;
    scrollview.pagingEnabled=YES;
    scrollview.showsHorizontalScrollIndicator=NO;
    scrollview.delegate=self;
    
    scrollview.showsVerticalScrollIndicator=NO;
  
    NSUInteger count =self.childViewControllers.count;
    
    
    scrollview.contentSize=CGSizeMake(count*self.view.zyf_width, 0);
    [self.view addSubview:scrollview];
    self.scrollview =scrollview;


}

-(void)setupTitlesView
{
    
    // 标题栏
    UIView *titlesView = [[UIView alloc] init];
    titlesView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    titlesView.frame = CGRectMake(0, 64, self.view.zyf_width, 35);
    [self.view addSubview:titlesView];
    self.titleView=titlesView;
    
    // 添加标题
    NSArray *titles = @[@"全部", @"视频", @"声音", @"图片", @"段子"];
    NSUInteger count = titles.count;
    CGFloat titleButtonW = titlesView.zyf_width / count;
    CGFloat titleButtonH = titlesView.zyf_height;
    for (NSUInteger i = 0; i < count; i++) {
        // 创建
        ZYFTitleButton *titleButton = [ZYFTitleButton buttonWithType:UIButtonTypeCustom];
         titleButton.tag=i;
        [titleButton addTarget:self action:@selector(titleclick:) forControlEvents:UIControlEventTouchUpInside];
        [titlesView addSubview:titleButton];
        
        // 设置数据
        [titleButton setTitle:titles[i] forState:UIControlStateNormal];
        
        // 设置frame
        titleButton.frame = CGRectMake(i * titleButtonW, 0, titleButtonW, titleButtonH);
        
      
        [titleButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
       [titleButton setTitleColor:[UIColor redColor] forState:UIControlStateSelected];

    }
    
    //按钮选中的颜色
    ZYFTitleButton *firstTitleButton=titlesView.subviews.firstObject;
    // 底部的指示器
    UIView *indicatorView = [[UIView alloc] init];
    indicatorView.backgroundColor = [firstTitleButton titleColorForState:UIControlStateSelected];
    indicatorView.zyf_height = 1;
    indicatorView.zyf_y = titlesView.zyf_height - indicatorView.zyf_height;
    [titlesView addSubview:indicatorView];
    self.indicatorView = indicatorView;
    
    // 立刻根据文字内容计算label的宽度
    [firstTitleButton.titleLabel sizeToFit];
    indicatorView.zyf_width = firstTitleButton.titleLabel.zyf_width;
    indicatorView.zyf_cnterX=firstTitleButton.center.x;
     [self addChildView];
   
    
    [self titleclick:firstTitleButton];
    
    
}
#pragma mark---uiscrollviewdelegate
/**
 * 在scrollView滚动动画结束时, 就会调用这个方法
 * 前提: 使用setContentOffset:animated:或者scrollRectVisible:animated:方法让scrollView产生滚动动画
 */
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self addChildView];
}

/**
 * 在scrollView滚动动画结束时,就会调用这个方法,前提: 人为拖拽scrollView产生的滚动动画
 */
//-(void)scrollViewWillDidEndDecelerating:(UIScrollView *)scrollView
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView

{
    //选中点击对应的按钮
    NSUInteger index = scrollView.contentOffset.x/scrollView.zyf_width;
    NSLog(@"%ld",index);
    ZYFTitleButton *titlebutton =self.titleView.subviews[index];
    [self titleclick:titlebutton];
    [self addChildView];
    
    NSLog(@"%f",scrollView.contentOffset.x);
    
}


#pragma mark--监听点击
-(void)titleclick:(ZYFTitleButton *)titleButton
{
    
    // 控制按钮状态
    self.selectTitleButton.selected = NO;
    titleButton.selected = YES;
    self.selectTitleButton = titleButton;
    
 
    //标题指示器
    [UIView animateWithDuration:0.2 animations:^{
        self.indicatorView.zyf_width = titleButton.titleLabel.zyf_width;
        self.indicatorView.zyf_cnterX=titleButton.center.x;
    }];
    
    
    CGPoint offset= self.scrollview.contentOffset;
    offset.x = titleButton.tag*self.scrollview.zyf_width;

    [self.scrollview setContentOffset:offset animated:YES];
    NSLog(@"tag=%ld,scrollview.zyf_width=%f,result=%f",(long)titleButton.tag,self.scrollview.zyf_width,titleButton.tag*self.scrollview.zyf_width);
    
}

-(void)addChildView{
    //添加自控制器到scrollview中
    NSUInteger index = self.scrollview.contentOffset.x/self.scrollview.zyf_width;
    UIViewController *childerView =self.childViewControllers[index];
      if ([childerView isViewLoaded]) return;
    childerView.view.frame=self.scrollview.bounds;
    [self.scrollview addSubview:childerView.view];
}



-(void)tagClick
{
    ZYFLog(@"%s",__func__);
}

@end
