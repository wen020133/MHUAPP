//
//  WJSearchViewController.h
//  MHUAPP
//
//  Created by jinri on 2017/11/30.
//  Copyright © 2017年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseNetworkViewController.h"

@interface WJSearchViewController : BaseNetworkViewController<UITableViewDataSource,UITableViewDelegate>
@property (retain, nonatomic) UITableView *tab_infoView;
@property (retain, nonatomic) NSMutableArray *arr_items;
@end
