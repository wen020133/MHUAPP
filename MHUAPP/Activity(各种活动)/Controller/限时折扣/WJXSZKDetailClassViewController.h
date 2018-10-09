//
//  WJXSZKDetailClassViewController.h
//  MHUAPP
//
//  Created by jinri on 2018/10/8.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseNetworkViewController.h"
#import "WJDetailPartCommentItem.h"

typedef NS_ENUM(NSInteger, KGetSSPTDetailClassType) {
    KGetSSPTDetailClass = 1 ,//获取商品详情
    KGetSSPTDetailComment = 2 ,//评论数据
    KGetPTSupplierUserId = 3,
};



@interface WJXSZKDetailClassViewController : BaseNetworkViewController<UIScrollViewDelegate>

/* 商品标题 */
@property (strong , nonatomic)NSString *goodTitle;

/* 商品描述 */
@property (strong , nonatomic)NSString *goods_brief;
/* 店铺价格 */
@property (strong , nonatomic)NSString *goodPrice;
/* 原价格 */
@property (strong , nonatomic)NSString *oldPrice;
/* 商品图片 */
@property (strong , nonatomic)NSString *goodImageView;
/* 折扣ID */
@property (assign , nonatomic) NSString *group_info_id;
/* 秒杀ID */
@property (assign , nonatomic) NSString *info_id;
/* 商品轮播图 */
@property (strong , nonatomic)NSArray *shufflingArray;
/* 商品属性 */
@property (strong , nonatomic)NSArray *attributeArray;
/* 商品评论 */
@property (strong , nonatomic)NSArray<WJDetailPartCommentItem *> *commentArray;

/* 商品ID */
@property (assign , nonatomic) NSString *goods_id;

@property (assign, nonatomic) KGetSSPTDetailClassType serverType;

/* 店铺ID */
@property (strong , nonatomic) NSString *supplier_id;
/* 店铺userId */
@property (strong , nonatomic) NSString *supplierUserId;
/* 店铺头像 */
@property (strong , nonatomic) NSString *supplier_logo;
/* 店铺名 */
@property (strong , nonatomic) NSString *supplier_name;


/* 结束时间 */
@property (assign , nonatomic)NSString *endTimeStr;

@property (assign, nonatomic) NSString *info_classType;

@end
