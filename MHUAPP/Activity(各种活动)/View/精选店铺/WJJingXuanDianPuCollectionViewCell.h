//
//  WJJingXuanDianPuCollectionViewCell.h
//  MHUAPP
//
//  Created by jinri on 2018/4/9.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SLCommentsModel.h"

@interface WJJingXuanDianPuCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) SLCommentsModel *model;

@property (nonatomic, strong) UIImageView *headerIconImgView;
@property (nonatomic, strong) UILabel     *nameLbl;
@property (nonatomic, strong) UILabel     *lab_address;
@property (nonatomic, strong) UILabel      *lab_BBmiansu;
@property (nonatomic, strong) UILabel     *lab_MJfuwu;
@property (nonatomic, strong) UILabel     *lab_WLfwu;
//@property (nonatomic, strong) UILabel     *lab_goodNum;
@property (nonatomic, strong) UIView      *imgContentView;

@property (nonatomic, strong) UIButton     *btn_kefu;
@property (nonatomic, strong) UIButton     *btn_shop;

/** 点击联系客服 */
@property (nonatomic, copy) dispatch_block_t goToContactServiceBlock;

/** 点击联系客服 */
@property (nonatomic, copy) dispatch_block_t goToShopInfoBlock;
@end
