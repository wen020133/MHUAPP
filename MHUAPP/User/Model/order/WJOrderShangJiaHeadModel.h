//
//  WJOrderShangJiaHeadModel.h
//  MHUAPP
//
//  Created by jinri on 2018/5/3.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WJOrderShangJiaHeadModel : NSObject

@property (copy,nonatomic) NSString *supplier_id;
@property (copy,nonatomic) NSString *supplier_name;
@property (copy,nonatomic) NSString *address;
@property (copy,nonatomic) NSString *consignee;
@property (copy,nonatomic) NSString *mobile;
@property (copy,nonatomic) NSString *referer;
@property (copy,nonatomic) NSString *pay_status;
@property (copy,nonatomic) NSString *shipping_status;
@property (copy,nonatomic) NSString *order_sn;//订单号
@property (copy,nonatomic) NSString *order_id;//订单ID
@property (copy,nonatomic) NSString *invoice_no;//物流单ID
@property (copy,nonatomic) NSString *shipping_name;//物流公司
@property (copy,nonatomic) NSString *goods_amount;//订单总价
@property (copy,nonatomic) NSString *is_group_buy;   //当为2时是积分商城订单

@property (strong,nonatomic,readonly)NSMutableArray *goodsArray;

- (void)configGoodsArrayWithArray:(NSArray*)array;


@end
