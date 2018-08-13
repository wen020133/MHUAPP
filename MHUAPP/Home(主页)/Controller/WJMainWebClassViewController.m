//
//  WJMainWebClassViewController.m
//  LargeCollection
//
//  Created by 今日电器 on 16/9/1.
//  Copyright © 2016年 jinri. All rights reserved.
//

#import "WJMainWebClassViewController.h"

@interface WJMainWebClassViewController ()

@property (strong, nonatomic) UIWebView *webView;

@end

@implementation WJMainWebClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor = [RegularExpressionsMethod ColorWithHexString:kMSVCBackgroundColor];
//    [self initSendReplyWithTitle:self.str_title andLeftButtonName:@"ic_back.png" andRightButtonName:nil andTitleLeftOrRight:NO];

   _webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
// _webView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
//    _webView.scrollView.bounces = NO;
//    _webView.delegate = self;
//    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"mobile_chat_online" ofType:@"html" inDirectory:@"mobile"]]]];
    
    [self.view addSubview:_webView];
    //添加属性监听
    [_webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];

    //进度条
    UIView *progress = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 3)];
    progress.backgroundColor = [UIColor clearColor];
    [self.view addSubview:progress];

    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(0, 0, 0, 3);
    layer.backgroundColor = [UIColor blueColor].CGColor;
    [progress.layer addSublayer:layer];
    self.progresslayer = layer;
    if(![_str_content isEqual:[NSNull null]]&&_str_content.length>1)
    {
         [_webView loadHTMLString:_str_content baseURL:nil];
    }
    else
    {
        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_str_urlHttp]]];
    }
   
    // Do any additional setup after loading the view.
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        NSLog(@"%@", change);
        self.progresslayer.opacity = 1;
        self.progresslayer.frame = CGRectMake(0, 0, self.view.bounds.size.width * [change[NSKeyValueChangeNewKey] floatValue], 3);
        if ([change[NSKeyValueChangeNewKey] floatValue] == 1) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.progresslayer.opacity = 0;
            });
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.progresslayer.frame = CGRectMake(0, 0, 0, 3);
            });
        }
    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
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
- (void)dealloc{
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
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
