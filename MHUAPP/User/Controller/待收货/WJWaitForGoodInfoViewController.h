//
//  WJWaitForGoodInfoViewController.h
//  MHUAPP
//
//  Created by jinri on 2018/5/29.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseNetworkViewController.h"

@interface WJWaitForGoodInfoViewController : BaseNetworkViewController<UITableViewDelegate,UITableViewDataSource>

@property (assign,nonatomic) NSString *str_telephone;
@property (assign,nonatomic) NSString *str_address;
@property (assign,nonatomic) NSString *str_Name;
@property (assign,nonatomic) NSString *str_orderId;
@property (assign,nonatomic) NSString *shipping_name;
@property (assign,nonatomic) NSString *invoice_no;
@end
