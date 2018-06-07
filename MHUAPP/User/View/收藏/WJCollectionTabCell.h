//
//  WJCollectionTabCell.h
//  MHUAPP
//
//  Created by jinri on 2017/12/29.
//  Copyright © 2017年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WJCollectionItem.h"

@interface WJCollectionTabCell : UITableViewCell

@property (nonatomic, strong) UIImageView *img_content;
@property (nonatomic, strong) UILabel *lab_title;
@property (nonatomic, strong) UILabel *lab_num;

@property (strong , nonatomic) WJCollectionItem *listModel;
@property (assign,nonatomic) BOOL selectIsHidden;

//选中按钮
@property (nonatomic,strong) UIButton *selectBtn;

/** 筛选点击回调 */
/** 去各活动 */
@property (nonatomic , copy) void(^moreShareCanceBlock)(BOOL select);
@end
