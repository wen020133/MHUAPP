//
//  WJKeFenxiaoListCell.h
//  MHUAPP
//
//  Created by wenchengjun on 2018/7/27.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WJKeFenxiaoListCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *lab_title;
@property (nonatomic, strong) UIImageView *img_content;
@property (nonatomic, strong) UILabel *lab_price;
@property (nonatomic, strong) UILabel *lab_count;
@property (nonatomic, strong) UILabel *lab_yongjin;

/** 筛选点击回调 */
@property (nonatomic , copy) void(^filtraFenXiaoClickBlock)(NSInteger selectTag);


@end
