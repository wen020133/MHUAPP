//
//  WJOrderGoodListModel.h
//  MHUAPP
//
//  Created by jinri on 2018/5/3.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WJOrderGoodListModel : NSObject

@property (assign,nonatomic) NSInteger goods_number;
@property (copy,nonatomic) NSString *goods_id;
@property (copy,nonatomic) NSString *goods_name;
@property (copy,nonatomic) NSString *shop_price; //现价
@property (copy,nonatomic) NSString *count_price; //现价
@property (copy,nonatomic) NSString *market_price;  //原价
@property (copy,nonatomic) NSString *rec_id;  //在购物车的ID
@property (copy,nonatomic) NSString *youhui;  //在购物车的ID
@property (copy,nonatomic) NSString *img;
@property (copy,nonatomic) NSString *goods_attr;
@property (copy,nonatomic) NSString *order_id;
@property (copy,nonatomic) NSString *is_group_buy;   //当为2时是积分商城订单


@property (copy,nonatomic) NSString *back_goods_price;   //退款价格
@property (copy,nonatomic) NSString *back_goods_number;   //退款数量
@property (copy,nonatomic) NSString *back_id;   //退款ID
@property (copy,nonatomic) NSString *status_back;   //退款状态
@property (copy,nonatomic) NSString *status_refund;   //退款态度
@property (copy,nonatomic) NSString *back_type;
@end
