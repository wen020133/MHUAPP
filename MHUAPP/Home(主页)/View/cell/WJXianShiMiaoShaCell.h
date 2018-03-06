//
//  WJXianShiMiaoShaCell.h
//  MHUAPP
//
//  Created by jinri on 2018/2/28.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WJXianShiMiaoShaModel.h"

@interface WJXianShiMiaoShaCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UIImageView *img_content;
@property (nonatomic, strong) UIView *grayView;
@property (nonatomic, strong) UILabel *lab_price;
@property (nonatomic, strong) UILabel *lab_count;

@property (nonatomic, strong) WJXianShiMiaoShaModel *model;

@end
