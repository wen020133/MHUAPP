//
//  WJFeatureChoseTopCell.h
//  MHUAPP
//
//  Created by jinri on 2018/1/10.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WJFeatureChoseTopCell : UITableViewCell

/** 取消点击回调 */
@property (nonatomic, copy) dispatch_block_t crossButtonClickBlock;

/* 商品价格 */
@property (strong , nonatomic)UILabel *goodPriceLabel;
/* 图片 */
@property (strong , nonatomic)UIImageView *goodImageView;
/* 选择属性 */
@property (strong , nonatomic)UILabel *chooseAttLabel;

/* 取消 */
@property (strong , nonatomic)UIButton *crossButton;

@end
