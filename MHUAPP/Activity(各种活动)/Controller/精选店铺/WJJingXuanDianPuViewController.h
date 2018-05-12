//
//  WJJingXuanDianPuViewController.h
//  MHUAPP
//
//  Created by jinri on 2018/4/8.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseNetworkViewController.h"
#import "MenuScrollView.h"

typedef NS_ENUM(NSInteger, KGetStreetType) {
    KGetServerType = 1 ,//获取分类
    KGetStreet = 2 ,//获取店铺列表
};


@interface WJJingXuanDianPuViewController : BaseNetworkViewController<UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource,MenuBtnDelegate>

@property (strong, nonatomic) NSMutableArray *arr_infomationresults;
@property NSInteger page_Information;
@property NSInteger totleCount_Information;
@property (strong, nonatomic)  UICollectionView *collectionV;
@property (assign, nonatomic) KGetStreetType serverType;

@property (strong, nonatomic) MenuScrollView *menu_ScrollView; //分类ScrollView
@property (strong, nonatomic) NSMutableArray *arr_Type;
@property (strong, nonatomic) NSMutableArray *arr_TypeID;
@end
