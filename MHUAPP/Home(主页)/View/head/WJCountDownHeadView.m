//
//  WJCountDownHeadView.m
//  MHUAPP
//
//  Created by jinri on 2018/2/24.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import "WJCountDownHeadView.h"
#import "UIView+UIViewFrame.h"

@interface WJCountDownHeadView ()

/* title */
@property (strong , nonatomic)UILabel *titleLabel;
/* 时间 */
@property (strong , nonatomic)UILabel *timeLabel;
/* 倒计时 */
@property (strong , nonatomic)UILabel *countDownLabel;



@end


@implementation WJCountDownHeadView


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
    _titleLabel.text = @"限时秒杀";
    _titleLabel.textColor = [RegularExpressionsMethod ColorWithHexString:@"CA161E"];
    _titleLabel.font = Font(17);
    [self addSubview:_titleLabel];
    
    _timeLabel = [[UILabel alloc] init];
    _timeLabel.text = @"秒杀剩余时间";
    _timeLabel.textColor = [RegularExpressionsMethod ColorWithHexString:BASEBLACKCOLOR];
    _timeLabel.font = Font(14);
    [self addSubview:_timeLabel];

    _countDownLabel = [[UILabel alloc] init];
    _countDownLabel.textColor = [UIColor redColor];
    _countDownLabel.text = @" 05 : 58 : 33";
    _countDownLabel.font = PFR16Font;
    [self addSubview:_countDownLabel];

}

#pragma mark - 布局
- (void)layoutSubviews
{
    [super layoutSubviews];
    _titleLabel.frame = CGRectMake(10, 8, 80, self.height-8);
    _timeLabel.frame = CGRectMake(100, 8, 90, self.height-8);
    _countDownLabel.frame = CGRectMake(CGRectGetMaxX(_timeLabel.frame), 8, kMSScreenWith-210, self.height-8);
}

@end
