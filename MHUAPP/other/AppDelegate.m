//
//  AppDelegate.m
//  MHUAPP
//
//  Created by wenchengjun on 2017/11/27.
//  Copyright © 2017年 wenchengjun. All rights reserved.
//

#import "AppDelegate.h"
#import <AlipaySDK/AlipaySDK.h>
#import <UMCommon/UMCommon.h>
#import <UMShare/UMShare.h>
#import "WXApiManager.h"
#import "RCDataManager.h"
#import "HcdGuideView.h"


NSString * const UpLoadNoti = @"uploadInfo";


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    self.tabbarVC  = [[WJMainTabBarViewController alloc]init];
    [self.window setRootViewController:self.tabbarVC];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [self.window makeKeyAndVisible];
    
    [WXApi registerApp:kAppIDWeixin];
    //设置友盟Appkey
    [UMConfigure initWithAppkey:UmengAppkey channel:@"App Store"];
    //设置微信AppId，设置分享url，
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:kAppIDWeixin appSecret:kAppSecret redirectURL:kRedirectURI];
    [self initLogin];

    //设置手机QQ的AppId，指定你的分享url，
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:_TencentAppid_  appSecret:@"9XSVjCRGjtSlYuEn" redirectURL:kRedirectURI];
    
    if ([application respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        //注册推送, 用于iOS8以及iOS8之后的系统
        UIUserNotificationSettings *settings = [UIUserNotificationSettings
                                                settingsForTypes:(UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert)
                                                categories:nil];
        [application registerUserNotificationSettings:settings];
    }
    
//    if (pushServiceData) {
//        NSLog(@"该启动事件包含来自融云的推送服务");
//        for (id key in [pushServiceData allKeys]) {
//            NSLog(@"%@", pushServiceData[key]);
//        }
//    } else {
//        NSLog(@"该启动事件不包含来自融云的推送服务");
//    }

    NSMutableArray *images = [NSMutableArray new];
    
    [images addObject:[UIImage imageNamed:@"project_iphone_1"]];
    [images addObject:[UIImage imageNamed:@"project_iphone_2"]];
    [images addObject:[UIImage imageNamed:@"project_iphone_3"]];
    
    HcdGuideView *guideView = [HcdGuideView sharedInstance];
    guideView.window = self.window;
    [guideView showGuideViewWithImages:images
                        andButtonTitle:nil
                   andButtonTitleColor:[UIColor clearColor]
                      andButtonBGColor:[UIColor clearColor]
                  andButtonBorderColor:[UIColor clearColor]];
    
    return YES;
}
-(void)initLogin{
    
    [[RCDataManager shareManager] getUserInfoWithMiYouMei];
}
/**
 * 推送处理2
 */
//注册用户通知设置
- (void)application:(UIApplication *)application
didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings {
    // register to receive notifications
    [application registerForRemoteNotifications];
}

/**
 * 推送处理3
 */
- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
//    NSString *token = [[[[deviceToken description] stringByReplacingOccurrencesOfString:@"<" withString:@""]
//                        stringByReplacingOccurrencesOfString:@">"
//                        withString:@""] stringByReplacingOccurrencesOfString:@" "
//                       withString:@""];
//    
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
#if TARGET_IPHONE_SIMULATOR
    // 模拟器不能使用远程推送
#else
    // 请检查App的APNs的权限设置，更多内容可以参考文档
    // http://www.rongcloud.cn/docs/ios_push.html。
    NSLog(@"获取DeviceToken失败！！！");
    NSLog(@"ERROR：%@", error);
#endif
}

- (void)onlineConfigCallBack:(NSNotification *)note {
    
    NSLog(@"online config has fininshed and note = %@", note.userInfo);
}

/**
 * 推送处理4
 * userInfo内容请参考官网文档
 */
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    /**
     * 统计推送打开率2
     */

}

- (void)applicationWillResignActive:(UIApplication *)application {
    
//        application.applicationIconBadgeNumber = unreadMsgCount;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
    if (!result) {
        if ([url.host isEqualToString:@"safepay"]) {
            [[AlipaySDK defaultService] processOrderWithPaymentResult:url
                                                      standbyCallback:^(NSDictionary *resultDic) {
                                                          //【由于在跳转支付宝客户端支付的过程中,商户 app 在后台很可能被系统 kill 了,所以 pay 接口的 callback 就会失效,请商户对 standbyCallback 返回的回调结果进行处理,就是在这个方 法里面处理跟 callback 一样的逻辑】
                                                          NSLog(@"result = %@",resultDic);
                                                          if ([[resultDic objectForKey:@"resultStatus"]integerValue]==9000)
                                                          {

                                                              NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
                                                              [center postNotificationName:UpLoadNoti object:nil];

                                                          }
                                                          else
                                                          {
                                                              UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"支付失败" preferredStyle:UIAlertControllerStyleAlert];
                                                              [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                                                                  
                                                              }]];
                                                              
                                                              [self.window.rootViewController presentViewController:alertController animated:YES completion:nil];
                                                          }
                                                      }];
            return YES;

        }
        if ([url.host isEqualToString:@"platformapi"]){//支付宝钱包快登授权返回 authCode
            [[AlipaySDK defaultService] processAuthResult:url standbyCallback:^(NSDictionary *resultDic) {
                //【由于在跳转支付宝客户端支付的过程中,商户 app 在后台很可能被系统 kill 了, 所以 pay 接口的 callback 就会失效,请商户对 standbyCallback 返回的回调结果进行处理,就 是在这个方法里面处理跟 callback 一样的逻辑】
                NSLog(@"result = %@",resultDic);
                if ([[resultDic objectForKey:@"resultStatus"]integerValue]==9000)
                {

                    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
                    [center postNotificationName:UpLoadNoti object:nil];

                }
                else
                {

                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"支付失败" preferredStyle:UIAlertControllerStyleAlert];
                    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                        
                    }]];
                    
                    [self.window.rootViewController presentViewController:alertController animated:YES completion:nil];
                }
            }];
            return YES;
        }
    }
    return result;
}
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options
{
    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
    BOOL result = [[UMSocialManager defaultManager]  handleOpenURL:url options:options];
    if (!result) {
        // 其他如支付等SDK的回调
        if ([url.host isEqualToString:@"safepay"]) {
            [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
                NSLog(@"result1 = %@",resultDic);
                if ([[resultDic objectForKey:@"resultStatus"]integerValue]==9000)
                {
                    
                    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
                    [center postNotificationName:UpLoadNoti object:nil];
                    
                }
            }];
            return YES;
        }else if ([url.host isEqualToString:@"platformapi"]){//支付宝钱包快登授权返回 authCode
            [[AlipaySDK defaultService] processAuthResult:url standbyCallback:^(NSDictionary *resultDic) {
                NSLog(@"result = %@",resultDic);
            }];
            return YES;
        }

        return  [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
    }
    return result;
}
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        // 其他如支付等SDK的回调
        return  [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
    }
    return result;
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
//    [UIApplication sharedApplication].applicationIconBadgeNumber = ToatalunreadMsgCount;

}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    NSLog(@"走了applicationWillEnterForeground方法");
}






- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}
+ (AppDelegate* )shareAppDelegate {
    return (AppDelegate*)[UIApplication sharedApplication].delegate;
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
