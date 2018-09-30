//
//  WJXSZKListItem.h
//  MHUAPP
//
//  Created by jinri on 2018/9/30.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WJXSZKListItem : NSObject

/** 图片  */
@property (nonatomic, copy ,readonly) NSString *goods_thumb;
/** 标题  */
@property (nonatomic, copy ,readonly) NSString *goods_name;
/** 副标题  */
@property (nonatomic, copy ,readonly) NSString *goods_brief;
/** 价格  */
@property (nonatomic, copy ,readonly) NSString *integral;
/** 市场价  */
@property (nonatomic, copy ,readonly) NSString *market_price;
/** 原价  */
@property (nonatomic, copy ,readonly) NSString *org_price;
/** 销量  */
@property (nonatomic, copy ,readonly) NSString *sales;
/** 结束时间  */
@property (nonatomic, copy ,readonly) NSString *promote_end_date;
/** goods_id  */
@property (nonatomic, copy ,readonly) NSString *goods_id;
/** 开始时间  */
@property (nonatomic, copy ,readonly) NSString *promote_start_date;
/** 图片  */
@property (nonatomic, copy ,readonly) NSString *original_img;
/** 折扣价  */
@property (nonatomic, copy ,readonly) NSString *promote_price;
/** 已售数量  */
@property (nonatomic, copy ,readonly) NSString *num;
/** 折扣*/
@property (nonatomic, copy ,readonly) NSString *zhekou;



@end
