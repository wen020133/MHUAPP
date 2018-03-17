//
//  WJUserHeadAndOrderView.m
//  MHUAPP
//
//  Created by jinri on 2017/12/6.
//  Copyright © 2017年 wenchengjun. All rights reserved.
//

#import "WJUserHeadAndOrderView.h"
#import "UIView+UIViewFrame.h"    //height 240

@implementation WJUserHeadAndOrderView

#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {

    self = [super initWithFrame:frame];
    if (self) {

        [self setUpUI];
    }
    return self;
}

-(void)setUpUI
{
    self.backgroundColor = kMSCellBackColor;
    _view_head = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kMSScreenWith, self.height-40)];
    [self addSubview:_view_head];

    UIImageView *backV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"user_backImageHead.png"]];
    backV.frame = _view_head.frame;
    [_view_head addSubview:backV];

    _titleLabel = [[UILabel alloc] init];
    _titleLabel.text = @"个人中心";
    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.textColor = kMSViewTitleColor;
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.font = PFR20Font;
    [_view_head addSubview:_titleLabel];


    _headImageView = [[UIImageView alloc] init];
    _headImageView.contentMode = UIViewContentModeScaleAspectFill;
    _headImageView.layer.masksToBounds = YES;
    _headImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeHeadClick)];
    [_headImageView addGestureRecognizer:singleTap];
    _headImageView.layer.cornerRadius = 34;
    [_view_head addSubview:_headImageView];


    _userNameLabel = [[UILabel alloc] init];
    _userNameLabel.font = PFR16Font;
    _userNameLabel.textColor = kMSViewTitleColor;
    _userNameLabel.text = @"usreName";
    _userNameLabel.textAlignment = NSTextAlignmentCenter;
    [_view_head addSubview:_userNameLabel];


    UILabel *labMyOrder = [[UILabel alloc] initWithFrame:CGRectMake(DCMargin, self.height-33, 150, 26)];
    labMyOrder.font = PFR18Font;
    labMyOrder.textColor = [RegularExpressionsMethod ColorWithHexString:BASEBLACKCOLOR];
    labMyOrder.textAlignment = NSTextAlignmentLeft;
    labMyOrder.text = @"我的订单";
    [self addSubview:labMyOrder];

    _settingButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _settingButton.frame = CGRectMake(kMSScreenWith-40, 25, 30, 29);
    [_settingButton setBackgroundImage:[UIImage imageNamed:@"user_set"] forState:UIControlStateNormal];
    [_settingButton addTarget:self action:@selector(changeHeadClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_settingButton];

    _btnSeeAll = [UIButton buttonWithType:UIButtonTypeCustom];
    _btnSeeAll.frame = CGRectMake(self.width-100, self.height-33, 78, 26);
    _btnSeeAll.titleLabel.font = PFR16Font;
    [_btnSeeAll setTitleColor:[RegularExpressionsMethod ColorWithHexString:BASELITTLEBLACKCOLOR] forState:UIControlStateNormal];
    _btnSeeAll.titleLabel.textAlignment = NSTextAlignmentRight;
    [_btnSeeAll setTitle:@"查看全部" forState:UIControlStateNormal];
    [_btnSeeAll addTarget:self action:@selector(goToAllOrderVC) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_btnSeeAll];

    _actionImageView = [[UIImageView alloc] init];
    _actionImageView.image = [UIImage imageNamed:@"home_more"];
    _actionImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_actionImageView];

    _lineImageView = [[UIImageView alloc] init];
    _lineImageView.backgroundColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.4];
    [self addSubview:_lineImageView];
}
#pragma mark - 布局
- (void)layoutSubviews
{
    [super layoutSubviews];

    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.top.mas_equalTo(_view_head.mas_top)setOffset:30];
        make.centerX.mas_equalTo(_view_head.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(200, 30));

    }];
    [_headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
    [make.top.mas_equalTo(_titleLabel.mas_top)setOffset:55];
        make.size.mas_equalTo(CGSizeMake(68, 68));
    make.centerX.mas_equalTo(self.mas_centerX);
    }];


    [_userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.top.mas_equalTo(_headImageView.mas_bottom)setOffset:6];
        make.centerX.mas_equalTo(self.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(200, 20));

    }];

    [_actionImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.left.mas_equalTo(self.mas_right)setOffset:-25];
        [make.bottom.mas_equalTo(self.mas_bottom) setOffset:-15];
        make.size.mas_equalTo(CGSizeMake(6, 10));
    }];
    [_lineImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.bottom.mas_equalTo(self.mas_bottom)setOffset:-1];
        make.centerX.mas_equalTo(self.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(self.width, 1));
    }];
}
-(void)changeHeadClick
{
     !_touchClickBlock ?: _touchClickBlock();
}
-(void)goToAllOrderVC
{
    !_goToOrderClickBlock ?: _goToOrderClickBlock();
}
@end
