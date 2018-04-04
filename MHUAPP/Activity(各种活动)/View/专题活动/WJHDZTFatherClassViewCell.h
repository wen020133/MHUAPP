//
//  WJHDZTFatherClassViewCell.h
//  MHUAPP
//
//  Created by jinri on 2018/4/4.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuScrollView.h"

@interface WJHDZTFatherClassViewCell : UICollectionViewCell<MenuBtnDelegate,UIPageViewControllerDataSource,UIPageViewControllerDelegate>
{
    UIPageViewController *_pageViewCtrl;
    NSMutableArray *_viewControllers;
    NSInteger ph_currentIndex;

}
@property (strong, nonatomic) MenuScrollView *menu_ScrollView; //分类ScrollView

@property (strong, nonatomic) NSArray *arr_Type;

@end
