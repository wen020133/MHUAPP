//
//  WJXSZKTypeListCell.h
//  MHUAPP
//
//  Created by jinri on 2018/9/30.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WJXSZKListItem.h"


@interface WJXSZKTypeListCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *lab_title;
@property (nonatomic, strong) UIImageView *img_content;
@property (nonatomic, strong) UIView *grayView;
@property (nonatomic, strong) UILabel *lab_count;
@property (nonatomic, strong) UILabel *lab_zhekou;
@property (nonatomic, strong) UILabel *oldPriceLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UIImageView *img_date;
@property (nonatomic, strong) UILabel *lab_date;


@property (nonatomic, strong) WJXSZKListItem *model;

@end
