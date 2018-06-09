//
//  WJWaitCommitItem.h
//  MHUAPP
//
//  Created by jinri on 2018/6/8.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WJWaitCommitItem : NSObject

@property (copy,nonatomic) NSString *mobile;
@property (copy,nonatomic) NSString *address;
@property (copy,nonatomic) NSString *consignee;
@property (copy,nonatomic) NSString *add_time;
@property (copy,nonatomic) NSString *pay_time;
@property (copy,nonatomic) NSString *shipping_time;
@property (copy,nonatomic) NSString *pay_name;
@property (copy,nonatomic) NSString *shipping_status;
@property (copy,nonatomic) NSString *order_sn;//订单号
@property (copy,nonatomic) NSString *order_id;//订单ID
@property (copy,nonatomic) NSString *invoice_no;//物流单ID
@property (copy,nonatomic) NSString *shipping_name;//物流公司
@property (copy,nonatomic) NSString *goods_amount;//订单总价
@end
