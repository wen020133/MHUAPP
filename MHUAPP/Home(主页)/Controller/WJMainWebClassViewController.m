//
//  WJMainWebClassViewController.m
//  LargeCollection
//
//  Created by 今日电器 on 16/9/1.
//  Copyright © 2016年 jinri. All rights reserved.
//

#import "WJMainWebClassViewController.h"

@interface WJMainWebClassViewController ()

@end

@implementation WJMainWebClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = NO;
    self.view.backgroundColor = [RegularExpressionsMethod ColorWithHexString:kMSVCBackgroundColor];
    [self initSendReplyWithTitle:self.str_title andLeftButtonName:@"ic_back.png" andRightButtonName:nil andTitleLeftOrRight:NO];
    
    self.mWebView =[[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kMSScreenWith, kMSScreenHeight-kMSNaviHight)];
    self.mWebView.backgroundColor = [UIColor whiteColor];
    self.mWebView.scalesPageToFit = YES;
//    self.mWebView.delegate = self;
    [self.view addSubview:self.mWebView];
    self.str_urlHttp = [self.str_urlHttp stringByReplacingOccurrencesOfString:@"amp;" withString:@""];
    
    [self.mWebView loadHTMLString:self.str_content baseURL:[NSURL URLWithString:kMSBaseLargeCollectionPortURL]];
    // Do any additional setup after loading the view.
}
//开始加载数据
- (void)webViewDidStartLoad:(UIWebView *)webView {
    
}

//数据加载完
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
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
