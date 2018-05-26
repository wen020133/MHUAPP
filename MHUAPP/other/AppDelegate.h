//
//  AppDelegate.h
//  MHUAPP
//
//  Created by wenchengjun on 2017/11/27.
//  Copyright © 2017年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RongIMKit/RongIMKit.h>
#import "WJMainTabBarViewController.h"
#import "RCDataManager.h"
#import "WXApi.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate,WXApiDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, strong) WJMainTabBarViewController *tabbarVC;

@property(nonatomic,strong) NSMutableArray *friendsArray;
@property(nonatomic,strong) NSMutableArray *groupsArray;
@property(nonatomic,strong) NSString *user_id;

/// func
+ (AppDelegate* )shareAppDelegate;
@end

