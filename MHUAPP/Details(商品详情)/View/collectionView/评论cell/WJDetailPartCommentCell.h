//
//  WJDetailPartCommentCell.h
//  MHUAPP
//
//  Created by jinri on 2017/12/5.
//  Copyright © 2017年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WJDetailPartCommentItem.h"

@interface WJDetailPartCommentCell : UICollectionViewCell

@property (nonatomic, strong) WJDetailPartCommentItem *model;

@property (nonatomic, strong) UIImageView *headerIconImgView;
@property (nonatomic, strong) UILabel     *nameLbl;
@property (nonatomic, strong) UILabel     *txtContentLbl;
@property (nonatomic, strong) UIView      *imgContentView;
//返回次cell的高度
-(CGFloat)cellHeight;

@end
