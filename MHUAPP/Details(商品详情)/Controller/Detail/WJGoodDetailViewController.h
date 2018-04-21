//
//  WJGoodDetailViewController.h
//  MHUAPP
//
//  Created by jinri on 2017/12/4.
//  Copyright © 2017年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseNetworkViewController.h"

typedef NS_ENUM(NSInteger, KGetShopInfoClassType) {
    KGetshopInfoClass = 1 ,//获取商品详情
    KGetComment = 2 ,//评论数据
};

@interface WJGoodDetailViewController : BaseNetworkViewController<UIScrollViewDelegate>

/* 商品标题 */
@property (strong , nonatomic)NSString *goodTitle;
/* 商品价格 */
@property (strong , nonatomic)NSString *goodPrice;
/* 原价格 */
@property (strong , nonatomic)NSString *oldPrice;
/* 商品小标题 */
@property (strong , nonatomic)NSString *goodSubtitle;
/* 商品图片 */
@property (strong , nonatomic)NSString *goodImageView;

/* 商品轮播图 */
@property (strong , nonatomic)NSArray *shufflingArray;
/* 商品属性 */
@property (strong , nonatomic)NSArray *attributeArray;

/* 商品ID */
@property (strong , nonatomic) NSString *goods_id;
/* 店铺ID */
@property (strong , nonatomic) NSString *supplier_id;
@property (assign, nonatomic) KGetShopInfoClassType serverType;
@end
