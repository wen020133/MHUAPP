//
//  WJUserHeadAndOrderView.h
//  MHUAPP
//
//  Created by jinri on 2017/12/6.
//  Copyright © 2017年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WJUserHeadAndOrderView : UICollectionReusableView
/** 点击头像 */
@property (nonatomic, copy) dispatch_block_t touchClickBlock;

/** 点击查看全部订单 */
@property (nonatomic, copy) dispatch_block_t goToOrderClickBlock;


@property (strong , nonatomic) UIView *view_head;
/* 图片 */
@property (strong , nonatomic)UIImageView *headImageView;
/* 名字 */
@property (strong , nonatomic)UILabel *userNameLabel;

/* 个人中心 */
@property (strong , nonatomic)UILabel *titleLabel;

/* 查看全部 */
@property (strong , nonatomic) UIButton *btnSeeAll;

/* 箭头图片 */
@property (strong , nonatomic) UIImageView *actionImageView;

/* 设置 */
@property (strong , nonatomic) UIButton *settingButton;

/* line */
@property (strong , nonatomic) UIImageView *lineImageView;
@end
