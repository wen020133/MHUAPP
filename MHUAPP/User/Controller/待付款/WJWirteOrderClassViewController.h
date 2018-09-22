//
//  WJWirteOrderClassViewController.h
//  MHUAPP
//
//  Created by jinri on 2018/4/27.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseNetworkViewController.h"
#import "WJCartGoodsModel.h"


@interface WJWirteOrderClassViewController : BaseNetworkViewController<UITableViewDelegate,UITableViewDataSource>

@property (strong,nonatomic) NSArray<WJCartGoodsModel *> *dataArray;
@property (strong,nonatomic) NSString *str_telephone;
@property (strong,nonatomic) NSString *str_address;
@property (strong,nonatomic) NSString *str_Name;
@property (strong,nonatomic) NSString *str_site_id;
@property (strong,nonatomic) NSString *is_cart;
@property (strong,nonatomic) NSString *rec_type;
@property (strong,nonatomic)UILabel *totlePriceLabel;
@property (strong,nonatomic)UILabel *youhuiPriceLabel;
@property double totlePrice;
@property double integralPrice;
@property double hongbaoPrice;
@property (strong,nonatomic) NSString *bonus_id;
/* 红包判断 */
@property (strong, nonatomic) NSString *is_use_bonus;

@property (assign,nonatomic) NSString *goods_id;
@property (assign,nonatomic) NSString *goods_attr_id;
@property (assign,nonatomic) NSString *goods_number;
@end
