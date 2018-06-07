//
//  WJGoodsCountDownCell.h
//  MHUAPP
//
//  Created by jinri on 2018/2/24.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WJGoodsCountDownCell : UICollectionViewCell

/* 推荐商品数据 */
@property (strong , nonatomic) NSArray  *countDownItem;
/* 推荐商品数据 */
- (void)setUpUI;
/** 去各活动 */

@property (nonatomic , copy) void(^goToGoodDetailClass)(NSDictionary *dic_goods);
@end
