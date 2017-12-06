//
//  WJUserMainTabelCell.m
//  MHUAPP
//
//  Created by jinri on 2017/12/6.
//  Copyright © 2017年 wenchengjun. All rights reserved.
//

#import "WJUserMainTabelCell.h"
#import "UIView+UIViewFrame.h"

@implementation WJUserMainTabelCell

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
    self.backgroundColor = kMSCellBackColor;
    _flowImageView = [[UIImageView alloc] init];
    _flowImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_flowImageView];


    _flowTextLabel = [[UILabel alloc] init];
    _flowTextLabel.font = PFR16Font;
    _flowTextLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_flowTextLabel];

    _countLabel = [[UILabel alloc] init];
    _countLabel.font = PFR16Font;
    _countLabel.textColor = kMSNavBarBackColor;
    _countLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:_countLabel];

    _actionImageView = [[UIImageView alloc] init];
    _actionImageView.image = [UIImage imageNamed:@"user_action_right.png"];
    _actionImageView.contentMode = UIViewContentModeScaleAspectFit;
     [self addSubview:_actionImageView];

    [RegularExpressionsMethod dc_setUpAcrossPartingLineWith:self WithColor:[[UIColor lightGrayColor]colorWithAlphaComponent:0.15]];
}

#pragma mark - 布局
- (void)layoutSubviews
{
    [super layoutSubviews];
    [_flowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.left.mas_equalTo(self)setOffset:15];
        make.centerY.mas_equalTo(self.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(28, 28));

    }];
    [_flowTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.left.mas_equalTo(_flowImageView.mas_right)setOffset:DCMargin];
        make.centerY.mas_equalTo(self.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(200, 20));
    }];
    [_countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.right.mas_equalTo(self.mas_right)setOffset:-25];
        make.centerY.mas_equalTo(self.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(40, 20));
    }];
    [_actionImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.left.mas_equalTo(self.mas_right)setOffset:-20];
        make.centerY.mas_equalTo(self.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(13, 19));
    }];
}



#pragma mark - Setter Getter Methods
- (void)setFlowItem:(WJFlowItem *)flowItem
{
    _flowItem = flowItem;

    _flowImageView.image = [UIImage imageNamed:_flowItem.flowImageView];
    _flowTextLabel.text = _flowItem.flow_title;
    _countLabel.text = @"(1)";
}
@end
