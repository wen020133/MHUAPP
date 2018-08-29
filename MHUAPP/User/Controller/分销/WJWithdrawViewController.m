//
//  WJWithdrawViewController.m
//  MHUAPP
//
//  Created by wenchengjun on 2018/8/24.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import "WJWithdrawViewController.h"
#import "UIView+UIViewFrame.h"

@interface WJWithdrawViewController ()

@end

@implementation WJWithdrawViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [RegularExpressionsMethod ColorWithHexString:kMSVCBackgroundColor];
    [self initSendReplyWithTitle:@"提现" andLeftButtonName:@"ic_back.png" andRightButtonName:nil andTitleLeftOrRight:YES];
    // Do any additional setup after loading the view from its nib.
}

-(void)initWithdrawView
{
    UIImageView *headBV = ImageViewInit(0, 0, kMSScreenWith, 100);
    headBV.backgroundColor = kMSNavBarBackColor;
    [self.scr_withdraw addSubview:headBV];
    
    UILabel *labZHYE = LabelInit(DCMargin, 20, 200, 20);
    labZHYE.textColor = [UIColor whiteColor];
    labZHYE.text = @"账户余额（元）";
    labZHYE.font = Font(13);
    [self.scr_withdraw addSubview:labZHYE];
    
    self.labAmount = LabelInit(DCMargin, 50, 200, 40);
    self.labAmount.textColor = kMSCellBackColor;
    self.labAmount.font = Font(30);
    self.labAmount.text = @"0.00";
    [self.scr_withdraw addSubview:self.labAmount];
    
//    self.texf_ContactName = [[UITextField alloc]initWithFrame:CGRectMake(90, 12, kMSScreenWith-90, TextViewBackHight-2)];
//    self.texf_ContactName.font =[UIFont systemFontOfSize:14];
//    self.texf_ContactName.placeholder = @"请填写收货人姓名";
//    self.texf_ContactName.backgroundColor = [UIColor clearColor];
//    self.texf_ContactName.text =self.str_consignee;
//    [self.scr_content addSubview:self.texf_ContactName];
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
