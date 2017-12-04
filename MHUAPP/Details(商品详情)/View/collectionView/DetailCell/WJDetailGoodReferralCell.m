//
//  WJDetailGoodReferralCell.m
//  MHUAPP
//
//  Created by jinri on 2017/12/4.
//  Copyright © 2017年 wenchengjun. All rights reserved.
//

#import "WJDetailGoodReferralCell.h"



@implementation WJDetailGoodReferralCell

#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {

    self = [super initWithFrame:frame];
    if (self) {

        [self setUpUI];
    }
    return self;
}

#pragma mark - UI
- (void)setUpUI
{
    self.backgroundColor = [UIColor whiteColor];

    _goodTitleLabel = [[UILabel alloc] init];
    _goodTitleLabel.font = PFR16Font;
    _goodTitleLabel.numberOfLines = 0;
    [self addSubview:_goodTitleLabel];

    _goodPriceLabel = [[UILabel alloc] init];
    _goodPriceLabel.font = PFR20Font;
    _goodPriceLabel.textColor = [UIColor redColor];
    [self addSubview:_goodPriceLabel];

    _goodSubtitleLabel = [[UILabel alloc] init];
    _goodSubtitleLabel.font = PFR12Font;
    _goodSubtitleLabel.numberOfLines = 0;
    _goodSubtitleLabel.textColor = kMSCellSubtitleLableColor;
    [self addSubview:_goodSubtitleLabel];



    [RegularExpressionsMethod dc_setUpAcrossPartingLineWith:self WithColor:[[UIColor lightGrayColor]colorWithAlphaComponent:0.15]];


}
#pragma mark - 布局
- (void)layoutSubviews
{
    [super layoutSubviews];



    [_goodTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.left.mas_equalTo(self)setOffset:DCMargin];
        [make.top.mas_equalTo(self)setOffset:DCMargin];
        [make.right.mas_equalTo(self)setOffset:-DCMargin * 2];
    }];


    [_goodSubtitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       [make.left.mas_equalTo(self)setOffset:DCMargin];
        [make.right.mas_equalTo(self)setOffset:-DCMargin * 5];
        [make.top.mas_equalTo(_goodTitleLabel.mas_bottom)setOffset:DCMargin];
    }];

    [_goodPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.left.mas_equalTo(self)setOffset:DCMargin];
        [make.top.mas_equalTo(_goodSubtitleLabel.mas_bottom)setOffset:DCMargin];
    }];


    [RegularExpressionsMethod dc_setUpLongLineWith:_goodTitleLabel WithColor:[[UIColor lightGrayColor]colorWithAlphaComponent:0.15] WithHightRatio:0.6];
}

@end
