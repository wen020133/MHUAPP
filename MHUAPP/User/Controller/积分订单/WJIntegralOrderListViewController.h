//
//  WJIntegralOrderListViewController.h
//  MHUAPP
//
//  Created by wenchengjun on 2018/5/19.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseNetworkViewController.h"

@interface WJIntegralOrderListViewController : BaseNetworkViewController <UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic)  UITableView *mainTableView;

@end
