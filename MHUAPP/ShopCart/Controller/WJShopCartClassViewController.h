//
//  WJShopCartClassViewController.h
//  MHUAPP
//
//  Created by wenchengjun on 2017/11/28.
//  Copyright © 2017年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NOMoreDataView.h"
#import "BaseNetworkViewController.h"


@interface WJShopCartClassViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

/** 判断当前界面是否存在tabBar */
@property (nonatomic,assign)BOOL isTabBar;


@property (retain, nonatomic) NOMoreDataView *noMoreView;
@property(nonatomic,retain)UILabel *lab_total;
@property(nonatomic,retain)UILabel *lab_selectAll;
@property(nonatomic,retain)UIButton *btn_settlement;
@property(nonatomic,retain)UIButton *btn_delete;
@property(nonatomic,retain)UIButton *btn_selectAll;
@property(nonatomic,retain)UIView *settlementV;
@property BOOL selectedState;  //是否编辑
@property BOOL IshighBack;    //是否全部选中
@property (retain, nonatomic) NSMutableArray *arr_state;
@property NSInteger regType; //请求类型
@property (retain, nonatomic) NSString *strprice;
-(void)investListRequest;

@property (nonatomic, retain) NSMutableArray              *records;
@property (strong, nonatomic) UITableView *infoTableView;
// current page
@property (assign, nonatomic) NSInteger         currPage;


@end
