//
//  WJShowTypeCouponCell.m
//  MHUAPP
//
//  Created by jinri on 2017/12/4.
//  Copyright © 2017年 wenchengjun. All rights reserved.
//

#import "WJShowTypeCouponCell.h"

@implementation WJShowTypeCouponCell
#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {

    self = [super initWithFrame:frame];
    if (self) {
        [self setUpData];
    }
    return self;
}

- (void)setUpData
{
    self.leftTitleLable.text = @"领券";
    [self addSubview:self.iconImageView];
    self.iconImageView.image = [UIImage imageNamed:@"biaoqian"];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    //重写leftTitleLableFrame
    [self.leftTitleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.left.mas_equalTo(self)setOffset:DCMargin];
        make.centerY.mas_equalTo(self);
    }];

    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.left.mas_equalTo(self.leftTitleLable.mas_right)setOffset:DCMargin];
        make.centerY.mas_equalTo(self.leftTitleLable);
    }];
}


@end
