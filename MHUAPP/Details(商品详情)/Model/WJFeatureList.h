//
//  WJFeatureList.h
//  MHUAPP
//
//  Created by jinri on 2018/1/9.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WJFeatureList : NSObject

/** 类型名 */
@property (nonatomic, copy) NSString *attr_value;
/** 额外价格 */
@property (nonatomic, copy) NSString *attr_price;
/** 属性库存 */
@property (nonatomic, copy) NSString *product_number;
/** 属性缩略图片 */
@property (nonatomic, copy) NSString *thumb_url;
/** 属性图片 */
@property (nonatomic, copy) NSString *img_url;
/** 属性ID */
@property (nonatomic, copy) NSString *goods_attr_id;
/** 是否点击 */
@property (nonatomic,assign)BOOL isSelect;

@end
