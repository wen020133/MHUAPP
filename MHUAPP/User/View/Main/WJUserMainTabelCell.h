//
//  WJUserMainTabelCell.h
//  MHUAPP
//
//  Created by jinri on 2017/12/6.
//  Copyright © 2017年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WJFlowItem.h"

@interface WJUserMainTabelCell : UICollectionViewCell

/* 图片 */
@property (strong , nonatomic)UIImageView *flowImageView;
/* 名字 */
@property (strong , nonatomic)UILabel *flowTextLabel;
/* count */
@property (strong , nonatomic) UILabel *countLabel;
/* 箭头图片 */
@property (strong , nonatomic) UIImageView *actionImageView;
/* 数据 */
@property (strong , nonatomic) WJFlowItem *flowItem;

@end
