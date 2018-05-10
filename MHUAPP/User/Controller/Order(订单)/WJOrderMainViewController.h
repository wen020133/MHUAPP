//
//  WJOrderMainViewController.h
//  MHUAPP
//
//  Created by jinri on 2017/12/18.
//  Copyright © 2017年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuScrollView.h"

@interface WJOrderMainViewController : UIViewController<MenuBtnDelegate,UIPageViewControllerDataSource,UIPageViewControllerDelegate>
{
    UIPageViewController *_pageViewCtrl;
    NSMutableArray *_viewControllers;
}

@property (strong, nonatomic) MenuScrollView *menuScrollView; //分类ScrollView

@property (assign, nonatomic) NSInteger serverType;
@end
