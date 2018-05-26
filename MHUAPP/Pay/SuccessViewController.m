//
//  SuccessViewController.m
//  IOS_XW
//
//  Created by add on 15/11/11.
//  Copyright (c) 2015年 lan. All rights reserved.
//

#import "SuccessViewController.h"
#import "WJOrderMainViewController.h"
#import "UIView+UIViewFrame.h"


@interface SuccessViewController ()

@end

@implementation SuccessViewController

- (void)viewDidLoad {

    self.view.backgroundColor = [RegularExpressionsMethod ColorWithHexString:kMSVCBackgroundColor];
    _state = @(0);
    [super viewDidLoad];
    [self initView];
}

-(void)initView
{
    NSString *s;
    NSString *imgStr;
    NSString *s1;
    NSString *s2;
    if ([_state isEqualToNumber:@(0)])
    {
        s = @"付款成功";
        imgStr = @"img_paysuccess";
        s1 = @"去逛逛";
        s2 = @"查看订单";
    }
    else
    {
        s = @"交易成功";
        imgStr = @"img_sussessing";
        s1 = @"立即评价";
        s2 = @"查看订单";
    }

     [self initSendReplyWithTitle:s andLeftButtonName:@"ic_back.png" andRightButtonName:nil andTitleLeftOrRight:YES];
    

   
    UIImageView *img = ImageViewInit(0, 0, kMSScreenWith, kMSScreenWith/16*5);
    img.image = [UIImage imageNamed:imgStr];
    [self.view addSubview:img];
    
    UIButton *btn =  [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:s1 forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.frame = CGRectMake(20, img.Bottom+40, kMSScreenWith/2-40, 30);
    btn.backgroundColor = [RegularExpressionsMethod ColorWithHexString:BASEPINK];
    btn.titleLabel.font = Font(15);
    [btn addTarget:self action:@selector(guang) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UIButton *look =  [UIButton buttonWithType:UIButtonTypeCustom];
    [look setTitle:s2 forState:UIControlStateNormal];
    [look setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    look.frame = CGRectMake(kMSScreenWith/2+20, img.Bottom+40, kMSScreenWith/2-40, 30);
    look.backgroundColor = [RegularExpressionsMethod ColorWithHexString:@"C9C9C9"];
    look.titleLabel.font = Font(15);
    [look addTarget:self action:@selector(look) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:look];
    
}

-(void)guang
{
    if([_state isEqualToNumber:@(0)])
    {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    else
    {
        self.hidesBottomBarWhenPushed = YES;
        WJOrderMainViewController *ad = [[WJOrderMainViewController alloc]init];
        ad.serverType=1;
        [self.navigationController pushViewController:ad animated:YES];
    }
}
-(void)showleft
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
-(void)look
{
    self.hidesBottomBarWhenPushed = YES;
    WJOrderMainViewController *ad = [[WJOrderMainViewController alloc]init];
    ad.serverType=2;
    [self.navigationController pushViewController:ad animated:YES];
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
