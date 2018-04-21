//
//  WJGoodParticularsListWebController.m
//  MHUAPP
//
//  Created by jinri on 2018/4/21.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import "WJGoodParticularsListWebController.h"
#import <WebKit/WebKit.h>

@interface WJGoodParticularsListWebController ()<WKNavigationDelegate>

@property (strong, nonatomic) WKWebView *webView;

@end

@implementation WJGoodParticularsListWebController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.view.backgroundColor = [RegularExpressionsMethod ColorWithHexString:kMSVCBackgroundColor];
    // Do any additional setup after loading the view.
}

- (WKWebView *)webView
{
    if (!_webView) {
        _webView = [[WKWebView alloc] initWithFrame:CGRectZero];
        _webView.frame = CGRectMake(0,kMSScreenHeight , kMSScreenWith, kMSScreenHeight -kMSNaviHight-44);
        _webView.scrollView.contentInset = UIEdgeInsetsMake(kMSNaviHight, 0, 0, 0);
        _webView.scrollView.scrollIndicatorInsets = _webView.scrollView.contentInset;
        [self.view addSubview:_webView];
    }
    return _webView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
