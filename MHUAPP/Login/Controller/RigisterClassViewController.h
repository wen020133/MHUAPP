//
//  RigisterClassViewController.h
//  meijiaPrinter
//
//  Created by 今日电器 on 15/7/10.
//  Copyright (c) 2015年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIButton+CountDown.h"
#import "MJCountDownButton.h"

@interface RigisterClassViewController : UIViewController
@property (strong, nonatomic)  UIScrollView *scr_rigisterCon;

@property (strong, nonatomic)  MJCountDownButton *cBtn;

@property (strong, nonatomic)  UITextField *text_code;
@property (strong, nonatomic)  UITextField *text_moblieNumber;
@property (strong, nonatomic)  UITextField *text_passwod;
@property (strong, nonatomic)  UITextField *text_PasswordAgain;
@end
