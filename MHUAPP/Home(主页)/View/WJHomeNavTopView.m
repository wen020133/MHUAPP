//
//  WJHomeNavTopView.m
//  MHUAPP
//
//  Created by jinri on 2018/2/6.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import "WJHomeNavTopView.h"
#import "JXButton.h"

@interface WJHomeNavTopView ()
/* 左边Item */
@property (strong , nonatomic) JXButton *leftItemButton;
/* 右边Item */
@property (strong , nonatomic) JXButton *rightItemButton;
/* 搜索 */
@property (strong , nonatomic)UIView *topSearchView;
/* 搜索按钮 */
@property (strong , nonatomic)UIButton *searchButton;

@end
@implementation WJHomeNavTopView

#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {

    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kMSNavBarBackColor;
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI
{
    _leftItemButton = [JXButton new];
        [_leftItemButton setTitle:@"扫一扫" forState:UIControlStateNormal];
        [_leftItemButton setImage:[UIImage imageNamed:@"home_sweep"] forState:UIControlStateNormal];
        [_leftItemButton addTarget:self action:@selector(leftButtonItemClick) forControlEvents:UIControlEventTouchUpInside];



    _rightItemButton = [JXButton new];
    [_rightItemButton setTitle:@"消息" forState:UIControlStateNormal];
        [_rightItemButton setImage:[UIImage imageNamed:@"home_message"] forState:UIControlStateNormal];
        [_rightItemButton addTarget:self action:@selector(rightButtonItemClick) forControlEvents:UIControlEventTouchUpInside];


    [self addSubview:_rightItemButton];
    [self addSubview:_leftItemButton];

    CAGradientLayer * layer = [[CAGradientLayer alloc] init];
    layer.frame = self.bounds;
    layer.colors = @[(id)[UIColor colorWithWhite:0 alpha:0.2].CGColor,(id)[UIColor colorWithWhite:0 alpha:0.15].CGColor,(id)[UIColor colorWithWhite:0 alpha:0.1].CGColor,(id)[UIColor colorWithWhite:0 alpha:0.05].CGColor,(id)[UIColor colorWithWhite:0 alpha:0.03].CGColor,(id)[UIColor colorWithWhite:0 alpha:0.01].CGColor,(id)[UIColor colorWithWhite:0 alpha:0.0].CGColor];
    [self.layer addSublayer:layer];

    _topSearchView = [[UIView alloc] init];
    _topSearchView.backgroundColor = kMSColorFromRGB(255, 103, 105);
    _topSearchView.layer.cornerRadius = 16;
    [_topSearchView.layer masksToBounds];
    [self addSubview:_topSearchView];

    _searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_searchButton setTitle:@"发现喜欢的话题圈子用户" forState:0];
    [_searchButton setTitleColor:[UIColor lightGrayColor] forState:0];
    _searchButton.titleLabel.font = PFR13Font;
    [_searchButton setImage:[UIImage imageNamed:@"home_search"] forState:0];
    [_searchButton adjustsImageWhenHighlighted];
    _searchButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _searchButton.titleEdgeInsets = UIEdgeInsetsMake(0, 2 * DCMargin, 0, 0);
    _searchButton.imageEdgeInsets = UIEdgeInsetsMake(0, DCMargin, 0, 0);
    [_searchButton addTarget:self action:@selector(searchButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [_topSearchView addSubview:_searchButton];
}

#pragma mark - 布局
- (void)layoutSubviews
{
    [super layoutSubviews];

    [_leftItemButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(20);
        make.left.equalTo(self.mas_left).offset(10);
        make.height.equalTo(@38);
        make.width.equalTo(@42);
    }];

    [_rightItemButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_leftItemButton.mas_centerY);
        make.right.equalTo(self.mas_right).offset(-10);
        make.height.equalTo(@44);
        make.width.equalTo(@44);
    }];

    [_topSearchView mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.left.mas_equalTo(_leftItemButton.mas_right)setOffset:10];
        [make.right.mas_equalTo(_rightItemButton.mas_left)setOffset:-10];
        make.height.mas_equalTo(@(32));
        make.centerY.mas_equalTo(_rightItemButton);

    }];

    [_searchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_topSearchView);
        make.top.mas_equalTo(_topSearchView);
        make.height.mas_equalTo(_topSearchView);
        [make.right.mas_equalTo(_topSearchView)setOffset:-2*DCMargin];
    }];
}
#pragma 自定义右边导航Item点击
- (void)rightButtonItemClick {
    !_rightItemClickBlock ? : _rightItemClickBlock();
}

#pragma 自定义左边导航Item点击
- (void)leftButtonItemClick {

    !_leftItemClickBlock ? : _leftItemClickBlock();
}

#pragma mark - 搜索按钮点击
- (void)searchButtonClick
{
    !_searchButtonClickBlock ? : _searchButtonClickBlock();
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
