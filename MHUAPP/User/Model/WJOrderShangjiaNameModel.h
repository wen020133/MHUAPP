//
//  WJOrderShangjiaNameModel.h
//  MHUAPP
//
//  Created by jinri on 2017/12/22.
//  Copyright © 2017年 wenchengjun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WJOrderShangjiaNameModel : NSObject
/** 商家logo */
@property (nonatomic, strong) NSString *str_url;
/** 商家名字 */
@property (nonatomic, strong) NSString *name;
/** 订单状态 */
@property (nonatomic, strong) NSString *sitate;
@end
