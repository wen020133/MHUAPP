//
//  WJGoodsListItem.h
//  MHUAPP
//
//  Created by jinri on 2017/12/1.
//  Copyright © 2017年 wenchengjun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WJGoodsListItem : NSObject
/** 图片URL */
@property (nonatomic, copy ,readonly) NSString *goods_thumb;
/** 商品标题 */
@property (nonatomic, copy ,readonly) NSString *goods_name;
///** 商品小标题 */
//@property (nonatomic, copy ,readonly) NSString *goods_title;
/** 商品价格 */
@property (nonatomic, copy ,readonly) NSString *shop_price;
/** 剩余 */
@property (nonatomic, copy ,readonly) NSString *stock;
/** 货号 */
@property (nonatomic, copy ,readonly) NSString *goods_sn;
/* 商品ID */
@property (strong , nonatomic)NSString *goods_id;

/** 销售数量 */
@property (nonatomic, copy ,readonly) NSString *goods_number;
@end
