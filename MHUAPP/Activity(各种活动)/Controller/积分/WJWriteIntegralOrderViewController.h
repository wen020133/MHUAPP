//
//  WJWriteIntegralOrderViewController.h
//  MHUAPP
//
//  Created by wenchengjun on 2018/5/18.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseNetworkViewController.h"
#import "WJJRPTItem.h"

@interface WJWriteIntegralOrderViewController : BaseNetworkViewController<UITableViewDelegate,UITableViewDataSource>

@property (strong,nonatomic) NSString *str_telephone;
@property (strong,nonatomic) NSString *str_address;
@property (strong,nonatomic) NSString *str_Name;

@property (strong,nonatomic)UILabel *totlePriceLabel;

@property (assign ,nonatomic) NSString *str_integral;

@property (strong , nonatomic) WJJRPTItem *listItem;

@property (assign ,nonatomic) NSString *str_goods_sn;
@end
