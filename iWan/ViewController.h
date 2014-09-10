//
//  ViewController.h
//  iWan
//
//  Created by Yu Zhang on 14-8-23.
//  Copyright (c) 2014年 yumao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController {
    IBOutlet UIWebView *iWebView;
    IBOutlet UIButton *backBtn;
    
    NSString *HOME_URL;
    NSString *SHARE_TITLE;
    NSString *SHARE_TEXT;
}

@end
