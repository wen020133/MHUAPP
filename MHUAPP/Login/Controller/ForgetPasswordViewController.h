//
//  ForgetPasswordViewController.h
//  meijiaPrinter
//
//  Created by 今日电器 on 15/7/10.
//  Copyright (c) 2015年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJCountDownButton.h"
#import "BaseNetworkViewController.h"


typedef NS_ENUM(NSInteger, KGetPassWordServerType) {
    KGetCodeServer = 1 ,//获取验证码
    KChangePassword = 2 ,//修改密码
};


@interface ForgetPasswordViewController : BaseNetworkViewController
@property (weak, nonatomic) IBOutlet UIScrollView *scr_content;
- (IBAction)forGotPassword:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *text_code;
@property (weak, nonatomic) IBOutlet UITextField *text_phoneNumber;
@property (weak, nonatomic) IBOutlet MJCountDownButton *btn_code;
@property (weak, nonatomic) IBOutlet UIButton *btn_again;

- (IBAction)GetCode:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UITextField *text_password;
@property (weak, nonatomic) IBOutlet UITextField *text_passwordAgain;

@property (assign, nonatomic) KGetPassWordServerType serverType;

@end
