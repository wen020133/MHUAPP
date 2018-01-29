//
//  WJUserHeadAndOrderView.m
//  MHUAPP
//
//  Created by jinri on 2017/12/6.
//  Copyright © 2017年 wenchengjun. All rights reserved.
//

#import "WJUserHeadAndOrderView.h"
#import "UIView+UIViewFrame.h"

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

    _headBackView = [[UIImageView alloc] init];
    _headBackView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(changeHeadClick)];
    [_headBackView addGestureRecognizer:tapGesture];
    _headBackView.image = [UIImage imageNamed:@"user_headBC.png"];
    [_view_head addSubview:_headBackView];

    _headImageView = [[UIImageView alloc] init];
    _headImageView.contentMode = UIViewContentModeScaleAspectFill;
    _headImageView.layer.masksToBounds = YES;
    _headImageView.layer.cornerRadius = 34;
    [_view_head addSubview:_headImageView];


    _userNameLabel = [[UILabel alloc] init];
    _userNameLabel.font = PFR15Font;
    _userNameLabel.textColor = kMSViewTitleColor;
    _userNameLabel.text = @"usreName";
    _userNameLabel.textAlignment = NSTextAlignmentCenter;
    [_view_head addSubview:_userNameLabel];


//    _profileLabel = [[UILabel alloc] init];
//    _profileLabel.font = PFR15Font;
//    _profileLabel.textColor = kMSViewTitleColor;
//    _profileLabel.textAlignment = NSTextAlignmentCenter;
//    _profileLabel.text = @"签名";
//    [_view_head addSubview:_profileLabel];

    UILabel *labMyOrder = [[UILabel alloc] initWithFrame:CGRectMake(DCMargin, self.height-33, 150, 26)];
    labMyOrder.font = PFR18Font;
    labMyOrder.textColor = [UIColor blackColor];
    labMyOrder.textAlignment = NSTextAlignmentLeft;
    labMyOrder.text = @"我的订单";
    [self addSubview:labMyOrder];

    _btnSeeAll = [UIButton buttonWithType:UIButtonTypeCustom];
    _btnSeeAll.frame = CGRectMake(self.width-100, self.height-33, 78, 26);
    _btnSeeAll.titleLabel.font = PFR16Font;
    [_btnSeeAll setTitleColor:[RegularExpressionsMethod ColorWithHexString:BASEBLACKCOLOR] forState:UIControlStateNormal];
    _btnSeeAll.titleLabel.textAlignment = NSTextAlignmentRight;
    [_btnSeeAll setTitle:@"查看全部" forState:UIControlStateNormal];
    [_btnSeeAll addTarget:self action:@selector(goToAllOrderVC) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_btnSeeAll];

    _actionImageView = [[UIImageView alloc] init];
    _actionImageView.image = [UIImage imageNamed:@"user_action_right.png"];
    _actionImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_actionImageView];

    _lineImageView = [[UIImageView alloc] init];
    _lineImageView.backgroundColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.5];
    [self addSubview:_lineImageView];
}
#pragma mark - 布局
- (void)layoutSubviews
{
    [super layoutSubviews];

    [_headBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.top.mas_equalTo(_view_head.mas_top)setOffset:10];
        make.centerX.mas_equalTo(_view_head.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(100, 100));

    }];
    [_headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(68, 68));
         make.center.mas_equalTo(_headBackView);
    }];


    [_userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.top.mas_equalTo(_headBackView.mas_bottom)setOffset:4];
        make.centerX.mas_equalTo(_view_head.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(200, 20));

    }];
//    [_profileLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        [make.top.mas_equalTo(_userNameLabel.mas_bottom)setOffset:2];
//        make.centerX.mas_equalTo(_view_head.mas_centerX);
//        make.size.mas_equalTo(CGSizeMake(200, 20));
//
//    }];
    [_actionImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.left.mas_equalTo(self.mas_right)setOffset:-25];
        [make.bottom.mas_equalTo(self.mas_bottom) setOffset:-12];
        make.size.mas_equalTo(CGSizeMake(13, 19));
    }];
    [_lineImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.bottom.mas_equalTo(self.mas_bottom)setOffset:-1];
        make.centerX.mas_equalTo(self.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(self.width-20, 2));
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
