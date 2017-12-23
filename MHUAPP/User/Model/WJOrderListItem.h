//
//  WJOrderListItem.h
//  MHUAPP
//
//  Created by jinri on 2017/12/22.
//  Copyright © 2017年 wenchengjun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WJOrderListItem : NSObject

/** 商品图片url */
@property (nonatomic, strong) NSString *str_url;
/** 商品名字 */
@property (nonatomic, strong) NSString *title;
/** 规格/参数 */
@property (nonatomic, strong) NSString *type;
/** 单品价格 */
@property (nonatomic, strong) NSString *price;
/** 单品数量 */
@property (nonatomic, strong) NSString *Num;
/** 单品原价 */
@property (nonatomic, strong) NSString *oldPrice;

@end
