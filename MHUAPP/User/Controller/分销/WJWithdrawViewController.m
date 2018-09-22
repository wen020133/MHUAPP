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

@property (nonatomic,strong) UIButton *selectedBtn;

@end

@implementation WJWithdrawViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [RegularExpressionsMethod ColorWithHexString:kMSVCBackgroundColor];
    [self initSendReplyWithTitle:@"分销提现" andLeftButtonName:@"ic_back.png" andRightButtonName:nil andTitleLeftOrRight:YES];
    [self initWithdrawView];
    // Do any additional setup after loading the view from its nib.
}

-(void)initWithdrawView
{
    UIImageView *headBV = ImageViewInit(0, 0, kMSScreenWith, 100);
    headBV.backgroundColor = kMSNavBarBackColor;
    [self.scr_withdraw addSubview:headBV];
    
    UILabel *labZHYE = LabelInit(DCMargin, 20, 200, 20);
    labZHYE.textColor = [UIColor whiteColor];
    labZHYE.text = @"可提现金额";
    labZHYE.font = Font(13);
    [self.scr_withdraw addSubview:labZHYE];
    
    self.labAmount = LabelInit(DCMargin, 50, 200, 40);
    self.labAmount.textColor = kMSCellBackColor;
    self.labAmount.font = Font(30);
    self.labAmount.text = @"0.00元";
    [self.scr_withdraw addSubview:self.labAmount];
    
    _btn_WX = [[UIButton alloc]initWithFrame:CGRectMake(kMSScreenWith/9, headBV.Bottom+20, kMSScreenWith/3, kMSScreenWith/9+3)];
    _btn_WX.tag = 1000;
    [_btn_WX setBackgroundImage:[UIImage imageNamed:@"user_fenxiaoWX.png"] forState:UIControlStateNormal];
    [_btn_WX setBackgroundImage:[UIImage imageNamed:@"user_fenxiaoWXSelect.png"] forState:UIControlStateSelected];
    [_btn_WX addTarget:self action:@selector(titleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.scr_withdraw addSubview:_btn_WX];
    
    _btn_ZFB = [[UIButton alloc]initWithFrame:CGRectMake(kMSScreenWith/9*5, headBV.Bottom+20, kMSScreenWith/3, kMSScreenWith/9+3)];
    _btn_ZFB.tag = 1001;
    [_btn_ZFB setBackgroundImage:[UIImage imageNamed:@"user_fenxiaoZFB.png"] forState:UIControlStateNormal];
    [_btn_ZFB setBackgroundImage:[UIImage imageNamed:@"user_fenxiaoZFBSelect.png"] forState:UIControlStateSelected];
    [_btn_ZFB addTarget:self action:@selector(titleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.scr_withdraw addSubview:_btn_ZFB];
  
    self.view_downUp.frame = CGRectMake(0, _btn_ZFB.Bottom+10, kMSScreenWith, 564);
    [self.scr_withdraw addSubview:self.view_downUp];
    
    self.scr_withdraw.contentSize = CGSizeMake(kMSScreenWith, 564+200);
}

-(void)titleBtnClick:(UIButton *)sender
{
    if (sender.tag==1000) {
        _btn_WX.selected = !_btn_WX.selected;
        _btn_ZFB.selected = NO;
    }
    else
    {
        _btn_ZFB.selected = !_btn_ZFB.selected;
        _btn_WX.selected = NO;
    }
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

- (IBAction)allDraw:(id)sender {
}
@end
