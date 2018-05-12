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
/** ID  */
@property (nonatomic, copy ,readonly) NSString *integral_id;

@end
