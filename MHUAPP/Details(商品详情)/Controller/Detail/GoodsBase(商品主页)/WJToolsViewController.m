//
//  WJToolsViewController.m
//  MHUAPP
//
//  Created by jinri on 2017/12/4.
//  Copyright © 2017年 wenchengjun. All rights reserved.
//

#import "WJToolsViewController.h"
// Categories
#import "UIViewController+XWTransition.h"


@interface WJToolsViewController ()

@end

@implementation WJToolsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    [self setUpShareAlterView];

    [self setUpTopView];
    // Do any additional setup after loading the view.
}
- (void)setUpTopView
{
    UIButton *refreshButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [refreshButton setImage:[UIImage imageNamed:@"ptgd_icon_shuaxin"] forState:0];

    [self.view addSubview:refreshButton];
    [refreshButton addTarget:self action:@selector(refreshButtonClick) forControlEvents:UIControlEventTouchUpInside];

    [refreshButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(kMSScreenWith - 120);
        make.size.mas_equalTo(CGSizeMake(35, 35));
    }];

    NSArray *images = @[@"ptgd_icon_home",@"ptgd_icon_fenlei",@"ptgd_icon_xiaoxi",@"ptgd_icon_share"];
    CGFloat buttonW = kMSScreenWith / 4;
    CGFloat buttonH = 40;
    CGFloat buttonY = kMSScreenHeight - 60;
    for (NSInteger i = 0; i < images.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:images[i]] forState:0];
        [self.view addSubview:button];
        button.tag = i;
        CGFloat buttonX = buttonW * i;
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        [button addTarget:self action:@selector(toolsButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)toolsButtonClick:(UIButton *)button
{
    dispatch_sync(dispatch_get_global_queue(0, 0), ^{
        [[NSNotificationCenter defaultCenter]postNotificationName:@"shareAlterView" object:nil];
    });
}
- (void)refreshButtonClick
{
    [self cancelButtonClick];
}

#pragma mark - 弹出弹框
- (void)setUpShareAlterView
{
    XWInteractiveTransitionGestureDirection direction = XWInteractiveTransitionGestureDirectionDown;
    WEAKSELF
    [weakSelf xw_registerBackInteractiveTransitionWithDirection:direction transitonBlock:^(CGPoint startPoint){
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
    } edgeSpacing:0];
}

#pragma mark - 取消点击
- (void)cancelButtonClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
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
