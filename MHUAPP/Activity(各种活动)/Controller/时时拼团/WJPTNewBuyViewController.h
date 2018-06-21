//
//  WJPTNewBuyViewController.h
//  MHUAPP
//
//  Created by jinri on 2018/5/31.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseNetworkViewController.h"

@interface WJPTNewBuyViewController : BaseNetworkViewController

@property (strong,nonatomic) NSString *str_telephone;
@property (strong,nonatomic) NSString *str_address;
@property (strong,nonatomic) NSString *str_Name;

@property (assign,nonatomic) NSString *str_contentImg;
@property (assign,nonatomic) NSString *str_title;
@property (strong,nonatomic) NSString *str_type;
@property (strong,nonatomic) NSString *str_price;
@property (assign,nonatomic) NSString *str_oldprice;
@property (assign,nonatomic) NSString *str_Num;
@property (assign,nonatomic) NSString *str_goodsId;
@property (assign,nonatomic) NSString *str_group_info_id; //拼团Id
@property (assign,nonatomic) NSString *str_info_id; //秒杀Id
@property (strong,nonatomic)UILabel *totlePriceLabel;

@property (assign, nonatomic) NSString *info_classType;
@end
