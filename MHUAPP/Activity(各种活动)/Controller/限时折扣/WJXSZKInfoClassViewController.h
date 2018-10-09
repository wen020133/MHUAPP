//
//  WJXSZKInfoClassViewController.h
//  MHUAPP
//
//  Created by jinri on 2018/10/8.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseNetworkViewController.h"


@interface WJXSZKInfoClassViewController : BaseNetworkViewController

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

/* 秒杀ID */
@property (assign , nonatomic) NSString *info_id;

/* 原价格 */
@property (assign , nonatomic)NSString *oldPrice;
/* 结束时间 */
@property (assign , nonatomic) NSString *endTimeStr;


@property (assign, nonatomic) NSString *info_classType;

/* 商品库存 */
@property  NSInteger goods_number;

/** 更改标题 */
@property (nonatomic , copy) void(^changeTitleBlock)(BOOL isChange);


@end
