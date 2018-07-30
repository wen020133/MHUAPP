//
//  WJLoginClassViewController.m
//  MHUAPP
//
//  Created by jinri on 2017/12/7.
//  Copyright © 2017年 wenchengjun. All rights reserved.
//
#define AccountInitHeightY 100
#import "WJLoginClassViewController.h"
#import "XYMKeyChain.h"
#import <UMShare/UMShare.h>
#import "ForgetPasswordViewController.h"
#import "RigisterClassViewController.h"

#import "AppDelegate.h"
#import "RCDataManager.h"

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
    [self LoginServiceRequest];

}

-(void)initLoginClassVC
{
    UIControl *contrVC = [[UIControl alloc]initWithFrame:CGRectMake(0, 0, kMSScreenWith, kMSScreenHeight-kMSNaviHight)];
    contrVC.backgroundColor = [UIColor clearColor];
    [contrVC addTarget:self action:@selector(hiddenTextfiledView) forControlEvents:UIControlEventTouchDown];

    for (int aa=0; aa<2; aa++) {
        UIImageView *img_back = [[UIImageView alloc]initWithFrame:CGRectMake(40, AccountInitHeightY+aa*74, kMSScreenWith-80, 44)];
        img_back.backgroundColor = [[RegularExpressionsMethod ColorWithHexString:kGrayBgColor] colorWithAlphaComponent:0.5];
        [contrVC addSubview:img_back];
    }

    UIImageView *img_mobile = [[UIImageView alloc]initWithFrame:CGRectMake(57, AccountInitHeightY+7, 28, 28)];
    img_mobile.image = [UIImage imageNamed:@"login_mobile.png"];
    [contrVC addSubview:img_mobile];


    self.text_mobileNumber = [[UITextField alloc]initWithFrame:CGRectMake(97, AccountInitHeightY+2, kMSScreenWith-140, 40)];
    self.text_mobileNumber.backgroundColor = [UIColor clearColor];
    self.text_mobileNumber.delegate = self;
//    self.text_mobileNumber.text = @"15875511956";
    self.text_mobileNumber.placeholder = @"请输入账号";
    //边框宽度及颜色设置
//    self.text_mobileNumber.keyboardType = UIKeyboardTypePhonePad;
    [contrVC addSubview:self.text_mobileNumber];

    UIImageView *img_mima = [[UIImageView alloc]initWithFrame:CGRectMake(57, AccountInitHeightY+44+37, 28, 28)];
    img_mima.image = [UIImage imageNamed:@"login_mima.png"];
    [contrVC addSubview:img_mima];

    self.textF_password = [[UITextField alloc]initWithFrame:CGRectMake(97, AccountInitHeightY+44+32, kMSScreenWith-140, 40)];
    self.textF_password.backgroundColor = [UIColor clearColor];
    self.textF_password.delegate = self;
    self.textF_password.placeholder = @"请输入密码";
    [self.textF_password setSecureTextEntry:YES];
    [contrVC addSubview:self.textF_password];
    [self.view addSubview:contrVC];

    UIButton *btn_findpassword = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn_findpassword setFrame:CGRectMake(20, AccountInitHeightY+197, 130, 35)];
    [btn_findpassword setBackgroundColor:[UIColor clearColor]];
    btn_findpassword.titleLabel.font = PFR14Font;
    [btn_findpassword setTitleColor:[RegularExpressionsMethod ColorWithHexString:BASEBLACKCOLOR] forState:UIControlStateNormal];
    [btn_findpassword setTitle:@"*忘记密码" forState:UIControlStateNormal];
    [btn_findpassword addTarget:self action:@selector(gotoFindPasswordVC) forControlEvents:UIControlEventTouchUpInside];
    [contrVC addSubview:btn_findpassword];

    UIButton *btn_rigister = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn_rigister setFrame:CGRectMake(kMSScreenWith-150, AccountInitHeightY+197, 130, 35)];
    [btn_rigister setBackgroundColor:[UIColor clearColor]];
    [btn_rigister.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [btn_rigister setTitle:@"*注册账号" forState:UIControlStateNormal];
    btn_rigister.titleLabel.font = PFR14Font;
    [btn_rigister setTitleColor:[RegularExpressionsMethod ColorWithHexString:BASEBLACKCOLOR] forState:UIControlStateNormal];
    [btn_rigister addTarget:self action:@selector(gotoRigisterVC) forControlEvents:UIControlEventTouchUpInside];
    [contrVC addSubview:btn_rigister];


    UIButton *btn_login = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn_login setFrame:CGRectMake(40, AccountInitHeightY+88+60, kMSScreenWith-80, 44)];
    [btn_login setBackgroundColor:[UIColor redColor]];
    [btn_login setTitle:@"登  录" forState:UIControlStateNormal];
    btn_login.titleLabel.font = [UIFont systemFontOfSize:18];
    [btn_login setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn_login addTarget:self action:@selector(LoginServiceRequest) forControlEvents:UIControlEventTouchUpInside];
    [contrVC addSubview:btn_login];

    UIButton *btn_qq = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn_qq setBackgroundImage:[UIImage imageNamed:@"login_qq"] forState:UIControlStateNormal];

    if ( [[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_WechatSession]) {
        [btn_qq setFrame:CGRectMake(kMSScreenWith/3-22, AccountInitHeightY+290, 44, 44)];
    }
    else
    {
        [btn_qq setFrame:CGRectMake(kMSScreenWith/2-22, AccountInitHeightY+290, 44, 44)];
    }
    [btn_qq addTarget:self action:@selector(loginQQ) forControlEvents:UIControlEventTouchUpInside];
    [contrVC addSubview:btn_qq];

    UILabel *lab_qq= [[UILabel alloc]init];
    if ( [[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_WechatSession]) {
        lab_qq.frame = CGRectMake(kMSScreenWith/3-40, AccountInitHeightY+290+48, 80, 20);
    }
    else
    {
        lab_qq.frame = CGRectMake(kMSScreenWith/2-40,  AccountInitHeightY+290+48, 80, 20);
    }
    lab_qq.text = @"QQ";
    lab_qq.font = [UIFont systemFontOfSize:13];
    lab_qq.textColor = [UIColor lightGrayColor];
    lab_qq.textAlignment = NSTextAlignmentCenter;
    [contrVC addSubview:lab_qq];

    UIButton *btn_weixin = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn_weixin setBackgroundImage:[UIImage imageNamed:@"login_weixin.png"] forState:UIControlStateNormal];
    [btn_weixin setFrame:CGRectMake(kMSScreenWith/3*2-22,  AccountInitHeightY+290, 44, 44)];
    if ( [[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_WechatSession])
    {
        [btn_weixin addTarget:self action:@selector(sendAuthRequestWX) forControlEvents:UIControlEventTouchUpInside];
        [contrVC addSubview:btn_weixin];
    }

    UILabel *lab_Wechat= [[UILabel alloc]init];
    lab_Wechat.text = @"微信";
    lab_Wechat.font = [UIFont systemFontOfSize:13];
    lab_Wechat.textColor = [UIColor lightGrayColor];
    lab_Wechat.textAlignment = NSTextAlignmentCenter;
    if ( [[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_WechatSession]) {
        lab_Wechat.frame = CGRectMake(kMSScreenWith/3*2-40,  AccountInitHeightY+290+48, 80, 20);
        [contrVC addSubview:lab_Wechat];
    }
}

-(void)gotoFindPasswordVC
{
    ForgetPasswordViewController *forgetPassVC = [[ForgetPasswordViewController alloc]init];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:forgetPassVC animated:YES];
}

-(void)gotoRigisterVC
{
    RigisterClassViewController *rigisterVC = [[RigisterClassViewController alloc]init];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:rigisterVC animated:YES];
}

-(void)LoginServiceRequest
{
    [self.text_mobileNumber resignFirstResponder];
    [self.textF_password resignFirstResponder];
    if (self.text_mobileNumber.text.length<6) {

         [SVProgressHUD showErrorWithStatus:@"请输入6位以上的账号"];
        return;
    }
    else if (self.textF_password.text.length<6)
    {
        [SVProgressHUD showErrorWithStatus:@"请输入6位以上密码"];
        return;
    }
    self.regType = 0;
   [SVProgressHUD showWithStatus:@"正在登录..."];
    NSMutableDictionary *infos = [NSMutableDictionary dictionary];
    [infos setObject:self.text_mobileNumber.text forKey:@"user_name"];
    [infos setObject:[self.textF_password.text md5] forKey:@"user_password"];
    [self requestAPIWithServe:[kMSBaseLargeCollectionPortURL stringByAppendingString:kMSLoginURL] andInfos:infos];
}

-(void)getAccountToken:(NSString *)user_id
{
    self.regType = 2;
    NSMutableDictionary *infos = [NSMutableDictionary dictionary];
    [infos setObject:user_id forKey:@"user_id"];
    [self requestAPIWithServe:[kMSBaseMiYoMeiPortURL stringByAppendingString:kMSGetAccessToken] andInfos:infos];
}
-(void)processData
{
    [SVProgressHUD dismiss];
    if([[self.results objectForKey:@"code"] integerValue] == 200)
    {
        NSLog(@"responseObject====%@",[self.results objectForKey:@"msg"]);
        switch (_regType) {
            case 0:
            {
                [XYMKeyChain deleteKeyChainItemWithKey:KEY_KEYCHAINITEM];
                // Save some stuffs
                NSMutableDictionary *userinfo = [NSMutableDictionary dictionary];
                [userinfo setObject:self.text_mobileNumber.text forKey:KEY_USERNAME];
                [userinfo setObject:self.textF_password.text forKey:KEY_PASSWORD];
                [XYMKeyChain saveKeyChainItemWithKey:KEY_KEYCHAINITEM item:userinfo];

                NSMutableDictionary *dic = [NSMutableDictionary dictionary];
                [dic setValue:[[self.results objectForKey:@"data"] objectForKey:@"user_id" ] forKey:@"uid"];
                 [AppDelegate shareAppDelegate].user_id = [NSString stringWithFormat:@"%@",[[self.results objectForKey:@"data"] objectForKey:@"user_id"]];
                [dic setValue:[[self.results objectForKey:@"data"] objectForKey:@"user_name" ] forKey:@"username"];
                [dic setValue:ConvertNullString([[self.results objectForKey:@"data"] objectForKey:@"mobile_phone" ]) forKey:@"phone"];
                NSString *logo_img =ConvertNullString([[self.results objectForKey:@"data"] objectForKey:@"headimg" ]);
                if (logo_img.length>0) {
                    [dic setValue:logo_img forKey:@"user_icon"];
                }else
                {
                    [dic setValue:@"" forKey:@"user_icon"];
                }

                [dic setValue:ConvertNullString([[self.results objectForKey:@"data"] objectForKey:@"email" ]) forKey:@"email"];
                NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                [userDefaults setObject:dic forKey:@"userList"];
                [userDefaults setObject:@"1" forKey:@"loginState"];
                [userDefaults setObject:@"phone" forKey:@"loginType"];
                [userDefaults synchronize];
                [self getAccountToken:[[self.results objectForKey:@"data"] objectForKey:@"user_id"]];
//                [self.navigationController popViewControllerAnimated:YES];
//                [self dismissViewControllerAnimated:YES completion:^{
//
//                }];
            }
                break;
            case 1:
            {
                id data = [self.results objectForKey:@"data"];
                if ([data isKindOfClass:[NSDictionary class]] ) {
                    [XYMKeyChain deleteKeyChainItemWithKey:KEY_KEYCHAINITEM];
                    // Save some stuffs
                    NSMutableDictionary *userinfo = [NSMutableDictionary dictionary];
                    [userinfo setObject:@"" forKey:KEY_USERNAME];
                    [userinfo setObject:@"" forKey:KEY_PASSWORD];
                    [XYMKeyChain saveKeyChainItemWithKey:KEY_KEYCHAINITEM item:userinfo];

                    NSMutableDictionary *dic = [NSMutableDictionary dictionary];

                    [dic setValue:[NSString stringWithFormat:@"%@",[[self.results objectForKey:@"data"] objectForKey:@"user_id"]] forKey:@"uid"];
                    [AppDelegate shareAppDelegate].user_id = [NSString stringWithFormat:@"%@",[[self.results objectForKey:@"data"] objectForKey:@"user_id"]];
                    [dic setValue:self.outUserId forKey:@"other_uid"];
                    [dic setValue:ConvertNullString([[[self.results objectForKey:@"data"] objectForKey:@"info"] objectForKey:@"user_name" ]) forKey:@"username"];
                    [dic setValue:ConvertNullString([[[self.results objectForKey:@"data"] objectForKey:@"info"] objectForKey:@"user_tel" ]) forKey:@"phone"];
                    NSString *logo_img =ConvertNullString([[[self.results objectForKey:@"data"] objectForKey:@"info"] objectForKey:@"headimg" ]);
                    if (logo_img.length>0) {
                        [dic setValue:logo_img forKey:@"user_icon"];
                    }else
                    {
                        [dic setValue:@"" forKey:@"user_icon"];
                    }

                    [dic setValue:ConvertNullString([[[self.results objectForKey:@"data"] objectForKey:@"info"] objectForKey:@"email" ]) forKey:@"email"];
                    [dic setValue:[[[self.results objectForKey:@"data"] objectForKey:@"info"] objectForKey:@"sex"] forKey:@"sex"];
                    [dic setValue:ConvertNullString([[[self.results objectForKey:@"data"] objectForKey:@"info"] objectForKey:@"user_nickname" ]) forKey:@"nickname"];
                    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                    [userDefaults setObject:dic forKey:@"userList"];
                    [userDefaults setObject:@"1" forKey:@"loginState"];
                    [userDefaults setObject:self.outUserType forKey:@"loginType"];
                    [userDefaults synchronize];
                    [self getAccountToken:[[self.results objectForKey:@"data"] objectForKey:@"user_id"]];
//                    [self.navigationController popViewControllerAnimated:YES];
//                    [self dismissViewControllerAnimated:YES completion:^{
//
//                    }];
                }
                else
                {
                    [SVProgressHUD showErrorWithStatus:@"获取数据失败"];
                }

            }
                break;
                case 2:
            {
                  NSString *data = [self.results objectForKey:@"data"];
                NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                [userDefaults setObject:data forKey:@"accessToken"];
                [userDefaults synchronize];
                NSString *str_username = [[userDefaults objectForKey:@"userList"] objectForKey:@"username"];
                NSString *str_logo_img = [[userDefaults objectForKey:@"userList"] objectForKey:@"user_icon"];
                NSString *user_id =[NSString stringWithFormat:@"guke%@", [AppDelegate shareAppDelegate].user_id];
                //融云
                [[RCIM sharedRCIM] initWithAppKey:RONGClOUDAPPKEY];
                [RCIM sharedRCIM].userInfoDataSource = [RCDataManager shareManager];
                [RCIM sharedRCIM].enablePersistentUserInfoCache = YES;
                [RCIM sharedRCIM].enableMessageAttachUserInfo = YES;
//                [[RCIM sharedRCIM]refreshUserInfoCache:[[RCUserInfo alloc]initWithUserId:user_id name:str_username portrait:str_logo_img] withUserId:user_id];
                [[RCDataManager shareManager] loginRongCloudWithUserInfo:[[RCUserInfo alloc]initWithUserId:user_id name:str_username portrait:str_logo_img] withToken:data];
                [self.navigationController popViewControllerAnimated:YES];
                [self dismissViewControllerAnimated:NO completion:^{

                }];
            }
                break;
            default:
                break;
        }



    }
    else
    {
        [SVProgressHUD showErrorWithStatus:[self.results objectForKey:@"msg"]];
        return;
    }
}

-(void)hiddenTextfiledView
{
    [self.textF_password resignFirstResponder];
    [self.text_mobileNumber resignFirstResponder];
}

-(void)loginQQ
{
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_QQ currentViewController:nil completion:^(id result, NSError *error) {
        if (error) {
            NSLog(@"QQ登录失败---%@",[NSString stringWithFormat:@"%@",[error localizedDescription]]);
            [SVProgressHUD showErrorWithStatus:@"QQ登录失败！"];
        } else {
            UMSocialUserInfoResponse *resp = result;
            self.outUserId = resp.uid;
            self.outUserType = @"qq";
            self.outNickName = resp.name;
            [self gotoAccountBindVC:self.outUserId outUserType:self.outUserType outNickName:self.outNickName outHeadUrl:resp.iconurl outSex:resp.unionGender];
            // 授权信息
            NSLog(@"QQ uid: %@", resp.uid);
            NSLog(@"QQ openid: %@", resp.openid);
            NSLog(@"QQ unionid: %@", resp.unionId);
            NSLog(@"QQ accessToken: %@", resp.accessToken);
            NSLog(@"QQ expiration: %@", resp.expiration);

            // 用户信息
            NSLog(@"QQ name: %@", resp.name);
            NSLog(@"QQ iconurl: %@", resp.iconurl);
            NSLog(@"QQ gender: %@", resp.unionGender);

            // 第三方平台SDK源数据
            NSLog(@"QQ originalResponse: %@", resp.originalResponse);
        }
    }];
}
-(void)sendAuthRequestWX
{
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_WechatSession currentViewController:nil completion:^(id result, NSError *error) {
        if (error) {
            NSLog(@"微信登录失败----%@",[NSString stringWithFormat:@"%@",[error localizedDescription]]);
            [SVProgressHUD showErrorWithStatus:@"微信登录失败！"];
        } else {
            UMSocialUserInfoResponse *resp = result;
            self.outUserId = resp.uid;
            self.outUserType = @"weixin";
            self.outNickName = resp.name;
            [self gotoAccountBindVC:self.outUserId outUserType:self.outUserType outNickName:self.outNickName outHeadUrl:resp.iconurl outSex:resp.gender];
            // 授权信息
            NSLog(@"weixin uid: %@", resp.uid);
            NSLog(@"weixin openid: %@", resp.openid);
            NSLog(@"weixin unionid: %@", resp.unionId);
            NSLog(@"weixin accessToken: %@", resp.accessToken);
            NSLog(@"weixin expiration: %@", resp.expiration);
            
            // 用户信息
            NSLog(@"weixin name: %@", resp.name);
            NSLog(@"weixin iconurl: %@", resp.iconurl);
            NSLog(@"weixin gender: %@", resp.unionGender);
            
            // 第三方平台SDK源数据
            NSLog(@"weixin originalResponse: %@", resp.originalResponse);
        }
    }];
}
-(void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)backToPreviousPageAction:(id)sender
{
    [self dismissViewControllerAnimated:NO completion:^{

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
-(void)gotoAccountBindVC:(NSString *)outUserId outUserType:(NSString *)outUserType outNickName:(NSString *)outNickName outHeadUrl:(NSString *)outHeadUrl outSex:(NSString *)outSex
{
    self.regType = 1;
    if(outUserId.length>1)
    {
         [SVProgressHUD showWithStatus:@"正在登录..."];
        NSMutableDictionary *infos = [NSMutableDictionary dictionary];
        
        if ([outUserType isEqualToString:@"qq"]) {
            [infos setObject:outUserId forKey:@"usid"];
            [infos setObject:outNickName forKey:@"user_name"];
            [infos setObject:outSex forKey:@"sex"];
            [infos setObject:outHeadUrl forKey:@"user_icon"];
            [self requestAPIWithServe:[kMSBaseLargeCollectionPortURL stringByAppendingString:kMSLoginqq] andInfos:infos];
        }
        else if  ([outUserType isEqualToString:@"weixin"]) {
            [infos setObject:outUserId forKey:@"openid"];
            [infos setObject:outNickName forKey:@"nickname"];
            [infos setObject:outSex forKey:@"sex"];
            [infos setObject:outHeadUrl forKey:@"headimgurl"];
            [self requestAPIWithServe:[kMSBaseMiYoMeiPortURL stringByAppendingString:kMSWeiXinLogin] andInfos:infos];
        }
        
    }
    else
    {
        [SVProgressHUD showErrorWithStatus:@"授权失败"];
        return;
    }

}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
