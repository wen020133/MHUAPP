//
//  WJOrderListCell.h
//  MHUAPP
//
//  Created by jinri on 2017/12/22.
//  Copyright © 2017年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WJOrderGoodListModel.h"
#import "WJOrderWaitPingjiaAndSuccessItem.h"

@interface WJOrderListCell : UITableViewCell

@property (nonatomic, strong) UIImageView *contentImg;

@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UILabel *type;
@property (nonatomic, strong) UILabel *price;
@property (nonatomic, strong) UILabel *oldprice;
@property (nonatomic, strong) UILabel *Num;

//Cell分割线
@property (nonatomic,strong)UIImageView *imageLine;

@property (strong , nonatomic) WJOrderGoodListModel *listModel;

@property (strong , nonatomic) WJOrderWaitPingjiaAndSuccessItem *item;

@end
