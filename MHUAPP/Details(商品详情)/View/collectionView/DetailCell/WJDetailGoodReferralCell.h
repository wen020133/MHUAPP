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
@property (strong , nonatomic)UILabel *market_priceLabel;

@property (strong , nonatomic)UILabel *lab_soldNum;
@property (strong , nonatomic)UILabel *lab_address;
/* 优惠按钮 */
@property (strong , nonatomic)UIButton *preferentialButton;

/* 商品标题 */
@property (assign , nonatomic)NSString *goodTitle;
/* 店铺价格 */
@property (assign , nonatomic)NSString *goodPrice;
/* 原价格 */
@property (assign , nonatomic)NSString *oldPrice;
/* 已售数量 */
@property (assign , nonatomic)NSString *soldNum;

- (void)assignmentAllLabel;

@end
