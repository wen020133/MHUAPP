//
//  WJOrderListCell.h
//  MHUAPP
//
//  Created by jinri on 2017/12/22.
//  Copyright © 2017年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WJOrderListItem.h"

@interface WJOrderListCell : UITableViewCell

@property (nonatomic, strong) UIImageView *contentImg;

@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UILabel *type;
@property (nonatomic, strong) UILabel *price;
@property (nonatomic, strong) UILabel *oldprice;
@property (nonatomic, strong) UILabel *Num;

@property (strong , nonatomic) WJOrderListItem *listModel;
@end
