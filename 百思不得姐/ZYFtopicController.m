
//
//  ZYFAllcontrollerTableViewController.m
//  百思不得姐
//
//  Created by HH on 2017/10/13.
//  Copyright © 2017年 HH. All rights reserved.
//

#import "ZYFtopicController.h"
#import "AFNetworking.h"
#import "ZYFTopicModel.h"
#import "MJExtension.h"
#import "ZYFRefreshHeader.h"
#import "MJRefresh.h"
#import "XMGTopicCell.h"
#import "ZYFNewViewCont.h"
#import "UIImageView+WebCache.h"//给图片按钮设置图片
@interface ZYFtopicController()<UITableViewDataSource>


@property(nonatomic,strong)NSMutableArray<ZYFTopicModel *> *topics;
//加载上一次的最大时间
@property(nonatomic,strong)NSString *maxtime;

//任务管理者
@property(nonatomic,strong)AFHTTPSessionManager *manager;

@end

@implementation ZYFtopicController
static NSString * const XMGTopicCellId = @"topic";



/**
 * 实现这个方法仅仅是为了消除警告（因为子类的type方法最终会覆盖父类的这个方法）
 */
- (ZYFTopicType)type {
    return 0;
}


- (NSString *)aParam
{
    // [a isKindOfClass:c] 判断a是否为c类型或者c的子类类型
    if ([self.parentViewController isKindOfClass:[ZYFNewViewCont class]]) {
        return @"newlist";
    }
    
    return @"list";
}


-(AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
        
    }
    return _manager;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=ZYFgrayColor;
    self.tableView.contentInset = UIEdgeInsetsMake(35, 0, 49, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    [self setupRefresh];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([XMGTopicCell class]) bundle:nil] forCellReuseIdentifier:XMGTopicCellId];
    self.tableView.rowHeight = 250;
    
}
- (void)setupRefresh
{self.tableView.mj_header=[ZYFRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopic)];
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer =[MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];}

-(void)loadMore
{
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    params[@"a"]=self.aParam;
    params[@"c"]=@"data";
    params[@"maxtime"]=self.maxtime;
    params[@"type"]=@(self.type);

    
    //发送请求
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [responseObject writeToFile:@"/Users/hh/Desktop/all1.plist" atomically:YES ];
        //存储这页对应的maxtime
        self.maxtime=responseObject[@"info"][@"maxtime"];
        //字典数组---模型数组
        NSArray *moreTopic=[ZYFTopicModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        [self.topics addObjectsFromArray:moreTopic];
       
        // 让[刷新控件]结束刷新
        [self.tableView.mj_footer endRefreshing];
        //刷新表格
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        // 让[刷新控件]结束刷新
        [self.tableView.mj_footer endRefreshing];
    }];
}

-(void)loadNewTopic
{
    //取消所有请求--方法二
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    params[@"a"]=self.aParam;
    params[@"c"]=@"data";
    params[@"type"]=@(self.type);
    
    //发送请求
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [responseObject writeToFile:@"/Users/hh/Desktop/all.plist" atomically:YES ];
        
        //存储这页对应的maxtime
        self.maxtime=responseObject[@"info"][@"maxtime"];
       
        //字典数组---模型数组
        self.topics=[ZYFTopicModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        //刷新表格
        [self.tableView reloadData];
        // 让[刷新控件]结束刷新
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        // 让[刷新控件]结束刷新
        [self.tableView.mj_header endRefreshing];
    }];
    
}

#pragma mark---代理方法

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.topics.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    XMGTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:XMGTopicCellId];
    
    cell.topic = self.topics[indexPath.row];
    return cell;
    
}
#pragma mark - 代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.topics[indexPath.row].cellHeight;
}


@end


