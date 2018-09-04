//
//  WJGoodBaseViewController.h
//  MHUAPP
//
//  Created by jinri on 2017/12/4.
//  Copyright © 2017年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseNetworkViewController.h"
#import "WJDetailPartCommentItem.h"

@interface WJGoodBaseViewController : BaseNetworkViewController

/* 商品标题 */
@property (assign , nonatomic)NSString *goodTitle;
/* 店铺价格 */
@property (assign , nonatomic)NSString *goodPrice;
/* 原价格 */
@property (assign , nonatomic)NSString *oldPrice;
/* 商品小标题 */
@property (assign , nonatomic)NSString *goodSubtitle;
/* 商品图片 */
@property (assign , nonatomic)NSString *goodImageView;

/* 商品轮播图 */
@property (copy , nonatomic)NSArray *shufflingArray;
/* 商品属性 */
@property (copy , nonatomic)NSArray *attributeArray;
/* 商品评论 */
@property (copy , nonatomic)NSArray<WJDetailPartCommentItem *> *commentArray;

/* 商品ID */
@property (assign , nonatomic) NSString *goods_id;
/* 店铺ID */
@property (assign , nonatomic) NSString *supplier_id;

/* 销售数量 */
@property (strong , nonatomic) NSString *soldNum;
/* 商品库存 */
@property NSInteger goods_number;

/** 更改标题 */
@property (nonatomic , copy) void(^changeTitleBlock)(BOOL isChange);

/* 红包提示 */
@property (strong, nonatomic) NSString *bonus_tips;
@property (strong, nonatomic) NSString *is_use_bonus;
@end
