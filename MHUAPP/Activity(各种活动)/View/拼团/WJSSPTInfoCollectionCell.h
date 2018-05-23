//
//  WJSSPTInfoCollectionCell.h
//  MHUAPP
//
//  Created by jinri on 2018/5/22.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WJSSPTInfoCollectionCell : UICollectionViewCell

/* 商品标题 */
@property (assign , nonatomic)NSString *goodTitle;
/* 店铺价格 */
@property (assign , nonatomic)NSString *goodPrice;
/* 原价格 */
@property (assign , nonatomic)NSString *oldPrice;
/* 结束时间 */
@property (assign , nonatomic)NSString *endTimeStr;

- (void)assignmentAllLabel;

@end
