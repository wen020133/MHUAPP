//
//  PayViewController.h
//  IOS_XW
//
//  Created by add on 15/10/22.
//  Copyright (c) 2015年 lan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseNetworkViewController.h"

UIKIT_EXTERN NSString * const UpLoadNoti;

@interface PayViewController : BaseNetworkViewController

@property (nonatomic, strong) NSString *orderNo;
@property (nonatomic, strong) NSString *oPrice;
@property (nonatomic, strong) NSString *str;
@property (nonatomic, assign) BOOL isDan;
@end
