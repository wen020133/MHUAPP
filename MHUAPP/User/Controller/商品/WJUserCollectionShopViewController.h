//
//  WJUserCollectionShopViewController.h
//  MHUAPP
//
//  Created by jinri on 2018/1/3.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseNetworkViewController.h"
#import <UMSocialCore/UMSocialCore.h>
#import <UShareUI/UShareUI.h>

typedef NS_ENUM(NSInteger, KGetCollShopServerType) {
    KGetCollectionServerSumList = 1 ,//获取总条数
    KGetCollectionTypePortList = 2 ,//分页数据
};

@interface WJUserCollectionShopViewController : BaseNetworkViewController<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic)  UITableView *tab_collectionView;
@property (nonatomic,strong)  NSMutableArray *dataArr;
@property NSInteger totleCount;
@property NSInteger page;

@property (assign, nonatomic) KGetCollShopServerType serverType;

@end
