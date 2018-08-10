//
//  WJKeFenXiaoListViewController.h
//  MHUAPP
//
//  Created by wenchengjun on 2018/7/27.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseNetworkViewController.h"
typedef NS_ENUM(NSInteger, KGetDepositCateType) {
    KGetServerType = 1 ,//获取分类类型
    KGetStreetList  = 2 ,//获取子分类商品列表
};


@interface WJKeFenXiaoListViewController : BaseNetworkViewController

@property (assign, nonatomic) KGetDepositCateType serverType;

@end
