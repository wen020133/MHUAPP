//
//  WJSearchViewController.h
//  MHUAPP
//
//  Created by jinri on 2017/11/30.
//  Copyright © 2017年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseNetworkViewController.h"
#import "MuluScrollView.h"
#import "NOMoreDataView.h"

@interface WJSearchViewController : BaseNetworkViewController<UITableViewDataSource,UITableViewDelegate,MuluBtnDelegate>
@property (retain, nonatomic) UITableView *tab_infoView;
@property (retain, nonatomic) NSMutableArray *arr_items;

@property (strong, nonatomic) MuluScrollView *menuScrollView; //分类ScrollView
@property (retain, nonatomic) NOMoreDataView *noMoreView;
@end
