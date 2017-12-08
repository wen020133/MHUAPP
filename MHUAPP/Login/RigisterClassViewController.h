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

@interface RigisterClassViewController : UIViewController<UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scr_rigisterCon;

- (IBAction)rigister:(id)sender;
@property (weak, nonatomic) IBOutlet MJCountDownButton *cBtn;
- (IBAction)chickBtn:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *text_code;
@property (weak, nonatomic) IBOutlet UITextField *text_moblieNumber;
@property (weak, nonatomic) IBOutlet UITextField *text_passwod;
@property (weak, nonatomic) IBOutlet UITextField *text_PasswordAgain;
@end
