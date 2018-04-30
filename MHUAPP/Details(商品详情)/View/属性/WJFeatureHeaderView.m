//
//  WJFeatureHeaderView.m
//  MHUAPP
//
//  Created by jinri on 2018/1/10.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import "WJFeatureHeaderView.h"

@implementation WJFeatureHeaderView

#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {

    self = [super initWithFrame:frame];
    if (self) {

        [self setUpUI];
    }
    return self;
}

- (void)setUpUI
{
    _headerLabel = [[UILabel alloc] init];
    _headerLabel.font  = PFR15Font;
    [self addSubview:_headerLabel];


    _bottomView = [UIView new];
    _bottomView.backgroundColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.3];
    [self addSubview:_bottomView];
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    [_headerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.left.mas_equalTo(self)setOffset:DCMargin];
        make.centerY.mas_equalTo(self);
    }];

    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(DCMargin);
        make.right.mas_equalTo(-DCMargin);
        make.top.mas_equalTo(self);
        make.height.mas_equalTo(1);
    }];
}

#pragma mark - Setter Getter Methods
- (void)setHeadTitle:(WJFeatureItem *)headTitle
{
    _headTitle = headTitle;
    _headerLabel.text = headTitle.attrname;
}

@end
