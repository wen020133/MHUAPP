//
//  RigisterProtocolViewController.m
//  MHUAPP
//
//  Created by jinri on 2017/12/26.
//  Copyright © 2017年 wenchengjun. All rights reserved.
//

#import "RigisterProtocolViewController.h"

@interface RigisterProtocolViewController ()

@end

@implementation RigisterProtocolViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [RegularExpressionsMethod ColorWithHexString:kMSVCBackgroundColor];
    [self initSendReplyWithTitle:self.str_title  andLeftButtonName:@"ic_back.png" andRightButtonName:nil andTitleLeftOrRight:YES];

    self.mWebView =[[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kMSScreenWith, kMSScreenHeight-kMSNaviHight)];
    self.mWebView.backgroundColor = [UIColor whiteColor];
    self.mWebView.scalesPageToFit = YES;
//    self.mWebView.delegate = self;
    [self.view addSubview:self.mWebView];
  
    if(![_str_content isEqual:[NSNull null]]&&_str_content.length>1)
    {
        [self.mWebView loadHTMLString:_str_content baseURL:nil];
    }
    else
    {
        [self.mWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_str_urlHttp]]];
    }
//    self.str_urlHttp = [self.str_urlHttp stringByReplacingOccurrencesOfString:@"amp;" withString:@""];

//    [self.mWebView loadHTMLString:self.str_content baseURL:[NSURL URLWithString:kMSBaseLargeCollectionPortURL]];
    // Do any additional setup after loading the view.
}


-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    
    NSString *str = @"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '60%'";
    
    [_mWebView stringByEvaluatingJavaScriptFromString:str];
    
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
