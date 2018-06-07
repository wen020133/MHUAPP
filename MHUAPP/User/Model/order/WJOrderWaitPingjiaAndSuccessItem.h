//
//  WJOrderWaitPingjiaAndSuccessItem.h
//  MHUAPP
//
//  Created by jinri on 2018/6/7.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WJOrderWaitPingjiaAndSuccessItem : NSObject

@property (copy,nonatomic) NSString *goods_number;
@property (copy,nonatomic) NSString *goods_id;
@property (copy,nonatomic) NSString *goods_name;
@property (copy,nonatomic) NSString *shop_price; //现价
@property (copy,nonatomic) NSString *count_price; //现价
@property (copy,nonatomic) NSString *market_price;  //原价
@property (copy,nonatomic) NSString *rec_id;  //在购物车的ID
@property (copy,nonatomic) NSString *supplier_name;
@property (copy,nonatomic) NSString *supplier_id;
@property (copy,nonatomic) NSString *img;
@property (copy,nonatomic) NSString *goods_attr;
@property (copy,nonatomic) NSString *order_id;

@end
