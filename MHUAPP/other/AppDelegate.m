//
//  AppDelegate.m
//  MHUAPP
//
//  Created by wenchengjun on 2017/11/27.
//  Copyright © 2017年 wenchengjun. All rights reserved.
//

#import "AppDelegate.h"

#import <UMSocialCore/UMSocialCore.h>



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
//    iMRZ4b+d0LD/DeL9ae7v9dzYrJ6cohx7SF4nk3KbFSgHOCG2OoxWLl3Yg93x3cguVdTS6q6hPGNDVA8SwD8R4g==
    
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options
{
    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
    BOOL result = [[UMSocialManager defaultManager]  handleOpenURL:url options:options];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    NSInteger ToatalunreadMsgCount = (NSInteger)[[RCIMClient sharedRCIMClient] getUnreadCount:@[@(ConversationType_PRIVATE),@(ConversationType_DISCUSSION),@(ConversationType_GROUP),@(ConversationType_CHATROOM)]];
    [UIApplication sharedApplication].applicationIconBadgeNumber = ToatalunreadMsgCount;

}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;

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
