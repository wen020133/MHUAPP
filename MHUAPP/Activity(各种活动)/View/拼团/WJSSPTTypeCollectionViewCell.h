//
//  WJSSPTTypeCollectionViewCell.h
//  MHUAPP
//
//  Created by jinri on 2018/3/29.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WJJRPTItem.h"

@interface WJSSPTTypeCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *lab_title;
@property (nonatomic, strong) UIView *grayView;
@property (nonatomic, strong) UIImageView *img_content;
@property (nonatomic, strong) UIButton *btn_price;
@property (nonatomic, strong) UILabel *lab_count;
@property (nonatomic, strong) UILabel *priceLabel;

@property (nonatomic, strong) UILabel *lab_market_price;
@property (nonatomic, strong) UILabel *lab_start_num;

@property (nonatomic, strong) WJJRPTItem *model;


@end
