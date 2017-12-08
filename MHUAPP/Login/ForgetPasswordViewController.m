//
//  ForgetPasswordViewController.m
//  meijiaPrinter
//
//  Created by 今日电器 on 15/7/10.
//  Copyright (c) 2015年 wenchengjun. All rights reserved.
//

#import "ForgetPasswordViewController.h"
#import "XYMKeyChain.h"


@interface ForgetPasswordViewController ()

@end

@implementation ForgetPasswordViewController


-(void)viewWillAppear:(BOOL)animated
{
    if([XYMKeyChain loadKeyChainItemWithKey:KEY_KEYCHAINITEM] != nil ){
        NSMutableDictionary *itemData = (NSMutableDictionary *)[XYMKeyChain loadKeyChainItemWithKey:KEY_KEYCHAINITEM];
        NSString *userName = [itemData objectForKey:KEY_USERNAME];
        self.text_phoneNumber.text = userName;
        
    }
    [super viewWillAppear:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kMSViewBackColor;
    [self initSendReplyWithTitle:@"找回密码" andLeftButtonName:@"ic_back.png" andRightButtonName:nil andTitleLeftOrRight:YES];
    self.scr_content.frame = CGRectMake(0, 0, kMSScreenWith, kMSScreenHeight);
    self.scr_content.contentSize = CGSizeMake(kMSScreenWith, kMSScreenHeight+60);
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

- (IBAction)forGotPassword:(id)sender {
    if (![RegularExpressionsMethod validateMobile:self.text_phoneNumber.text]) {
       [SVProgressHUD showErrorWithStatus:@"请输入正确的手机号码！"];
        return;
    }
    else if (self.text_password.text.length<6)
    {
         [SVProgressHUD showErrorWithStatus:@"请输入6位以上的密码！"];
        return;
    }
    
    else if (![self.text_password.text isEqualToString:self.text_passwordAgain.text]) {
        [SVProgressHUD showErrorWithStatus:@"两次输入的密码不一致！"];
        return;
    }
    else if (self.text_code.text.length<1)
    {
        [SVProgressHUD showErrorWithStatus:@"请输入正确的验证码！"];
        return;
    }
    [SVProgressHUD showWithStatus:@"正在注册..."];
    NSMutableDictionary *infos = [NSMutableDictionary dictionary];
    [infos setObject:self.text_phoneNumber.text forKey:@"user_name"];
    [infos setObject:[self.text_password.text md5] forKey:@"user_pwd"];
    [infos setObject:self.text_code.text  forKey:@"code"];
//    [self requestAPIWithServe:[kMSBaseLargeCollectionPortURL stringByAppendingString:kMSFind_pwdURL] andInfos:infos];
}
//-(void)processData
//{
//    if([[self.results objectForKey:@"code"] integerValue] == 200)
//    {
//        NSLog(@"responseObject====%@",[self.results objectForKey:@"msg"]);
//        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"修改密码成功" message:nil preferredStyle:UIAlertControllerStyleAlert];
//        UIAlertAction *serviceAction = [UIAlertAction actionWithTitle:@"登录" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//
//            NSMutableDictionary *infodic = [NSMutableDictionary dictionary];
//            [infodic setValue:self.text_phoneNumber.text forKey:@"account"];
//            [infodic setValue:self.text_password.text forKey:@"password"];
//            [[NSNotificationCenter defaultCenter] postNotificationName:@"poptoUserClassVC" object:self userInfo:infodic];
//            [self.navigationController popViewControllerAnimated:YES];
//
//        }];
//        [alertVC addAction:serviceAction];
//        [self presentViewController:alertVC animated:YES completion:nil];
//    }
//    else
//    {
//        [RegularExpressionsMethod alrtTitle:@"消息提示" AndMessage:[self
//                                                                .results objectForKey:@"msg"]];
//    }
//}

- (IBAction)GetCode:(UIButton *)sender {
    if(self.text_phoneNumber.text.length<1)
    {
        [SVProgressHUD showErrorWithStatus:@"请输入账号"];
        return;
    }
    [_btn_code countDownFromTime:60 unitTitle:@"s" completion:^(MJCountDownButton *countDownButton) {
        [countDownButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    }];
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970];  //  *1000 是精确到毫秒，不乘就是精确到秒
    NSString *timeString = [NSString stringWithFormat:@"%.0f",a ]; //转为字符型
    
//    NSString *token= [[NSString stringWithFormat:@"beck_%@_beck",[timeString md5]] md5] ;

//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/xml",@"text/plain", nil ];
//    [manager GET:[NSString stringWithFormat:@"%@%@/%@/%@/%@",kMSBaseCodePortURL,timeString,token,self.text_phoneNumber.text,@"1"] parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
//        NSLog(@"JSON: %@", responseObject);
//        if ([responseObject isKindOfClass:[NSDictionary class]]) {
//            NSDictionary *dic = responseObject;
//            NSString *str=[dic objectForKey:@"msg"];
//        
//            [RegularExpressionsMethod alrtTitle:@"消息提示" AndMessage:str];
//            
//        }
//        
//    } failure:^(NSURLSessionTask *operation, NSError *error) {
//        NSLog(@"Error: %@", error);
//    }];
}
@end
