//
//  ZYFWEBcontroller.m
//  百思不得姐
//
//  Created by HH on 2017/10/11.
//  Copyright © 2017年 HH. All rights reserved.
//

#import "ZYFWEBcontroller.h"

@interface ZYFWEBcontroller ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webview;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *houtui;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *qianjin;


@end

@implementation ZYFWEBcontroller

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];}

#pragma mark--监听点击
- (IBAction)back
{

    [self.webview goBack];
}


- (IBAction)firward
{
    [self.webview goForward];

}
- (IBAction)reload:(id)sender {
    [self.webview reload];

}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.houtui.enabled=webView.canGoBack;
    self.qianjin.enabled=webView.canGoForward;
}

@end
