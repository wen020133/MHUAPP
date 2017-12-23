//
//  WJOrderListFootModel.h
//  MHUAPP
//
//  Created by jinri on 2017/12/22.
//  Copyright © 2017年 wenchengjun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WJOrderListFootModel : NSObject

/** 总价 */
@property (nonatomic, strong) NSString *totalPrice;
/** 运费 */
@property (nonatomic, strong) NSString *freight;

/** 订单状态 */
@property (nonatomic, strong) NSString *OrderType;

/** 订单数量 */
@property (nonatomic, strong) NSString *OrderNum;

@end
