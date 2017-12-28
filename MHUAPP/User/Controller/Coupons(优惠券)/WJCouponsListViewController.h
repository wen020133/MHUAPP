//
//  WJCouponsListViewController.h
//  MHUAPP
//
//  Created by jinri on 2017/12/27.
//  Copyright © 2017年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseNetworkViewController.h"
#import "NOMoreDataView.h"
#import "WJCouponsItem.h"

typedef NS_ENUM(NSInteger, KGetCouponsServerType) {
    KGetCouponsServerSumList = 1 ,//获取总条数
    KGetCouponsTypePortList = 2 ,//分页数据
};

@interface WJCouponsListViewController : BaseNetworkViewController<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic)  UITableView *mainTableView;
@property (nonatomic,strong) NSString *str_imgTypeId;
@property (nonatomic,strong)  NSMutableArray *dataArr;
@property NSInteger totleCount;

@property (assign, nonatomic) KGetCouponsServerType serverType;

@property NSInteger page;

@end
