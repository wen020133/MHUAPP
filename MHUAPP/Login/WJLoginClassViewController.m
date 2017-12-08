//
//  WJLoginClassViewController.m
//  MHUAPP
//
//  Created by jinri on 2017/12/7.
//  Copyright © 2017年 wenchengjun. All rights reserved.
//

#import "WJLoginClassViewController.h"
#import "XYMKeyChain.h"
#import <UMSocialCore/UMSocialCore.h>

@interface WJLoginClassViewController ()

@end

@implementation WJLoginClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSendReplyWithTitle:@"登录" andLeftButtonName:@"ic_back.png" andRightButtonName:nil andTitleLeftOrRight:YES];
    self.view.backgroundColor = kMSViewBackColor;
    [self initLoginClassVC];
    [[NSNotificationCenter defaultCenter] addObserver:self

                                             selector:@selector(poptoUserClassVC:)
                                                 name:@"poptoUserClassVC"
                                               object:nil];
    // Do any additional setup after loading the view.
}
-(void)poptoUserClassVC:(NSNotification *)notification
{
    self.text_mobileNumber.text = [notification.userInfo objectForKey:@"account"];
    self.textF_password.text = [notification.userInfo objectForKey:@"password"];
//    [self LoginToafrica];

}

-(void)initLoginClassVC
{
    UIControl *contrVC = [[UIControl alloc]initWithFrame:CGRectMake(0, 0, kMSScreenWith, kMSScreenHeight-kMSNaviHight)];
    contrVC.backgroundColor = [UIColor clearColor];
    [contrVC addTarget:self action:@selector(hiddenTextfiledView) forControlEvents:UIControlEventTouchDown];

    for (int aa=0; aa<2; aa++) {
        UIImageView *img_back = [[UIImageView alloc]initWithFrame:CGRectMake(20, 35+aa*48, kMSScreenWith-40, 44)];
        img_back.backgroundColor = [RegularExpressionsMethod ColorWithHexString:kGrayBgColor];
        [contrVC addSubview:img_back];
    }

    UIImageView *img_mobile = [[UIImageView alloc]initWithFrame:CGRectMake(37, 42, 20, 30)];
    img_mobile.image = [UIImage imageNamed:@"login_mobile.png"];
    [contrVC addSubview:img_mobile];


    self.text_mobileNumber = [[UITextField alloc]initWithFrame:CGRectMake(80, 37, kMSScreenWith-100, 40)];
    self.text_mobileNumber.backgroundColor = [UIColor clearColor];
    self.text_mobileNumber.delegate = self;
    //    self.text_mobileNumber.text = @"15875511956";
    self.text_mobileNumber.placeholder = @"请输入账号";
    //边框宽度及颜色设置
    //    self.text_mobileNumber.keyboardType = UIKeyboardTypePhonePad;
    [contrVC addSubview:self.text_mobileNumber];

    UIImageView *img_mima = [[UIImageView alloc]initWithFrame:CGRectMake(37, 93, 20, 20)];
    img_mima.image = [UIImage imageNamed:@"login_mima.png"];
    [contrVC addSubview:img_mima];

    self.textF_password = [[UITextField alloc]initWithFrame:CGRectMake(80, 85, kMSScreenWith-100, 40)];
    self.textF_password.backgroundColor = [UIColor clearColor];
    self.textF_password.delegate = self;
    self.textF_password.placeholder = @"请输入密码";
    [self.textF_password setSecureTextEntry:YES];
    [contrVC addSubview:self.textF_password];
    [self.view addSubview:contrVC];

    UIButton *btn_findpassword = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn_findpassword setFrame:CGRectMake(20, 140, 130, 35)];
    [btn_findpassword setBackgroundColor:[UIColor clearColor]];
    [btn_findpassword.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [btn_findpassword setTitle:@"忘记密码" forState:UIControlStateNormal];

    [btn_findpassword setTitleColor:kMSNavBarBackColor forState:UIControlStateNormal];
    [btn_findpassword addTarget:self action:@selector(gotoFindPasswordVC) forControlEvents:UIControlEventTouchUpInside];
    [contrVC addSubview:btn_findpassword];

    UIButton *btn_rigister = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn_rigister setFrame:CGRectMake(kMSScreenWith-150, 140, 130, 35)];
    [btn_rigister setBackgroundColor:[UIColor clearColor]];
    [btn_rigister.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [btn_rigister setTitle:@"注册" forState:UIControlStateNormal];

    [btn_rigister setTitleColor:kMSNavBarBackColor forState:UIControlStateNormal];
    [btn_rigister addTarget:self action:@selector(gotoRigisterVC) forControlEvents:UIControlEventTouchUpInside];
    [contrVC addSubview:btn_rigister];


    UIButton *btn_login = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn_login setFrame:CGRectMake(kMSScreenWith/2-130, 200, 260, 44)];
    [btn_login setBackgroundImage:[UIImage imageNamed:@"print_chick_bg.jpg"] forState:UIControlStateNormal];
    [btn_login setTitle:@"登  录" forState:UIControlStateNormal];
    btn_login.titleLabel.font = [UIFont systemFontOfSize:18];
    [btn_login setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn_login addTarget:self action:@selector(LoginToafrica) forControlEvents:UIControlEventTouchUpInside];
    [contrVC addSubview:btn_login];

    UIButton *btn_qq = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn_qq setBackgroundImage:[UIImage imageNamed:@"login_qq.jpg"] forState:UIControlStateNormal];

    if ( [[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_WechatSession]) {
        [btn_qq setFrame:CGRectMake(kMSScreenWith/3-22, kMSScreenHeight/2+80, 44, 44)];
    }
    else
    {
        [btn_qq setFrame:CGRectMake(kMSScreenWith/2-22, kMSScreenHeight/2+80, 44, 44)];
    }
    [btn_qq addTarget:self action:@selector(loginQQ) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn_qq];

    UILabel *lab_qq= [[UILabel alloc]init];
    if ( [[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_WechatSession]) {
        lab_qq.frame = CGRectMake(kMSScreenWith/3-40, kMSScreenHeight/2+124, 80, 20);
    }
    else
    {
        lab_qq.frame = CGRectMake(kMSScreenWith/2-40,  kMSScreenHeight/2+124, 80, 20);
    }
    lab_qq.text = @"QQ";
    lab_qq.font = [UIFont systemFontOfSize:13];
    lab_qq.textColor = [UIColor lightGrayColor];
    lab_qq.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lab_qq];

    UIButton *btn_weixin = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn_weixin setBackgroundImage:[UIImage imageNamed:@"login_weix.jpg"] forState:UIControlStateNormal];
    [btn_weixin setFrame:CGRectMake(kMSScreenWith/3*2-22,  kMSScreenHeight/2+80, 44, 44)];
    if ( [[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_WechatSession])
    {
        [btn_weixin addTarget:self action:@selector(sendAuthRequestWX) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn_weixin];
    }

    UILabel *lab_Wechat= [[UILabel alloc]init];
    lab_Wechat.text = @"微信";
    lab_Wechat.font = [UIFont systemFontOfSize:13];
    lab_Wechat.textColor = [UIColor lightGrayColor];
    lab_Wechat.textAlignment = NSTextAlignmentCenter;
    if ( [[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_WechatSession]) {
        lab_Wechat.frame = CGRectMake(kMSScreenWith/3*2-40,  kMSScreenHeight/2+124, 80, 20);
        [self.view addSubview:lab_Wechat];
    }
}

-(void)hiddenTextfiledView
{

}

-(void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)backToPreviousPageAction:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:^{

    }];
}

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
    if([XYMKeyChain loadKeyChainItemWithKey:KEY_KEYCHAINITEM] != nil ){
        NSMutableDictionary *itemData = (NSMutableDictionary *)[XYMKeyChain loadKeyChainItemWithKey:KEY_KEYCHAINITEM];
        NSString *userName = [itemData objectForKey:KEY_USERNAME];
        self.text_mobileNumber.text = userName;
        NSString *passWord = [itemData objectForKey:KEY_PASSWORD];
        self.textF_password.text = passWord;
    }
    [super viewWillAppear:YES];
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
