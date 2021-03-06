//
//  WJJRPTItem.h
//  MHUAPP
//
//  Created by jinri on 2018/3/28.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WJJRPTItem : NSObject

/** 图片  */
@property (nonatomic, copy ,readonly) NSString *goods_thumb;
/** 标题  */
@property (nonatomic, copy ,readonly) NSString *goods_name;
/** 副标题  */
@property (nonatomic, copy ,readonly) NSString *goods_brief;
/** 价格  */
@property (nonatomic, copy ,readonly) NSString *integral;
/** 原价  */
@property (nonatomic, copy ,readonly) NSString *market_price;
/** 原价  */
@property (nonatomic, copy ,readonly) NSString *shop_price;
/** 销量  */
@property (nonatomic, copy ,readonly) NSString *sales;
/** 积分ID  */
@property (nonatomic, copy ,readonly) NSString *integral_id;
/** goods_id  */
@property (nonatomic, copy ,readonly) NSString *goods_id;
/** shop_num  */
@property (nonatomic, copy ,readonly) NSString *shop_num;
/** 图片  */
@property (nonatomic, copy ,readonly) NSString *original_img;
/** 起批价  */
@property (nonatomic, copy ,readonly) NSString *start_price;
/** 已售数量  */
@property (nonatomic, copy ,readonly) NSString *num;
/** 起批量  */
@property (nonatomic, copy ,readonly) NSString *start_num;

@property (nonatomic, copy ,readonly) NSString *offer_numb_one;
@property (nonatomic, copy ,readonly) NSString *offer_numb_two;
@property (nonatomic, copy ,readonly) NSString *offer_numb_three;
@property (nonatomic, copy ,readonly) NSString *offer_price_one;
@property (nonatomic, copy ,readonly) NSString *offer_price_two;
@property (nonatomic, copy ,readonly) NSString *offer_price_three;


/* 红包提示 */
@property (strong, nonatomic) NSString *bonus_tips;
@property (strong, nonatomic) NSString *is_use_bonus;
@end
