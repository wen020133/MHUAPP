//
//  WJFlowAttributeCell.h
//  MHUAPP
//
//  Created by wenchengjun on 2017/12/5.
//  Copyright © 2017年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WJFlowItem.h"

@interface WJFlowAttributeCell : UICollectionViewCell

/* 图片 */
@property (strong , nonatomic)UIImageView *flowImageView;
/* 名字 */
@property (strong , nonatomic)UILabel *flowTextLabel;
/* 数据 */
@property (strong , nonatomic) WJFlowItem *flowItem;

@end
