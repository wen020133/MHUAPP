//
//  WJDetailPartCommentHeadView.m
//  MHUAPP
//
//  Created by jinri on 2018/4/19.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import "WJDetailPartCommentHeadView.h"
#import "UIView+UIViewFrame.h"

@implementation WJDetailPartCommentHeadView
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

    UIImageView *backImag = ImageViewInit(0, 0, kMSScreenWith, 40);
    backImag.backgroundColor = kMSCellBackColor;
    [self addSubview:backImag];

    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font = Font(17);
    _titleLabel.text = @"用户评价";
    _titleLabel.textColor = [RegularExpressionsMethod ColorWithHexString:@"CA161E"];
    [self addSubview:_titleLabel];


    _quickButton = [DCZuoWenRightButton buttonWithType:UIButtonTypeCustom];
    _quickButton.titleLabel.font = PFR14Font;
    _quickButton.titleLabel.textAlignment = NSTextAlignmentRight;
    [_quickButton setImage:[UIImage imageNamed:@"home_more"] forState:UIControlStateNormal];
    [_quickButton addTarget:self action:@selector(goTomoreViewClick) forControlEvents:UIControlEventTouchUpInside];
    [_quickButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [_quickButton setTitle:@"更多" forState:UIControlStateNormal];
    [self addSubview:_quickButton];

}
#pragma mark - 更多按钮点击
- (void)goTomoreViewClick
{
    !_moreClickBlock ? : _moreClickBlock();
}
#pragma mark - 布局
- (void)layoutSubviews
{
    [super layoutSubviews];

    _titleLabel.frame = CGRectMake(10, 0, 80, self.height);
    _quickButton.frame = CGRectMake(kMSScreenWith-50, 2, 40, 30);
}
@end
