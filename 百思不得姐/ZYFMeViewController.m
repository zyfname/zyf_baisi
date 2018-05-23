//
//  ZYFMeViewController.m
//  百思不得姐
//
//  Created by HH on 2017/10/2.
//  Copyright © 2017年 HH. All rights reserved.
//

#import "ZYFMeViewController.h"
#import "ZYFSettingController.h"
#import "UIBarButtonItem+ZYFUIBarButtonItem.h"
#import "UIView+ZYFUIview.h"
#import "ZYFMeCell.h"
#import "ZYFConst.h"
#import "ZYFMeFootView.h"
@interface ZYFMeViewController()<UITableViewDataSource,UITableViewDelegate>

@end
@implementation ZYFMeViewController



-(instancetype)init
{
   return  [super initWithStyle:UITableViewStyleGrouped];
}


-(void)viewDidLoad
 {
    [super viewDidLoad];
    [self setTable];
    
    [self setUpNav];
    
  }


-(void)setTable{
    
    self.view.backgroundColor= ZYFgrayColor;
    self.tableView.contentInset = UIEdgeInsetsMake(ZYFMargin-31, 0, 0, 0);
    
    
    //    self.tableView.tableHeaderView=[[UISwitch alloc]init];
    //每一组的头部高度
    self.tableView.sectionHeaderHeight=0;
    //每一组的底部高度
    self.tableView.sectionFooterHeight=ZYFMargin;
    
    ZYFMeFootView *footView = [[ZYFMeFootView alloc]init];
    footView.zyf_height = 200;
    self.tableView.tableFooterView =footView;

}

-(void)setUpNav
{
    self.navigationItem.title=@"我的";
    
    
    UIBarButtonItem *setItem =[UIBarButtonItem itemWithImage:@"mine-setting-icon"
                                                      target:self heightImage:@"mine-setting-icon-click"  action:@selector(MeClick)];
    
    UIBarButtonItem *moonItem =[UIBarButtonItem itemWithImage:@"mine-moon-icon" target:self heightImage:@"mine-moon-icon-click" action:@selector(MeClick)];
    
    self.navigationItem.rightBarButtonItems = @[setItem,moonItem];
    
  
}

-(void)MeClick
{
    ZYFLog(@"%s",__func__);
    ZYFSettingController *test = [[ZYFSettingController alloc]init];
    [self.navigationController pushViewController:test animated:YES];

}

#pragma mark--数据源方法

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static  NSString *ID=@"me";
    if (ID==nil) {
        ID = [NSString stringWithFormat:@"%@ID",NSStringFromClass(self)];
        
    }
    //从缓存吃中获取
    ZYFMeCell *cell =[tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[ZYFMeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    if (indexPath.section==0){
        cell.textLabel.text=@"登录/注册";
        cell.imageView.image = [UIImage imageNamed:@"setup-head-default"];
        
    }else{
         cell.textLabel.text = @"离线下载";
        //考虑cell的复用，代码严禁性，只要有其他cell设置过imageView,其他不显示的cell都要设置imageView.image=nil;
        cell.imageView.image=nil;
    }
   
    
    
    return cell;
}






@end
