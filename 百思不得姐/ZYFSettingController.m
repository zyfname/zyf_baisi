//
//  ZYFSettingController.m
//  百思不得姐
//
//  Created by HH on 2017/10/6.
//  Copyright © 2017年 HH. All rights reserved.
//

#import "ZYFSettingController.h"
#import "ZYFnewController.h"

@interface ZYFSettingController()<UITableViewDataSource>

@end
@implementation ZYFSettingController

-(instancetype)init
{
    return [self initWithStyle:UITableViewStyleGrouped];
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title=@"设置";
    
    //对控制器的属性设置应写在控制器方法内
    self.view.backgroundColor = ZYFRa4ndomColor;
    
    
    //覆盖返回键，不设置使用默认
    self.navigationItem.leftBarButtonItem =    [[UIBarButtonItem alloc]initWithTitle:@"自定义" style:   UITableViewRowActionStyleNormal target:nil action:nil];
    [self getCachessize];
   
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(void)getCachessize{
    NSLog(@"%@",NSHomeDirectory());
    
    
    //返回一层子路径  manager contentsOfDirectoryAtPath:dirpath error:nil]
    //返回所有子路径  [dirpath stringByAppendingPathComponent:subpath]
    
    unsigned long long  size=0;
    NSString *cachesPath = NSSearchPathForDirectoriesInDomains( NSCachesDirectory, NSUserDomainMask, YES).lastObject;
    NSString *dirpath = [cachesPath stringByAppendingPathComponent:@"mp3"];
    
    
    NSFileManager  *manager= [NSFileManager defaultManager];
    
 
    NSArray *subpaths=[manager subpathsAtPath:dirpath];
    for (NSString* subpath in subpaths) {
        //拼接全路径
       NSString *fullpath= [dirpath stringByAppendingPathComponent:subpath];
       
        //获取和缓存的大小
        size+=[manager attributesOfItemAtPath:fullpath error:nil].fileSize;

        
//        文件属性  获取和缓存的大小
//          NSDictionary *attrs = [manager attributesOfItemAtPath:fullpath error:nil];
//          size +=[attrs[NSFileSize] unsignedIntegerValue];
   
    }
    
    ZYFLog(@"%zd",size);
    
    
}
- (void)getCacheSize{
    // 总大小
    unsigned long long size = 0;
    
    // 获得缓存文件夹路径
    NSString *cachesPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
    NSString *dirpath = [cachesPath stringByAppendingPathComponent:@"mp3"];
    
    // 文件管理者
    NSFileManager *mgr = [NSFileManager defaultManager];
    
    // 获得文件夹的大小  == 获得文件夹中所有文件的总大小
    // Enumerator : 遍历器\迭代器
    NSDirectoryEnumerator *enumerator = [mgr enumeratorAtPath:dirpath];
    for (NSString *subpath in enumerator) {
        // 全路径
        NSString *fullSubpath = [dirpath stringByAppendingPathComponent:subpath];
        // 累加文件大小
        size += [mgr attributesOfItemAtPath:fullSubpath error:nil].fileSize;
    }
    
    ZYFLog(@"%zd", size);
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static  NSString *ID=@"setting";
  
    //从缓存c池中获取
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text=@"清楚缓存";
 
    
    
    return cell;
}




@end
