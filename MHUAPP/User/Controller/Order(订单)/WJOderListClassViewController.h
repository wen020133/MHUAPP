//
//  WJOderListClassViewController.h
//  MHUAPP
//
//  Created by jinri on 2017/12/19.
//  Copyright © 2017年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseNetworkViewController.h"

typedef NS_ENUM(NSInteger, KGetOrderServerType) {
    KGetOrderServerwholeOrder = 0 ,//获取全部订单
    KGetOrderListWaitPay = 1 ,//待付款
    KGetOrderListWaitFahuo = 2 ,//待发货
    KGetOrderListWaitShouhuo = 3 ,//待收货
    KGetOrderListTuiKuanTuihuo = 5 ,//退货退款中
    KGetOrderListWaitPingjia = 4 ,//待评价
    KGetOrderListJiaoyiSuccess = 6 ,//交易成功
//    KGetOrderListJiaoClose = 7 ,//交易关闭
};
@interface WJOderListClassViewController : BaseNetworkViewController <UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic)  UITableView *mainTableView;
@property (nonatomic,strong) NSString *str_imgTypeId;
@property NSInteger totleCount;

@property (assign, nonatomic) KGetOrderServerType serverType;

@property NSInteger page;

@end
