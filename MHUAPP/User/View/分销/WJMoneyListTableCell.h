//
//  WJMoneyListTableCell.h
//  MHUAPP
//
//  Created by wenchengjun on 2018/7/31.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WJMoneyListItem.h"

@interface WJMoneyListTableCell : UITableViewCell

@property (nonatomic, strong) UIImageView *img_content;
@property (nonatomic, strong) UILabel *lab_price;
@property (nonatomic, strong) UILabel *lab_date;
@property (nonatomic, strong) UILabel *lab_accountType;  
@property (nonatomic, strong) UILabel *lab_state;


@property (nonatomic, strong) WJMoneyListItem *model;

@end
