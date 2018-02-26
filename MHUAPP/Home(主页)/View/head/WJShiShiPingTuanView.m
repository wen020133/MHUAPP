//
//  WJShiShiPingTuanView.m
//  MHUAPP
//
//  Created by jinri on 2018/2/25.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import "WJShiShiPingTuanView.h"
#import "UIView+UIViewFrame.h"
#import "DCZuoWenRightButton.h"

@interface WJShiShiPingTuanView ()


/* 更多 */
@property (strong , nonatomic) DCZuoWenRightButton *quickButton;

@end
@implementation WJShiShiPingTuanView
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
    self.backgroundColor = [UIColor clearColor];

    UIImageView *backImag = ImageViewInit(0, 8, kMSScreenWith, 40);
    backImag.backgroundColor = kMSCellBackColor;
    [self addSubview:backImag];

    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font = Font(17);
    _titleLabel.textColor = [RegularExpressionsMethod ColorWithHexString:@"CA161E"];
    [self addSubview:_titleLabel];


    _quickButton = [DCZuoWenRightButton buttonWithType:UIButtonTypeCustom];
    _quickButton.titleLabel.font = PFR14Font;
    _quickButton.titleLabel.textAlignment = NSTextAlignmentRight;
    [_quickButton setImage:[UIImage imageNamed:@"home_more"] forState:UIControlStateNormal];
    [_quickButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [_quickButton setTitle:@"更多" forState:UIControlStateNormal];
    [self addSubview:_quickButton];

}

#pragma mark - 布局
- (void)layoutSubviews
{
    [super layoutSubviews];

    _titleLabel.frame = CGRectMake(10, 8, 80, self.height-8);
    _quickButton.frame = CGRectMake(kMSScreenWith-50, 8, 40, 30);
}
@end
