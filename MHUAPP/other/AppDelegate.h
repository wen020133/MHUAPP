//
//  AppDelegate.h
//  MHUAPP
//
//  Created by wenchengjun on 2017/11/27.
//  Copyright © 2017年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WJMainTabBarViewController.h"
#import "WXApi.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate,WXApiDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, strong) WJMainTabBarViewController *tabbarVC;

@end

