//
//  WJGoodsDataModel.h
//  MHUAPP
//
//  Created by jinri on 2017/11/29.
//  Copyright © 2017年 wenchengjun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WJGoodsDataModel : NSObject
/** 图片  */
@property (nonatomic, copy ,readonly) NSString *goods_thumb;
/** 标题  */
@property (nonatomic, copy ,readonly) NSString *goods_name;
/** 副标题  */
@property (nonatomic, copy ,readonly) NSString *goods_title;
/** 价格  */
@property (nonatomic, copy ,readonly) NSString *shop_price;
/** 销量  */
@property (nonatomic, copy ,readonly) NSString *shop_num;
/** ID  */
@property (nonatomic, copy ,readonly) NSString *goods_id;
/** 销量  */
@property (copy , nonatomic , readonly)NSArray *images;

@end
