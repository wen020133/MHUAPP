//
//  WJStoreInfoCollectionCell.h
//  MHUAPP
//
//  Created by jinri on 2018/5/14.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WJGoodsDataModel.h"

@interface WJStoreInfoCollectionCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UIImageView *img_content;
@property (nonatomic, strong) UIView *grayView;
@property (nonatomic, strong) UILabel *lab_price;

@property (nonatomic, strong) WJGoodsDataModel *item;
@end
