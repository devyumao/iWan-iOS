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

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    HOME_URL = @"http://iwan.baidu.com/xxx_xiaoyouxi/index.html";
    SHARE_TITLE = @"小游戏大全 - 百度爱玩";
    SHARE_TEXT = @"小游戏大全 - 百度爱玩";
    
    backBtn.hidden = YES;
    
    // 禁用页面回弹
    iWebView.scrollView.bounces = NO;
    
    // 微信分享设置
    [UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeApp;
    [UMSocialData defaultData].extConfig.title = SHARE_TITLE;
    [UMSocialData defaultData].extConfig.wechatSessionData.url = HOME_URL;
    
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
    NSString *pathname =[webView stringByEvaluatingJavaScriptFromString:@"document.location.pathname"];
    if ([pathname isEqualToString:@"/xxx_xiaoyouxi/index.html"]) {
        backBtn.hidden = NO;
    } else {
        backBtn.hidden = YES;
    }
}

- (void)webViewDidFinishLoad:(UIWebView*)webView {
    
}

- (IBAction)onShare:(id)sender {
    NSString *path=[[NSBundle mainBundle]pathForResource:@"homeIcon" ofType:@"png" inDirectory:@"img"];
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"53f8604efd98c585de02377f"
                                      shareText:SHARE_TEXT
                                     shareImage:[UIImage imageWithContentsOfFile:path]
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina, UMShareToWechatSession, UMShareToWechatTimeline, UMShareToEmail, nil]
                                       delegate:nil];
}

- (IBAction)onGoHome:(id)sender {
    NSURL *url =[NSURL URLWithString:HOME_URL];
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    [iWebView loadRequest:request];
}



@end
