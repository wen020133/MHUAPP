//
//  RigisterClassViewController.m
//  meijiaPrinter
//
//  Created by 今日电器 on 15/7/10.
//  Copyright (c) 2015年 wenchengjun. All rights reserved.
//

#import "RigisterClassViewController.h"
#import "XYMKeyChain.h"


@interface RigisterClassViewController ()

@end

@implementation RigisterClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [RegularExpressionsMethod ColorWithHexString:kMSVCBackgroundColor];
    [self initSendReplyWithTitle:@"注册" andLeftButtonName:@"ic_back.png" andRightButtonName:nil andTitleLeftOrRight:YES];
    self.scr_rigisterCon.frame = CGRectMake(0, 0, kMSScreenWith, kMSScreenHeight);
     self.scr_rigisterCon.contentSize = CGSizeMake(kMSScreenWith, kMSScreenHeight+60);
    [self.view addSubview:self.scr_rigisterCon];
//    self.text_moblieNumber.text = @"690692059@qq.com";
//    self.text_moblieNumber.text = @"15875511956";
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
    if (![RegularExpressionsMethod validateMobile:self.text_moblieNumber.text]) {
        
//        [RegularExpressionsMethod alrtTitle:@"消息提示" AndMessage:@"请输入正确的手机号码！"];
//        return;
    }
   else if (self.text_passwod.text.length<6)
    {
        [SVProgressHUD showErrorWithStatus:@"请输入6位以上的密码！"];
        return;
    }
    
   else if (![self.text_passwod.text isEqualToString:self.text_PasswordAgain.text]) {
       [SVProgressHUD showErrorWithStatus:@"两次输入的密码不一致！"];
        return;
    }
   else if (self.text_code.text.length<1)
    {
        [SVProgressHUD showErrorWithStatus:@"请输入验证码！"];
        return;
    }
    [self.text_code resignFirstResponder];
    [self.text_moblieNumber resignFirstResponder];
    [self.text_passwod resignFirstResponder];
    [self.text_PasswordAgain resignFirstResponder];
    [SVProgressHUD showWithStatus:@"正在注册..."];
    NSMutableDictionary *infos = [NSMutableDictionary dictionary];
    [infos setObject:self.text_moblieNumber.text forKey:@"user_name"];
    [infos setObject:self.text_code.text forKey:@"code"];
    [infos setObject:[self.text_passwod.text md5] forKey:@"user_pwd"];
//    [self requestAPIWithServe:[kMSBaseLargeCollectionPortURL stringByAppendingString:kMSUserRegister] andInfos:infos];

}
//-(void)processData
//{
//    if([[self.results objectForKey:@"code"] integerValue] == 200)
//    {
//        NSString *msg = [self.results objectForKey:@"msg"];
//        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"消息提示" message:@"注册成功" preferredStyle:UIAlertControllerStyleAlert];
//        UIAlertAction *serviceAction = [UIAlertAction actionWithTitle:@"登录" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//
//            NSMutableDictionary *infodic = [NSMutableDictionary dictionary];
//            [infodic setValue:self.text_moblieNumber.text forKey:@"account"];
//            [infodic setValue:self.text_passwod.text forKey:@"password"];
//            [[NSNotificationCenter defaultCenter] postNotificationName:@"poptoUserClassVC" object:self userInfo:infodic];
//            [self.navigationController popViewControllerAnimated:YES];
//
//        }];
//        [alertVC addAction:serviceAction];
//        [self presentViewController:alertVC animated:YES completion:nil];
//
//
//    }
//    else
//    {
//        jxt_showAlertTitle([self
//                           .results objectForKey:@"msg"]);
//    }
//}

- (IBAction)chickBtn:(id)sender {
    if(self.text_moblieNumber.text.length<1)
    {
       [SVProgressHUD showErrorWithStatus:@"请输入账号"];
        return;
    }
    [_cBtn countDownFromTime:60 unitTitle:@"s" completion:^(MJCountDownButton *countDownButton) {
        [countDownButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    }];
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970];  //  *1000 是精确到毫秒，不乘就是精确到秒
    NSString *timeString = [NSString stringWithFormat:@"%.0f",a ]; //转为字符型
    
//   NSString *token= [[NSString stringWithFormat:@"beck_%@_beck",[timeString md5]] md5] ;

//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/xml",@"text/plain", nil ];
//    [manager GET:[NSString stringWithFormat:@"%@%@/%@/%@/%@",kMSBaseCodePortURL,timeString,token,self.text_moblieNumber.text,@"0"] parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
//        NSLog(@"JSON: %@", responseObject);
//        if ([responseObject isKindOfClass:[NSDictionary class]]) {
//            NSDictionary *dic = responseObject;
//            NSString *str=[dic objectForKey:@"msg"];
//            if([[dic objectForKey:@"code"] integerValue] == 200)
//            {
//                 [RegularExpressionsMethod alrtTitle:@"消息提示" AndMessage:str];
//            }
//            else
//            {
//                [RegularExpressionsMethod alrtTitle:@"消息提示" AndMessage:str];
//            }
//            
//        }
//        
//    } failure:^(NSURLSessionTask *operation, NSError *error) {
//        NSLog(@"Error: %@", error);
//    }];
}
@end
