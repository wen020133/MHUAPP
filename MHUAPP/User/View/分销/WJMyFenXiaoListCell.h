//
//  WJMyFenXiaoListCell.h
//  MHUAPP
//
//  Created by wenchengjun on 2018/7/30.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WJDetailListFenxiao.h"

@interface WJMyFenXiaoListCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *lab_title;
@property (nonatomic, strong) UIImageView *img_content;
@property (nonatomic, strong) UILabel *lab_count;
@property (nonatomic, strong) UILabel *lab_yongjin;
@property (nonatomic, strong) UILabel *lab_num;  //已分销销量
@property (nonatomic, strong) UILabel *lab_profitPrice;
/** 筛选点击回调 */
@property (nonatomic , copy) void(^filtraMyFenXiaoClickBlock)(NSInteger selectTag);
/** 分销详情 */
@property (nonatomic , copy) void(^myFenXiaoDetailClickBlock)(NSInteger selectTag);

@end
