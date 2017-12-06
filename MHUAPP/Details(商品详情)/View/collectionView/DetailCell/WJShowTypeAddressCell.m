//
//  WJShowTypeAddressCell.m
//  MHUAPP
//
//  Created by jinri on 2017/12/4.
//  Copyright © 2017年 wenchengjun. All rights reserved.
//

#import "WJShowTypeAddressCell.h"

@implementation WJShowTypeAddressCell

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
    self.leftTitleLable.text = @"送至";
    self.hintLabel.text = @"由DC商贸配送监管";
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.hintLabel.font = PFR12Font;
    [self addSubview:self.iconImageView];
    self.iconImageView.image = [UIImage imageNamed:@"ptgd_icon_dizhi"];

    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.left.mas_equalTo(self.leftTitleLable.mas_right)setOffset:DCMargin];
        make.centerY.mas_equalTo(self.leftTitleLable);
    }];

    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.left.mas_equalTo(self.iconImageView.mas_right)setOffset:DCMargin];
        make.centerY.mas_equalTo(self.leftTitleLable);
    }];

    [self.hintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.iconImageView);
        [make.top.mas_equalTo(self.contentLabel.mas_bottom)setOffset:8];
    }];

}

@end
