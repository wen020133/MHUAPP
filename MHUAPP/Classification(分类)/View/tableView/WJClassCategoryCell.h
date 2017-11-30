//
//  WJClassCategoryCell.h
//  MHUAPP
//
//  Created by jinri on 2017/11/30.
//  Copyright © 2017年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WJClassGoodsItem.h"

@interface WJClassCategoryCell : UITableViewCell
/* 标题 */
@property (strong , nonatomic) UILabel *titleLabel;
/* 标题数据 */
@property (strong , nonatomic) WJClassGoodsItem *titleItem;

@end
