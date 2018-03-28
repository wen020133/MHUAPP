//
//  WJSSPTAllClassHeadView.m
//  MHUAPP
//
//  Created by jinri on 2018/3/27.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import "WJSSPTAllClassHeadView.h"    //height 120+44
#import "UIView+UIViewFrame.h"

@implementation WJSSPTAllClassHeadView


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

    _img_content  = ImageViewInit(0, 0, kMSScreenWith, 120);
    _img_content.image = [UIImage imageNamed:@"main_sspt_haowuyiqipin.png"];
    [self addSubview:_img_content];

    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 120, 80, 44)];
    _titleLabel.text = @"今日必拼";
    _titleLabel.textColor = [RegularExpressionsMethod ColorWithHexString:BASEBLACKCOLOR];
    _titleLabel.font = Font(17);
    [self addSubview:_titleLabel];

    _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(kMSScreenWith-217, 120, 90, 44)];
    _timeLabel.text = @"距离本场结束";
    _timeLabel.textAlignment = NSTextAlignmentRight;
    _timeLabel.textColor = [RegularExpressionsMethod ColorWithHexString:kGrayBgColor];
    _timeLabel.font = Font(14);
    [self addSubview:_timeLabel];

    //设置定时器
    _countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countDownAction) userInfo:nil repeats:YES];
    //启动倒计时后会每秒钟调用一次方法 countDownAction

    CGFloat offset = 0;
    CGFloat lableWidth = 15;
    CGFloat height = 30;

    self.hourLabel = [[UILabel alloc] initWithFrame:CGRectMake(kMSScreenWith/2-75, 130, 24, 24)];
    self.hourLabel.textAlignment = NSTextAlignmentCenter;
    self.hourLabel.font = [UIFont systemFontOfSize:16];
    self.hourLabel.backgroundColor = [RegularExpressionsMethod ColorWithHexString:BASEPINK];
    self.hourLabel.textColor = [UIColor whiteColor];
    self.hourLabel.layer.cornerRadius = 3;
    self.hourLabel.layer.masksToBounds = YES;//设置圆角
    [self addSubview:self.hourLabel];


    UILabel *firstLable = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_hourLabel.frame)+1, 135, lableWidth, height)];
    firstLable.text = @"：";
    firstLable.textAlignment = NSTextAlignmentCenter;
    firstLable.font = [UIFont systemFontOfSize:15];
    [self addSubview:firstLable];

    self.minuteLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(firstLable.frame) + offset, 130, 24, 24)];
    self.minuteLabel.textAlignment = NSTextAlignmentCenter;
    self.minuteLabel.font = [UIFont systemFontOfSize:16];
    self.minuteLabel.backgroundColor = [RegularExpressionsMethod ColorWithHexString:BASEPINK];
    self.minuteLabel.textColor = [UIColor whiteColor];
    self.minuteLabel.layer.cornerRadius = 3;
    self.minuteLabel.layer.masksToBounds = YES;//设置圆角
    [self addSubview:_minuteLabel];



    UILabel *secondLable = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_minuteLabel.frame), 135, lableWidth, height)];
    secondLable.text = @"：";
    secondLable.textAlignment = NSTextAlignmentCenter;
    secondLable.font = [UIFont systemFontOfSize:15];
    [self addSubview:secondLable];

    self.secondLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(secondLable.frame) + offset, 130, 24, 24)];
    self.secondLabel.textAlignment = NSTextAlignmentCenter;
    self.secondLabel.font = [UIFont systemFontOfSize:16];
    self.secondLabel.backgroundColor = [RegularExpressionsMethod ColorWithHexString:BASEPINK];
    self.secondLabel.textColor = [UIColor whiteColor];
    self.secondLabel.layer.cornerRadius = 3;
    self.secondLabel.layer.masksToBounds = YES;//设置圆角
    [self addSubview:_secondLabel];



    UILabel *thredLable = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_secondLabel.frame), 135, lableWidth, height)];
    thredLable.text = @"：";
    thredLable.textAlignment = NSTextAlignmentCenter;
    thredLable.font = [UIFont systemFontOfSize:15];
    [self addSubview:thredLable];

}
//实现倒计时动作
-(void)countDownAction{
    //倒计时-1
    self.secondsCountDown--;

    //重新计算 时/分/秒
    NSString *str_hour = [NSString stringWithFormat:@"%02ld",self.secondsCountDown/3600];

    NSString *str_minute = [NSString stringWithFormat:@"%02ld",(self.secondsCountDown%3600)/60];

    NSString *str_second = [NSString stringWithFormat:@"%02ld",self.secondsCountDown%60];

    //修改倒计时标签及显示内容
    self.hourLabel.text=str_hour;
    self.minuteLabel.text=str_minute;
    self.secondLabel.text=str_second;

    //当倒计时到0时做需要的操作，比如验证码过期不能提交
    if(self.secondsCountDown==0){

        [_countDownTimer invalidate];
    }

}


@end
