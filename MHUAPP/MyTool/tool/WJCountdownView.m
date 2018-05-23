//
//  WJCountdownView.m
//  MHUAPP
//
//  Created by jinri on 2018/5/22.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import "WJCountdownView.h"   //height 44  width 180
#import "UIView+UIViewFrame.h"


@interface WJCountdownView()
@property (nonatomic, strong) UILabel *labelTime;

@property (nonatomic, strong) UILabel *hourLabel;
@property (nonatomic, strong) UILabel *minuteLabel;
@property (nonatomic, strong) UILabel *secondLabel;
//创建定时器(因为下面两个方法都使用,所以定时器拿出来设置为一个属性)
@property (nonatomic,strong) NSTimer *countDownTimer;

@property NSInteger  secondCountDown;
@end

@implementation WJCountdownView

- (id)initWithFrame:(CGRect)frame withContentTime:(NSString *)timeStr
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initnoMoredata:timeStr];
    }
    return self;
}
-(void)initnoMoredata:(NSString *)timeStr
{
    UIImageView *imag_nomore = [[UIImageView alloc]initWithFrame:CGRectMake(0, 10, 24, 24)];
    [imag_nomore setImage:[UIImage imageNamed:@"countDownEnd"]];
    imag_nomore.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:imag_nomore];

    _labelTime = [[UILabel alloc] initWithFrame:CGRectMake(30, 10, 50, 24)];
    _labelTime.text = @"距结束:";
    _labelTime.textAlignment = NSTextAlignmentLeft;
    _labelTime.textColor = kMSCellBackColor;
    _labelTime.font = Font(13);
    [self addSubview:_labelTime];

     _secondCountDown = [self getDateDifferenceWithNowDateStr:timeStr];
    //设置定时器
    _countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countDownAction) userInfo:nil repeats:YES];
    //启动倒计时后会每秒钟调用一次方法 countDownAction

    CGFloat lableWidth = 12;
    CGFloat height = 30;

    _hourLabel = [[UILabel alloc] initWithFrame:CGRectMake(_labelTime.Right+5, 11, 22, 22)];
    _hourLabel.textAlignment = NSTextAlignmentCenter;
    _hourLabel.font = [UIFont systemFontOfSize:15];
    _hourLabel.backgroundColor = kMSCellBackColor;
    _hourLabel.textColor = [RegularExpressionsMethod ColorWithHexString:BASEPINK];;
    _hourLabel.layer.cornerRadius = 3;
    _hourLabel.layer.masksToBounds = YES;//设置圆角
    [self addSubview:_hourLabel];


    UILabel *firstLable = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_hourLabel.frame), 7, lableWidth, height)];
    firstLable.text = @":";
    firstLable.textAlignment = NSTextAlignmentCenter;
    firstLable.textColor = kMSCellBackColor;
    [self addSubview:firstLable];

    _minuteLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(firstLable.frame), 11, 22, 22)];
    _minuteLabel.textAlignment = NSTextAlignmentCenter;
    _minuteLabel.font = [UIFont systemFontOfSize:15];
    _minuteLabel.backgroundColor = kMSCellBackColor;
    _minuteLabel.textColor = [RegularExpressionsMethod ColorWithHexString:BASEPINK];;
    _minuteLabel.layer.cornerRadius = 3;
    _minuteLabel.layer.masksToBounds = YES;//设置圆角
    [self addSubview:_minuteLabel];



    UILabel *secondLable = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_minuteLabel.frame), 7, lableWidth, height)];
    secondLable.text = @":";
    secondLable.textAlignment = NSTextAlignmentCenter;
    secondLable.textColor = kMSCellBackColor;
    [self addSubview:secondLable];

    _secondLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(secondLable.frame), 11, 22, 22)];
    _secondLabel.textAlignment = NSTextAlignmentCenter;
    _secondLabel.font = [UIFont systemFontOfSize:16];
    _secondLabel.backgroundColor = kMSCellBackColor;
    _secondLabel.textColor = [RegularExpressionsMethod ColorWithHexString:BASEPINK];
    _secondLabel.layer.cornerRadius = 3;
    _secondLabel.layer.masksToBounds = YES;//设置圆角
    [self addSubview:_secondLabel];
}

//实现倒计时动作
-(void)countDownAction{
    //倒计时-1
    self.secondCountDown--;

    //重新计算 时/分/秒
    NSString *str_hour = [NSString stringWithFormat:@"%02ld",self.secondCountDown/3600];

    NSString *str_minute = [NSString stringWithFormat:@"%02ld",(self.secondCountDown%3600)/60];

    NSString *str_second = [NSString stringWithFormat:@"%02ld",self.secondCountDown%60];

    //修改倒计时标签及显示内容
    _hourLabel.text=str_hour;
    _minuteLabel.text=str_minute;
    _secondLabel.text=str_second;

    //当倒计时到0时做需要的操作，比如验证码过期不能提交
    if(self.secondCountDown==0){

        [_countDownTimer invalidate];
        _countDownTimer = nil;
        _labelTime.text = @"已结束";
    }

}

- (NSInteger)getDateDifferenceWithNowDateStr:(NSString*)deadlineStr {
    NSInteger timeDifference = 0;
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval nowDate=[dat timeIntervalSince1970];

    NSTimeInterval endTime = [deadlineStr doubleValue];
    timeDifference = endTime-nowDate;

    return timeDifference;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
