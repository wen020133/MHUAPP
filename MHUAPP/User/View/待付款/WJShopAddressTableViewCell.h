//
//  WJShopAddressTableViewCell.h
//  MHUAPP
//
//  Created by jinri on 2018/4/28.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WJShopAddressTableViewCell : UITableViewCell

@property (strong, nonatomic)  UILabel *lab_Name;
@property (strong, nonatomic)  UILabel *lab_telephone;
@property (strong, nonatomic)  UILabel *lab_address;
@property (strong, nonatomic)  UIImageView *actionImageView;

/* 地址 */
@property (assign , nonatomic)  NSString *str_address;
@end
