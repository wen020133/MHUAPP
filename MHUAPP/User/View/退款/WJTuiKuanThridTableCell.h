//
//  WJTuiKuanThridTableCell.h
//  MHUAPP
//
//  Created by jinri on 2018/6/20.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WJTuiKuanThridTableCell : UITableViewCell

@property (strong, nonatomic)  UILabel *lab_orderNo;
@property (strong, nonatomic)  UILabel *lab_back_id;
@property (strong, nonatomic)  UILabel *lab_add_time;
@property (strong, nonatomic)  UILabel *lab_postscript;
@property (nonatomic, strong)  UILabel *lab_IsShouhuo;
@property (strong, nonatomic)  UILabel *lab_IsTuihuo;
@property (nonatomic, strong)  UILabel *lab_tuiKuanPrice;
@property (nonatomic, strong)  UILabel *totalPayPrice;
@property (nonatomic, strong)  NSString *str_orderNo;
@property (nonatomic, strong)  NSString *str_back_id;
/** 筛选点击回调 */
@property (nonatomic , copy) void(^ClickdetailStateForStrBlock)(NSString *stateStr);

@end
