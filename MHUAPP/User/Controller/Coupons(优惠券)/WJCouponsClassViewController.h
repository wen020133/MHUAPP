//
//  WJCouponsClassViewController.h
//  MHUAPP
//
//  Created by jinri on 2017/12/26.
//  Copyright © 2017年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WJCouponsMunuScrollView.h"

@interface WJCouponsClassViewController : UIViewController<CouponDelegate,UIPageViewControllerDataSource,UIPageViewControllerDelegate>


@property (strong, nonatomic) WJCouponsMunuScrollView *menuScrollView; //分类ScrollView
@property (strong, nonatomic) UIPageViewController *pageCouponsViewCtrl;
@property (strong, nonatomic) NSMutableArray *viewControllers;
@end
