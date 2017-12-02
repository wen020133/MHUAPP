//
//  WJListGoodsCell.h
//  MHUAPP
//
//  Created by jinri on 2017/12/1.
//  Copyright © 2017年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WJGoodsListItem.h"

@interface WJListGoodsCell : UICollectionViewCell

/* 推荐数据 */
@property (strong , nonatomic) WJGoodsListItem *goodsItem;

/* 优惠套装 */
@property (strong , nonatomic)UIImageView *freeSuitImageView;
/* 商品图片 */
@property (strong , nonatomic)UIImageView *gridImageView;
/* 商品标题 */
@property (strong , nonatomic)UILabel *gridLabel;
/* 自营 */
@property (strong , nonatomic)UIImageView *autotrophyImageView;
/* 价格 */
@property (strong , nonatomic)UILabel *priceLabel;
/* 评价数量 */
@property (strong , nonatomic)UILabel *commentNumLabel;

@end
