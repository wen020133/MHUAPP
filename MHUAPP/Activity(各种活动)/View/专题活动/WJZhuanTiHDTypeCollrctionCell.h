//
//  WJZhuanTiHDTypeCollrctionCell.h
//  MHUAPP
//
//  Created by jinri on 2018/3/30.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WJGoodsDataModel.h"

@interface WJZhuanTiHDTypeCollrctionCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UIImageView *img_content;
@property (nonatomic, strong) UIView *grayView;
@property (nonatomic, strong) UILabel *lab_price;
@property (nonatomic, strong) UILabel *lab_count;
@property (nonatomic, strong) UIButton *btn_buyNew;
@property (nonatomic, strong) UILabel *oldPriceLabel;

@property (nonatomic, strong) WJGoodsDataModel *model;

@end
