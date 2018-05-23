//
//  ZYFMeFootView.m
//  百思不得姐
//
//  Created by HH on 2017/10/9.
//  Copyright © 2017年 HH. All rights reserved.
//

#import "ZYFMeFootView.h"
#import "AFNetworking.h"
#import "ZYFmeSquare.h"
#import "MJExtension.h"
#import "UIView+ZYFUIview.h"
#import "ZYFsquarebutton.h"
#import "UIButton+WebCache.h"//给按钮设置图片
#import "ZYFWEBcontroller.h"

@interface ZYFMeFootView()

@property(nonatomic,strong) NSMutableDictionary<NSString *,ZYFmeSquare *> *allSquares;
@end

@implementation ZYFMeFootView


-(NSMutableDictionary<NSString *,ZYFmeSquare *> *)allSquares{
    if(!_allSquares){
        _allSquares=[NSMutableDictionary dictionary];

    }
    return _allSquares;
}


-(instancetype)initWithFrame:(CGRect)frame
{
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    params[@"a"]=@"square";
      params[@"c"]=@"topic";
   
    
    if( self= [super initWithFrame:frame]){
       
        [[AFHTTPSessionManager manager]GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//            ZYFLog(@"请求成功----%@ %@",[responseObject class],responseObject);
            [responseObject writeToFile:@"/Users/hh/Desktop/me.plist" atomically:YES ];
            //字典转模型
            NSArray *squares =[ZYFmeSquare mj_objectArrayWithKeyValuesArray:responseObject[@"square_list"]];
            [self creatSquare:squares];
//            ZYFLog(@"%@",squares);
       //方法已过期
//            NSArray *squares =[ZYFmeSquare objectArrayWithKeyValuesArray:responseObject[@"square_list"]];
//            
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            ZYFLog(@"请求失败----%@",error);

        }];
    }
    return self;
}

-(void)creatSquare:(NSArray *)squares
{
    NSUInteger count =squares.count;
    //创建所有方块
    int maxColsCount=4;
    CGFloat btnW=self.zyf_width/maxColsCount;
    CGFloat btnH=btnW;
    
    for (NSUInteger i=0; i<count; i++) {
        //获得i对应模型数据
        ZYFmeSquare *square =squares[i];
        
        //通过数据名称储存数据
        self.allSquares[square.name]=square;
        
            //创建按钮控件
            ZYFsquarebutton *btn = [ZYFsquarebutton buttonWithType:UIButtonTypeCustom];
        

        [btn addTarget:self action:@selector(btnclick:) forControlEvents:UIControlEventTouchUpInside];
            btn.backgroundColor=ZYFgrayColor;
            [self addSubview:btn];
            btn.zyf_x=(i%maxColsCount)*btnW;
            btn.zyf_y=(i/maxColsCount)*btnW;;
            btn.zyf_width=btnW;
            btn.zyf_height=btnH;
            
   
            
//            ZYFLog(@"btnW=%f-----btnH=%f",btn.zyf_width,btn.zyf_height);
//            
//            ZYFLog(@"%f",btn.zyf_x);
        
            //设置数据
            [btn setTitle:square.name forState:UIControlStateNormal];
            
            [btn sd_setImageWithURL:square.icon forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"setup-head-default"]];
            
//            ZYFLog(@"%f----------%f",btn.frame.size.width,btn.frame.size.height);
        
        
        
       //按钮设置图片不能直接用imageview而是要分状态
//        #import "UIImageView+WebCache.h"
//        [btn setImage:[UIImage imageNamed:@"setup-head-default"] forState:UIControlStateNormal];
//        
//
//               //获取图片后设置按钮图片
//        [[SDWebImageManager sharedManager] loadImageWithURL:square.icon options:0 progress:nil completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
//
//            [btn setImage:image forState:UIControlStateNormal];
//        }
//         ];
        
          }
    
   

   //footview高度=最后一个子空间的高度+y值
  self.zyf_height=self.subviews.lastObject.zyf_height+self.subviews.lastObject.zyf_y;
     //上面那句能设置footview的高度，但不能滑动拉倒底部按钮//需要加上下面两句
    UITableView *tab =(UITableView *)self.superview;
    tab.tableFooterView=self;
  
    
}
-(void)btnclick:(ZYFsquarebutton *) button
{
    ZYFmeSquare *square = self.allSquares[button.currentTitle];
 
    
    //根据获取的URL不同
//    [square.url containsString:@"http"]  不靠谱，包含就返回YES
//    square.url hasPrefix:@"http"]  以什么开头
//    [square.url hasSuffix:@"http"]  以什么结尾
    if([square.url hasPrefix:@"http"]){
        //利用webview加载内容
        ZYFWEBcontroller * web =[[ZYFWEBcontroller alloc]init];
       //设置控制器标题
        web.navigationController.title=square.name;
        web.url=square.url;
        UITabBarController *tabBarVc =self.window.rootViewController;
        UINavigationController *selectViewController = tabBarVc.selectedViewController;
       
        [selectViewController pushViewController:web animated:YES];

        
    }else if ([square.url hasPrefix:@"mod"]){
        
        
        //另行处理
        
    }else{
        ZYFLog(@"不是以上两种情况，待优化！！");
    }
}
@end
