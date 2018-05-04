//
//  WJMainWebClassViewController.h
//  LargeCollection
//
//  Created by 今日电器 on 16/9/1.
//  Copyright © 2016年 jinri. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface WJMainWebClassViewController : UIViewController<WKNavigationDelegate>

@property (weak, nonatomic) WKWebView *webView;
@property (weak, nonatomic) CALayer *progresslayer;

@property (strong, nonatomic) NSString *str_content;
@property (strong, nonatomic) NSString *str_urlHttp;
@property (strong, nonatomic) NSString *str_title;
@end
