//
//  WJXianShiMiaoShaModel.h
//  MHUAPP
//
//  Created by jinri on 2018/2/28.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WJXianShiMiaoShaModel : NSObject

/** 图片  */
@property (nonatomic, copy ,readonly) NSString *image_url;
/** 标题  */
@property (nonatomic, copy ,readonly) NSString *main_title;
/** 价格  */
@property (nonatomic, copy ,readonly) NSString *price;
/** 原价  */
@property (nonatomic, copy ,readonly) NSString *old_price;
/** 销量  */
@property (nonatomic, copy ,readonly) NSString *sales;
/** ID  */
@property (nonatomic, copy ,readonly) NSString *stock;

@end
