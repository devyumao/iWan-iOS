//
//  ViewController.m
//  iWan
//
//  Created by Yu Zhang on 14-8-23.
//  Copyright (c) 2014年 yumao. All rights reserved.
//

#import "ViewController.h"
#import "UMSocial.h"
#import "UMSocialWechatHandler.h"
#import "KxMenu.h"

@interface ViewController ()

@end

@implementation ViewController {
    NSString *HOME_URL;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    HOME_URL = @"http://iwan.baidu.com/xxx_xiaoyouxi/index.html?app=1";
    
    // 导航栏初始化
    [navigationBar setBackgroundImage:[UIImage new]
                       forBarPosition:UIBarPositionAny
                           barMetrics:UIBarMetricsDefault];
    [navigationBar setShadowImage:[UIImage new]];
    
    // 禁用页面回弹
    iWebView.scrollView.bounces = NO;
    
    // 微信分享设置
    [UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeApp;
    
//    NSString *path=[[NSBundle mainBundle]pathForResource:@"index" ofType:@"html" inDirectory:@"www"];
//    NSURLRequest *request=[NSURLRequest requestWithURL:[NSURL fileURLWithPath:path]];
    
    // 载入首页
    NSURL *url =[NSURL URLWithString:HOME_URL];
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    [iWebView loadRequest:request];
    
    iWebView.delegate = self;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView*)webView {
}

- (void)webViewDidFinishLoad:(UIWebView*)webView {
}

- (IBAction)showMenu:(id)sender {
    NSArray *menuItems = @[
       [KxMenuItem menuItem:@"分享"
                      image:[UIImage imageNamed:@"share"]
                     target:self
                     action:@selector(onShare:)],
       
       [KxMenuItem menuItem:@"刷新"
                      image:[UIImage imageNamed:@"refresh"]
                     target:self
                     action:@selector(onRefresh:)],
       
       
       [KxMenuItem menuItem:@"返回"
                      image:[UIImage imageNamed:@"arrow-left"]
                     target:self
                     action:@selector(onGoBack:)]
    ];
    
    const CGFloat W = self.view.bounds.size.width;
    
    [KxMenu showMenuInView:self.view
                  fromRect:CGRectMake(W - 77, 0, 100, 50)
                 menuItems:menuItems];
}

- (void)onShare:(id)sender {
    NSString *shareTitle = [iWebView stringByEvaluatingJavaScriptFromString:@"document.title"];
    NSString *shareUrl = [[iWebView stringByEvaluatingJavaScriptFromString:@"document.location.href"] componentsSeparatedByString:@"?"][0];
    NSString *shareText = [[shareTitle stringByAppendingString:@" "] stringByAppendingString:shareUrl];
    
    [UMSocialData defaultData].extConfig.title = shareTitle;
    [UMSocialData defaultData].extConfig.wechatSessionData.url = shareUrl;
    [UMSocialData defaultData].extConfig.wechatTimelineData.url = shareUrl;
    
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"53f8604efd98c585de02377f"
                                      shareText:shareText
                                     shareImage:[UIImage imageNamed:@"home-icon"]
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina, UMShareToWechatTimeline, UMShareToWechatSession, UMShareToEmail, UMShareToRenren, UMShareToDouban, UMShareToSms, nil]
                                       delegate:nil];
}

- (void)onRefresh:(id)sender {
    [iWebView reload];
}

- (void)onGoBack:(id)sender {
    // 暂时
    NSURL *url =[NSURL URLWithString:HOME_URL];
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    [iWebView loadRequest:request];
}

- (IBAction)onGoHome:(id)sender {
    NSURL *url =[NSURL URLWithString:HOME_URL];
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    [iWebView loadRequest:request];
}

@end
