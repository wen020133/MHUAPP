//
//  AddAddressViewController.h
//
//  Created by wenchengjun on 14-12-29.
//
// 收货地址列表

#import <UIKit/UIKit.h>
#import "NOMoreDataView.h"
#import "BaseNetworkViewController.h"


@interface AddAddressViewController : BaseNetworkViewController<UITableViewDelegate,UITableViewDataSource>
@property NSInteger regType;
@property (retain, nonatomic) NOMoreDataView *noMoreView; //没有数据的空白显示
@property BOOL selectedState;
@property BOOL selectCellIndexpathYES; // NO为User接入 。YES为确认订单接入
@property NSInteger deteleCellIndexpath;

@property (strong, nonatomic) UITableView *infoTableView;
@end
