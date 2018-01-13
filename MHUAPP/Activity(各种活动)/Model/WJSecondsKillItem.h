//
//  WJSecondsKillItem.h
//  MHUAPP
//
//  Created by jinri on 2018/1/5.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WJSecondsKillItem : NSObject
/** 图片URL */
@property (nonatomic, copy ,readonly) NSString *image_url;
/** 商品标题 */
@property (nonatomic, copy ,readonly) NSString *main_title;
/** 商品价格 */
@property (nonatomic, copy ,readonly) NSString *price;
/** 销售数量 */
@property (nonatomic, copy ,readonly) NSString *old_price;
@end
