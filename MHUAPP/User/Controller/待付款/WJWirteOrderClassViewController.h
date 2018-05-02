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

@property (strong,nonatomic)UILabel *totlePriceLabel;
@end
