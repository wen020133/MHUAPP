//
//  WJWriteListTableCell.h
//  MHUAPP
//
//  Created by jinri on 2018/4/29.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WJCartGoodsModel.h"

@interface WJWriteListTableCell : UITableViewCell

@property (nonatomic, strong) UIImageView *contentImg;

@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UILabel *type;
@property (nonatomic, strong) UILabel *price;
@property (nonatomic, strong) UILabel *oldprice;
@property (nonatomic, strong) UILabel *Num;

//Cell分割线
@property (nonatomic,strong)UIImageView *imageLine;

@property (strong , nonatomic) WJCartGoodsModel *listModel;

@end
