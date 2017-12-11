//
//  RigisterProtocolV.m
//  MHUAPP
//
//  Created by jinri on 2017/12/9.
//  Copyright © 2017年 wenchengjun. All rights reserved.
//

#import "RigisterProtocolV.h"
#import "UIView+UIViewFrame.h"

@implementation RigisterProtocolV

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
      self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
        [self initView];
    }
    return self;
}

- (void)initView {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"MHU商城注册协议" ofType:@"docx"];
    NSURL *url = [NSURL fileURLWithPath:path];

    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];

    [webView loadRequest:[NSURLRequest requestWithURL:url]];

    webView.scalesPageToFit = YES;

    webView.delegate = self;

    [self addSubview:webView];

    self.str_web = webView;

}

#pragma mark 获取指定URL的MIMEType类型
- (NSString *)mimeType:(NSURL *)url
{
    //1NSURLRequest
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    //2NSURLConnection

    //3 在NSURLResponse里，服务器告诉浏览器用什么方式打开文件。

    //使用同步方法后去MIMEType
    NSURLResponse *response = nil;
    [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    return response.MIMEType;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
