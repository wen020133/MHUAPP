//
//  WJGoodsCountDownCell.h
//  MHUAPP
//
//  Created by jinri on 2018/2/24.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WJXianShiMiaoShaModel.h"


@interface WJGoodsCountDownCell : UICollectionViewCell

/* 推荐商品数据 */
@property (strong , nonatomic) NSMutableArray <WJXianShiMiaoShaModel *> *countDownItem;
/* 推荐商品数据 */
@property (strong , nonatomic) NSArray *arr_miaosha;
- (void)setUpUI;

@end
