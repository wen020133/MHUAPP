//
//  WJDetailGoodReferralCell.h
//  MHUAPP
//
//  Created by jinri on 2017/12/4.
//  Copyright © 2017年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WJDetailGoodReferralCell : UICollectionViewCell

/* 商品标题 */
@property (strong , nonatomic)UILabel *goodTitleLabel;
/* 商品价格 */
@property (strong , nonatomic)UILabel *goodPriceLabel;
/* 商品小标题 */
@property (strong , nonatomic)UILabel *goodSubtitleLabel;

/* 优惠按钮 */
@property (strong , nonatomic)UIButton *preferentialButton;

@end
