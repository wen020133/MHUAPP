//
//  WJGoodParticularsViewController.m
//  MHUAPP
//
//  Created by jinri on 2017/12/4.
//  Copyright © 2017年 wenchengjun. All rights reserved.
//

#import "WJGoodParticularsViewController.h"
#import <WebKit/WebKit.h>


@interface WJGoodParticularsViewController ()<WKNavigationDelegate>
@property (strong, nonatomic) WKWebView *webView;


@end

@implementation WJGoodParticularsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [RegularExpressionsMethod ColorWithHexString:kMSVCBackgroundColor];
    [self getGoodsDescData];
    [self.view addSubview:self.webView];
//    [self addInformationSegmentedControlView];
//    [self addPageVC];
    // Do any additional setup after loading the view.
}
-(void)getGoodsDescData
{
    [self requestGetAPIWithServe:[NSString stringWithFormat:@"%@/%@/%@?id=%@",kMSBaseMiYoMeiPortURL,kMSappVersionCode,kMSGetGoodsDesc,self.goods_id]];
}
-(void)getProcessData
{
    if([[self.results objectForKey:@"code"] integerValue] == 200)
    {
        NSString *goods_desc = [[self.results objectForKey:@"data"] objectForKey:@"goods_desc"];
        
        NSString *str1 = [RegularExpressionsMethod htmlEntityDecode:goods_desc];
        [_webView loadHTMLString:str1 baseURL:nil];
    }
    else
    {
        return;
    }
}
- (WKWebView *)webView
{
    if (!_webView) {
        _webView = [[WKWebView alloc] initWithFrame:CGRectZero];
        _webView.frame = CGRectMake(0,0 , kMSScreenWith, kMSScreenHeight -kMSNaviHight-50);
        _webView.scrollView.scrollIndicatorInsets = _webView.scrollView.contentInset;

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
