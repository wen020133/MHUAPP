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
@property (nonatomic, strong) UILabel     *txtContentLbl;
@property (nonatomic, strong) UIView      *imgContentView;
@property (nonatomic, strong) UILabel     *lab_title;
@property (nonatomic, strong) UILabel     *lab_collectionNum;
@property (nonatomic, strong) UIButton    *zanBtn;
@property (nonatomic, strong) UIButton    *commentBtn;

//返回次cell的高度
-(CGFloat)cellHeight;

@end
