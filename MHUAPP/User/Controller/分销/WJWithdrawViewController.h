//
//  WJWithdrawViewController.h
//  MHUAPP
//
//  Created by wenchengjun on 2018/8/24.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseNetworkViewController.h"


@interface WJWithdrawViewController : BaseNetworkViewController

@property (weak, nonatomic) IBOutlet UIScrollView *scr_withdraw;
@property (strong, nonatomic) UILabel *labAmount;
@property (strong, nonatomic) UIButton *btn_WX;
@property (strong, nonatomic) UIButton *btn_ZFB;
@property (weak, nonatomic) IBOutlet UIView *view_downUp;
- (IBAction)allDraw:(id)sender;

@property (weak, nonatomic) NSString *str_distributionMoney;
- (IBAction)depositDrow:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *textF_money;
@property (weak, nonatomic) IBOutlet UITextField *textF_account;
@property (weak, nonatomic) IBOutlet UITextField *textF_realName;
@property (weak, nonatomic) IBOutlet UITextField *textF_moble;
@property (weak, nonatomic) IBOutlet UITextView *textV_message;
- (IBAction)upImagePhoto:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *img_moneyContent;

@property (strong, nonatomic) NSString *payment;

@end
