//
//  WJPushPasswordViewController.m
//  MHUAPP
//
//  Created by jinri on 2017/12/11.
//  Copyright © 2017年 wenchengjun. All rights reserved.
//

#import "WJPushPasswordViewController.h"
#import "WJLoginClassViewController.h"

@interface WJPushPasswordViewController ()

@end

@implementation WJPushPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [RegularExpressionsMethod ColorWithHexString:kMSVCBackgroundColor];
    [self initSendReplyWithTitle:@"账户注册" andLeftButtonName:@"ic_back.png" andRightButtonName:nil andTitleLeftOrRight:YES];
    // Do any additional setup after loading the view from its nib.
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

- (IBAction)rigister:(id)sender {
    if (![self.text_secondF.text isEqualToString: self.text_password.text]) {
        [self jxt_showAlertWithTitle:@"消息提示" message:@"两次密码输入不一致！" appearanceProcess:^(JXTAlertController * _Nonnull alertMaker) {
            alertMaker.toastStyleDuration = 2;
        } actionsBlock:NULL];
        return;
    }
    [self.text_password resignFirstResponder];
    [self.text_secondF resignFirstResponder];
    [SVProgressHUD showErrorWithStatus:@"正在注册"];
    NSMutableDictionary *infos = [NSMutableDictionary dictionary];
    [infos setObject:self.str_phone forKey:@"user_name"];
    [infos setObject:self.str_code forKey:@"code"];
    [infos setObject:[self.text_password.text md5] forKey:@"user_password"];
    [self requestAPIWithServe:[kMSBaseLargeCollectionPortURL stringByAppendingString:kMSUserRegister] andInfos:infos];
}

-(void)processData
{
    [SVProgressHUD dismiss];
    if([[self.results objectForKey:@"code"] integerValue] == 200)
    {
        NSString *msgadsasd = [self.results objectForKey:@"msg"];
        NSLog(@"JSON: %@", self.results);
        [self jxt_showAlertWithTitle:@"消息提示" message:msgadsasd appearanceProcess:^(JXTAlertController * _Nonnull alertMaker) {
            alertMaker.toastStyleDuration = 2;
            NSMutableDictionary *infodic = [NSMutableDictionary dictionary];
            [infodic setValue:self.str_phone forKey:@"account"];
            [infodic setValue:self.text_password.text forKey:@"password"];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"poptoUserClassVC" object:self userInfo:infodic];
            for (UIViewController *temp in self.navigationController.viewControllers) {
                if ([temp isKindOfClass:[WJLoginClassViewController class]]) {
                    [self.navigationController popToViewController:temp animated:YES];
                }
            }

        } actionsBlock:NULL];
    }
    else
    {
        [SVProgressHUD showErrorWithStatus:[self
                                            .results objectForKey:@"msg"]];
        return;
    }
}
@end
