//
//  WJIntegralInfoClassViewController.h
//  MHUAPP
//
//  Created by jinri on 2018/5/14.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseNetworkViewController.h"
#import "WJJRPTItem.h"


@interface WJIntegralInfoClassViewController : BaseNetworkViewController

@property (assign ,nonatomic) NSString *str_title;
@property (assign ,nonatomic) NSString *str_integral;
@property (assign ,nonatomic) NSString *str_supplierId;
@property (assign ,nonatomic) NSString *str_userIntegral;
@property (strong ,nonatomic) NSString *str_goods_sn;   //货号
@property (strong ,nonatomic) NSString *str_inventory;   //库存

@property (strong , nonatomic) WJJRPTItem *listModel;

@end
