//
//  WJMainWebClassViewController.m
//  LargeCollection
//
//  Created by 今日电器 on 16/9/1.
//  Copyright © 2016年 jinri. All rights reserved.
//

#import "WJMainWebClassViewController.h"
#import "WJWebProgressLayer.h"
#import "UIView+UIViewFrame.h"
#include <JavaScriptCore/JavaScript.h>
#include <JavaScriptCore/JSContext.h>

@interface WJMainWebClassViewController ()<UIWebViewDelegate>

@property (strong, nonatomic) UIWebView *webView;
@property (strong, nonatomic)     WJWebProgressLayer *progressLayer; ///< 网页加载进度条
@end

@implementation WJMainWebClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = NO;
    self.view.backgroundColor = [RegularExpressionsMethod ColorWithHexString:kMSVCBackgroundColor];
    [self initSendReplyWithTitle:self.str_title andLeftButtonName:@"ic_back.png" andRightButtonName:nil andTitleLeftOrRight:NO];

   _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, kMSScreenWith, kMSScreenHeight-kMSNaviHight)];
// _webView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
//    _webView.scrollView.bounces = NO;
//    _webView.delegate = self;
//    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"mobile_chat_online" ofType:@"html" inDirectory:@"mobile"]]]];
    
    [self.view addSubview:_webView];

    //进度条
    _progressLayer = [WJWebProgressLayer new];
    _progressLayer.frame = CGRectMake(0, 42, kMSScreenWith, 2);
    [self.navigationController.navigationBar.layer addSublayer:_progressLayer];
    
    if(![_str_content isEqual:[NSNull null]]&&_str_content.length>1)
    {
         [_webView loadHTMLString:_str_content baseURL:nil];
    }
    else
    {
        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_str_urlHttp]]];
    }
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    // Do any additional setup after loading the view.
}



- (void)showleft {
    if ([self.webView canGoBack]) {
        [self.webView goBack];
    }
     [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView {
    [_progressLayer startLoad];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [_progressLayer finishedLoad];
    self.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    __weak typeof(self) weakSelf = self;
    JSContext *context = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    context[@"goHisBack"] = ^() { // 后退
        [weakSelf JSCallOCWithGoHisBack];
    };
}
- (void)JSCallOCWithGoHisBack
{
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    });
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [_progressLayer finishedLoad];
}

- (void)dealloc {
    
    [_progressLayer closeTimer];
    [_progressLayer removeFromSuperlayer];
    _progressLayer = nil;
    NSLog(@"i am dealloc");
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
