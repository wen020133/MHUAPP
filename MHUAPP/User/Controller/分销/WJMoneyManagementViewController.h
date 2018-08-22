//
//  WJMoneyManagementViewController.h
//  MHUAPP
//
//  Created by wenchengjun on 2018/7/31.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseNetworkViewController.h"

@interface WJMoneyManagementViewController : BaseNetworkViewController
@property (weak, nonatomic) IBOutlet UIButton *btn_tiXian;
@property (weak, nonatomic) IBOutlet UILabel *lab_totalPrice;
@property (weak, nonatomic) IBOutlet UILabel *lab_canBeNumPrice;
@property (weak, nonatomic) IBOutlet UIView *view_tabHead;

@end
