//
//  WJHomeTOPCollectionViewCell.h
//  MHUAPP
//
//  Created by wenchengjun on 2017/11/28.
//  Copyright © 2017年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WJGoodsDataModel.h"

@interface WJHomeTOPCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UIImageView *img_content;
@property (nonatomic, strong) UIView *grayView;
@property (nonatomic, strong) UILabel *lab_price;
@property (nonatomic, strong) UILabel *lab_count;
@property (nonatomic, strong) UIButton *btn_gou;
@property (nonatomic, strong) WJGoodsDataModel *model;
@end
