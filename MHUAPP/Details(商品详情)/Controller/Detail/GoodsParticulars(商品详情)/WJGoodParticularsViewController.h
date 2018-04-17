//
//  WJGoodParticularsViewController.h
//  MHUAPP
//
//  Created by jinri on 2017/12/4.
//  Copyright © 2017年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuScrollView.h"
#import "BaseNetworkViewController.h"

@interface WJGoodParticularsViewController : BaseNetworkViewController
{
    UIPageViewController *_pageViewCtrl;
    NSMutableArray *_viewControllers;
}

@property (strong, nonatomic) MenuScrollView *menu_goodInfoScrollView; //拼团分类ScrollView
@end
