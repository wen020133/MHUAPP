//
//  WJSSPTMRHHCollectionCell.h
//  MHUAPP
//
//  Created by jinri on 2018/3/28.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WJJRPTItem.h"

@interface WJSSPTMRHHCollectionCell : UICollectionViewCell
@property (nonatomic, strong) UILabel *lab_title;
//@property (nonatomic, strong) UILabel *lab_describe;
@property (nonatomic, strong) UIImageView *img_content;
@property (nonatomic, strong) UIView *grayView;
@property (nonatomic, strong) UIButton *btn_price;
@property (nonatomic, strong) UILabel *lab_count;
@property (nonatomic, strong) UILabel *lab_minNum;
@property (nonatomic, strong) UILabel *oldPriceLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) WJJRPTItem *model;

@end
