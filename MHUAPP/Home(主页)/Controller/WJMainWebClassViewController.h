//
//  WJMainWebClassViewController.h
//  LargeCollection
//
//  Created by 今日电器 on 16/9/1.
//  Copyright © 2016年 jinri. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WJMainWebClassViewController : UIViewController<UIWebViewDelegate>
@property (strong, nonatomic)  UIWebView *mWebView;
@property (strong, nonatomic) NSString *str_content;
@property (strong, nonatomic) NSString *str_urlHttp;
@property (strong, nonatomic) NSString *str_title;
@end
