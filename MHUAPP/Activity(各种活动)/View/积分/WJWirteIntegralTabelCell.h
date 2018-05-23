//
//  WJWirteIntegralTabelCell.h
//  MHUAPP
//
//  Created by wenchengjun on 2018/5/18.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WJJRPTItem.h"

@interface WJWirteIntegralTabelCell : UITableViewCell

@property (nonatomic, strong) UIImageView *contentImg;

@property (nonatomic, strong) UILabel *lab_title;
@property (nonatomic, strong) UILabel *lab_type;
@property (nonatomic, strong) UILabel *lab_price;


@property (strong , nonatomic) WJJRPTItem *listModel;
@end
