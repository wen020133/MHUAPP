//
//  WJSetHeadTableCell.h
//  MHUAPP
//
//  Created by jinri on 2017/12/7.
//  Copyright © 2017年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WJFlowItem.h"


@interface WJSetHeadTableCell : UITableViewCell

/* 图片 */
@property (strong , nonatomic)UIImageView *flowImageView;

/* 列表名称 */
@property (strong , nonatomic) UILabel *nameLabel;
/* 箭头图片 */
@property (strong , nonatomic) UIImageView *actionImageView;
/* line */
@property (strong , nonatomic) UIImageView *lineImageView;

/* 数据 */
@property (strong , nonatomic) WJFlowItem *flowItem;


@end
