//
//  RigisterProtocolViewController.h
//  MHUAPP
//
//  Created by jinri on 2017/12/26.
//  Copyright © 2017年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RigisterProtocolViewController : UIViewController<UIWebViewDelegate>

@property (strong, nonatomic)  UIWebView *mWebView;
@property (strong, nonatomic) NSString *str_content;
@property (strong, nonatomic) NSString *str_urlHttp;
@property (strong, nonatomic) NSString *str_title;
@end
