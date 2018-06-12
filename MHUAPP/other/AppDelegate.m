//
//  AppDelegate.m
//  MHUAPP
//
//  Created by wenchengjun on 2017/11/27.
//  Copyright © 2017年 wenchengjun. All rights reserved.
//

#import "AppDelegate.h"
#import <AlipaySDK/AlipaySDK.h>
#import <UMSocialCore/UMSocialCore.h>
#import "WXApiManager.h"

NSString * const UpLoadNoti = @"uploadInfo";


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.friendsArray = [[NSMutableArray alloc]init];
    self.groupsArray = [[NSMutableArray alloc]init];
    
    self.tabbarVC  = [[WJMainTabBarViewController alloc]init];
    [self.window setRootViewController:self.tabbarVC];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    [WXApi registerApp:kAppIDWeixin];
    //设置友盟Appkey
    [[UMSocialManager defaultManager] setUmSocialAppkey:UmengAppkey];

    //设置微信AppId，设置分享url，
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:kAppIDWeixin appSecret:kAppSecret redirectURL:kRedirectURI];
    //初始化融云相关
    [self initRongClould];

    //设置手机QQ的AppId，指定你的分享url，
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:_TencentAppid_  appSecret:@"9XSVjCRGjtSlYuEn" redirectURL:kRedirectURI];
    
    [self.window makeKeyAndVisible];
    return YES;
}
-(void)initRongClould{

    
    [[RCDataManager shareManager] getUserInfoWithMiYouMei];
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
    NSInteger ToatalunreadMsgCount = (NSInteger)[[RCIMClient sharedRCIMClient] getUnreadCount:@[@(ConversationType_PRIVATE),@(ConversationType_DISCUSSION),@(ConversationType_GROUP),@(ConversationType_CHATROOM)]];
    [UIApplication sharedApplication].applicationIconBadgeNumber = ToatalunreadMsgCount;

}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    NSLog(@"走了applicationWillEnterForeground方法");
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
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
