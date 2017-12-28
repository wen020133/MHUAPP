//
//  WJCouponsListCell.h
//  MHUAPP
//
//  Created by jinri on 2017/12/27.
//  Copyright © 2017年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WJCouponsItem.h"

@interface WJCouponsListCell : UITableViewCell

@property (nonatomic, strong) UIImageView *contentImg;
@property (nonatomic, strong) UILabel *lab_couponsPrice;
@property (nonatomic, strong) UILabel *lab_highPrice;
@property (nonatomic, strong) UILabel *lab_date;
@property (nonatomic, strong) UILabel *lab_type;
@property (nonatomic, strong) UIButton *btn_use;
@property (nonatomic, strong) UILabel *lab_state;

@property (strong , nonatomic) WJCouponsItem *listModel;

@end
