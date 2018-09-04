//
//  WJWithdrawViewController.h
//  MHUAPP
//
//  Created by wenchengjun on 2018/8/24.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WJWithdrawViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIScrollView *scr_withdraw;
@property (strong, nonatomic) UILabel *labAmount;
@property (strong, nonatomic) UITextField *texf_ContactName;
@property (strong, nonatomic) UIButton *btn_WX;
@property (strong, nonatomic) UIButton *btn_ZFB;
@property (weak, nonatomic) IBOutlet UIView *view_downUp;
@end
