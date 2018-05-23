//
//  WJSSPTInfoClassViewController.h
//  MHUAPP
//
//  Created by jinri on 2018/5/21.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseNetworkViewController.h"

@interface WJSSPTInfoClassViewController : BaseNetworkViewController

/* 商品标题 */
@property (assign , nonatomic)NSString *goodTitle;
/* 店铺价格 */
@property (assign , nonatomic)NSString *goodPrice;

/* 商品图片 */
@property (assign , nonatomic)NSString *goodImageView;

/* 商品轮播图 */
@property (strong , nonatomic)NSArray *shufflingArray;
/* 商品属性 */
@property (strong , nonatomic)NSArray *attributeArray;
/* 商品评论 */
@property (strong , nonatomic)NSArray *commentArray;

/* 商品ID */
@property (assign , nonatomic) NSString *goods_id;
/* 原价格 */
@property (assign , nonatomic)NSString *oldPrice;
/* 结束时间 */
@property (assign , nonatomic) NSString *endTimeStr;

@property (assign , nonatomic)NSString *group_numb_one;
@property (assign , nonatomic)NSString *group_numb_two;
@property (assign , nonatomic)NSString *group_numb_three;
@property (assign , nonatomic)NSString *group_price_one;
@property (assign , nonatomic)NSString *group_price_two;
@property (assign , nonatomic)NSString *group_price_three;

@property (assign, nonatomic) NSString *info_classType;
@end
