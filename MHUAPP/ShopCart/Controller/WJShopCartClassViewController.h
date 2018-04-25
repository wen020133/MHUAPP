//
//  WJShopCartClassViewController.h
//  MHUAPP
//
//  Created by wenchengjun on 2017/11/28.
//  Copyright © 2017年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseNetworkViewController.h"
typedef NS_ENUM(NSInteger, KGetShopListClassType) {
    KGetShopCartListClass = 1 ,//获取购物车列表
    KGetGoodNumChange = 2 ,//改变数量
};

@interface WJShopCartClassViewController : BaseNetworkViewController<UITableViewDelegate,UITableViewDataSource>


@property (assign, nonatomic) BOOL isHasTabBarController;//是否含有tabbar
@property (assign, nonatomic) BOOL isHasNavitationController;//是否含有导航
@property (assign, nonatomic) BOOL selectedState;

@property (assign, nonatomic) KGetShopListClassType serverType;

@end
