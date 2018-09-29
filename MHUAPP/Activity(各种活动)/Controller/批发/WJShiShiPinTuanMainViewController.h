//
//  WJShiShiPingTuanMainViewController.h
//  MHUAPP
//
//  Created by jinri on 2018/3/27.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuScrollView.h"
#import "BaseNetworkViewController.h"

@interface WJShiShiPinTuanMainViewController : BaseNetworkViewController<MenuBtnDelegate,UIPageViewControllerDataSource,UIPageViewControllerDelegate>
{
    UIPageViewController *_pageViewCtrl;
    NSMutableArray *_viewControllers;
}

@property (strong, nonatomic) MenuScrollView *menu_PTScrollView; //拼团分类ScrollView


@end
