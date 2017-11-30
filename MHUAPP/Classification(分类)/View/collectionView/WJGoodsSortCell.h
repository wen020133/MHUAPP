//
//  WJGoodsSortCell.h
//  MHUAPP
//
//  Created by jinri on 2017/11/30.
//  Copyright © 2017年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WJClassMainGoodTypeModel.h"

@interface WJGoodsSortCell : UICollectionViewCell

/* 品牌数据 */
@property (strong , nonatomic)WJClassMainGoodTypeModel *model;

/* imageView */
@property (strong , nonatomic)UIImageView *goodsImageView;
/* label */
@property (strong , nonatomic)UILabel *goodsTitleLabel;

@end
