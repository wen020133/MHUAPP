//
//  WJCartGoodsModel.h
//  MHUAPP
//
//  Created by jinri on 2018/1/25.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WJCartGoodsModel : NSObject

@property (nonatomic,assign) BOOL select;

@property (assign,nonatomic) NSInteger goods_number;
@property (copy,nonatomic) NSString *goods_id;
@property (copy,nonatomic) NSString *goods_name;
@property (copy,nonatomic) NSString *goods_price; //活动价
@property (copy,nonatomic) NSString *count_price; //单价
@property (copy,nonatomic) NSString *market_price;  //原价
@property (copy,nonatomic) NSString *rec_id;  //在购物车的ID
@property (copy,nonatomic) NSString *youhui;  //在购物车的ID
@property (copy,nonatomic) NSString *img;
@property (copy,nonatomic) NSString *order_id; 
@property (copy,nonatomic) NSString *goods_attr;

@property (copy,nonatomic) NSString *is_group_buy;   //当为2时是积分商城订单
@end
