//
//  WJWaitCommitInfoViewController.h
//  MHUAPP
//
//  Created by jinri on 2018/6/8.
//  assignright © 2018年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseNetworkViewController.h"

@interface WJWaitCommitInfoViewController : BaseNetworkViewController
@property (assign,nonatomic) NSString *goods_number;
@property (assign,nonatomic) NSString *goods_id;
@property (assign,nonatomic) NSString *goods_name;
@property (assign,nonatomic) NSString *shop_price; //现价
@property (assign,nonatomic) NSString *count_price; //现价
@property (assign,nonatomic) NSString *market_price;  //原价
@property (assign,nonatomic) NSString *rec_id;  //在购物车的ID
@property (assign,nonatomic) NSString *supplier_name;
@property (assign,nonatomic) NSString *supplier_id;
@property (assign,nonatomic) NSString *img;
@property (assign,nonatomic) NSString *goods_attr;
@property (assign,nonatomic) NSString *order_id;

@end
