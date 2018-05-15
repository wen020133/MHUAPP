//
//  WJJIFenListCollectionViewCell.h
//  MHUAPP
//
//  Created by jinri on 2018/3/31.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WJJRPTItem.h"

@interface WJJIFenListCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *lab_title;
@property (nonatomic, strong) UIImageView *img_content;
@property (nonatomic, strong) UIView *grayView;
@property (nonatomic, strong) UIButton *btn_buy;
@property (nonatomic, strong) UILabel *lab_price;
@property (nonatomic, strong) WJJRPTItem *model;

@end
