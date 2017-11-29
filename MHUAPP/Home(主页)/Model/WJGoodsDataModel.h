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
@property (nonatomic, copy ,readonly) NSString *image_url;
/** 标题  */
@property (nonatomic, copy ,readonly) NSString *main_title;
/** 价格  */
@property (nonatomic, copy ,readonly) NSString *price;
/** 销量  */
@property (nonatomic, copy ,readonly) NSString *sale_count;
/** ID  */
@property (nonatomic, copy ,readonly) NSString *goodID;

@end
