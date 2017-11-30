//
//  WJNavSearchBarView.m
//  MHUAPP
//
//  Created by jinri on 2017/11/30.
//  Copyright © 2017年 wenchengjun. All rights reserved.
//

#import "WJNavSearchBarView.h"
#import "UIView+UIViewFrame.h"


@implementation WJNavSearchBarView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {

        [self setUpUI];
        UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(searchClick)];
        [self addGestureRecognizer:tapGesture];
    }
    return self;
}


- (void)setUpUI
{
    self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.1];

    _placeholdLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    _placeholdLabel.font = PFR14Font;
    _placeholdLabel.textColor = [UIColor whiteColor];
    [self addSubview:_placeholdLabel];

}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _placeholdLabel.frame = CGRectMake(DCMargin, 0, self.width - 50, self.height);

    [_placeholdLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.left.equalTo(self)setOffset:DCMargin];
        make.top.equalTo(self);
        make.height.equalTo(self);

    }];

    //设置边角
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(2, 2)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}

#pragma mark - Intial
- (void)awakeFromNib {
    [super awakeFromNib];

}

#pragma mark - Setter Getter Methods

- (void)searchClick
{
    !_searchViewBlock ?: _searchViewBlock();
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
