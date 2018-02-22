//
//  WJUserCollectionViewController.h
//  MHUAPP
//
//  Created by jinri on 2017/12/29.
//  Copyright © 2017年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseNetworkViewController.h"
#import "zhPopupController.h"
#import "zhWallView.h"

typedef NS_ENUM(NSInteger, KGetCollectionServerType) {
    KGetCollectionServerSumList = 1 ,//获取总条数
    KGetCollectionTypePortList = 2 ,//分页数据
};

@interface WJUserCollectionViewController : BaseNetworkViewController<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic)  UITableView *tab_collectionView;
@property (nonatomic,strong)  NSMutableArray *dataArr;
@property NSInteger totleCount;
@property NSInteger page;

@property (assign, nonatomic) KGetCollectionServerType serverType;



@property (nonatomic, strong) zhPopupController *zh_popupController;
- (zhWallView *)wallView;

- (NSArray *)wallModels;
@end
