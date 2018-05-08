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
@property (copy,nonatomic) NSString *count_price; //现价
@property (copy,nonatomic) NSString *market_price;  //原价
@property (copy,nonatomic) NSString *rec_id;  //在购物车的ID
@property (copy,nonatomic) NSString *youhui;  //在购物车的ID
@property (copy,nonatomic) NSString *img;
@property (copy,nonatomic) NSString *goods_attr;

@end