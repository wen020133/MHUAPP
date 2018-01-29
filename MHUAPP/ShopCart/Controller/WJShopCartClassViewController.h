//
//  WJShopCartClassViewController.h
//  MHUAPP
//
//  Created by wenchengjun on 2017/11/28.
//  Copyright © 2017年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseNetworkViewController.h"


@interface WJShopCartClassViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, retain) NSMutableArray              *records;
@property (strong, nonatomic) UITableView *infoTableView;
// current page
@property (assign, nonatomic) NSInteger         currPage;

@property (assign, nonatomic) BOOL isHasTabBarController;//是否含有tabbar
@property (assign, nonatomic) BOOL isHasNavitationController;//是否含有导航
@property (assign, nonatomic) BOOL selectedState;
@end
