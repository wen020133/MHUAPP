//
//  WJWaitPayOrderInfoViewController.h
//  MHUAPP
//
//  Created by jinri on 2018/5/3.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseNetworkViewController.h"

@interface WJWaitPayOrderInfoViewController : BaseNetworkViewController<UITableViewDelegate,UITableViewDataSource>

@property (assign,nonatomic) NSString *str_telephone;
@property (assign,nonatomic) NSString *str_address;
@property (assign,nonatomic) NSString *str_Name;
@property (assign,nonatomic) NSString *str_orderId;
@end
