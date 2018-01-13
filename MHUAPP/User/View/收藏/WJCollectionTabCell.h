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
@property (nonatomic, strong) UILabel *lab_price;
@property (nonatomic, strong) UIButton *btn_use;

@property (strong , nonatomic) WJCollectionItem *listModel;

/** 筛选点击回调 */
@property (nonatomic, copy) dispatch_block_t moreShareCanceBlock;
@end
