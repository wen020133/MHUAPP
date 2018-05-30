//
//  WJWAaitForGoodThridTableCell.h
//  MHUAPP
//
//  Created by jinri on 2018/5/30.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WJWAaitForGoodThridTableCell : UITableViewCell
@property (strong, nonatomic)  UILabel *lab_orderNo;
@property (strong, nonatomic)  UILabel *lab_shipping_time;
@property (strong, nonatomic)  UILabel *lab_add_time;
@property (strong, nonatomic)  UILabel *lab_pay_name;
@property (nonatomic, strong)  UILabel *totalPayPrice;
@property (strong, nonatomic)  NSString *str_orderNo;
@end
