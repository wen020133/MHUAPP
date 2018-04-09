//
//  WJJingXuanDianPuViewController.h
//  MHUAPP
//
//  Created by jinri on 2018/4/8.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseNetworkViewController.h"
#import "WJJingXuanMenuView.h"

typedef NS_ENUM(NSInteger, KGetCirclenType) {
    KGetServerSum = 1 ,//获取总条数
    KGetDataList = 2 ,//分页数据
};
@interface WJJingXuanDianPuViewController : BaseNetworkViewController<UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource>

@property (strong, nonatomic) NSMutableArray *arr_infomationresults;
@property NSInteger page_Information;
@property NSInteger totleCount_Information;
@property (strong, nonatomic)  UICollectionView *collectionV;
@property (assign, nonatomic) KGetCirclenType serverType;

@property (strong, nonatomic) WJJingXuanMenuView *menu_ScrollView; //分类ScrollView
@property (strong, nonatomic) NSArray *arr_Type;
@end
