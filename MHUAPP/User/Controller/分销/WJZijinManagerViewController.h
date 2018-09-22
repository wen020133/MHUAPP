//
//  WJZijinManagerViewController.h
//  MHUAPP
//
//  Created by wenchengjun on 2018/7/30.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseNetworkViewController.h"

@interface WJZijinManagerViewController : BaseNetworkViewController

@property (weak, nonatomic) IBOutlet UIView *tab_headNumView;
@property (weak, nonatomic) IBOutlet UILabel *lab_Num;
@property (weak, nonatomic) IBOutlet UILabel *lab_keTiXian;

@property (strong, nonatomic) NSString *str_distributionMoney;

@end
