//
//  WJSecondsKissCell.h
//  MHUAPP
//
//  Created by jinri on 2018/1/5.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "WJSecondsKillItem.h"

@interface WJSecondsKissCell : UITableViewCell
//
///* 推荐数据 */
//@property (strong , nonatomic) WJSecondsKillItem *goodsItem;

/* 商品图片 */
@property (strong , nonatomic)UIImageView *gridImageView;
/* 商品标题 */
@property (strong , nonatomic)UILabel *gridLabel;
/* 商品标题 */
@property (strong , nonatomic)UILabel *goods_briefLabel;
/* 价格 */
@property (strong , nonatomic)UILabel *priceLabel;
/* 原价 */
@property (strong , nonatomic)UILabel *oldPriceLabel;
/* 已售数量 */
@property (strong , nonatomic)UILabel *lab_count;
/* 按钮事件 */
@property (strong , nonatomic) UIButton *btn_action;

@end
