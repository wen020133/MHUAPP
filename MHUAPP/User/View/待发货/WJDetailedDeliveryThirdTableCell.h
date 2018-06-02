//
//  WJDetailedDeliveryThirdTableCell.h
//  MHUAPP
//
//  Created by jinri on 2018/6/1.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WJDetailedDeliveryThirdTableCell : UITableViewCell

@property (strong, nonatomic)  UILabel *lab_orderNo;
@property (strong, nonatomic)  UILabel *lab_payTime;
@property (strong, nonatomic)  UILabel *lab_add_time;
@property (strong, nonatomic)  UILabel *lab_pay_name;
@property (nonatomic, strong)  UILabel *totalPayPrice;
@property (strong, nonatomic)  NSString *str_orderNo;

@end
