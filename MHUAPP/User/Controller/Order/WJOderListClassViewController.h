//
//  WJOderListClassViewController.h
//  MHUAPP
//
//  Created by jinri on 2017/12/19.
//  Copyright © 2017年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseNetworkViewController.h"

typedef NS_ENUM(NSInteger, KGetOrderServerType) {
    KGetOrderServerSumList = 1 ,//获取总条数
    KOrderTypePortList = 2 ,//分页数据
};
@interface WJOderListClassViewController : BaseNetworkViewController <UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic)  UITableView *mainTableView;
@property (nonatomic,strong) NSString *str_imgTypeId;
@property (nonatomic,strong)  NSMutableArray *dataArr;
@property NSInteger totleCount;

@property (assign, nonatomic) KGetOrderServerType serverType;

@property NSInteger page;

@end
