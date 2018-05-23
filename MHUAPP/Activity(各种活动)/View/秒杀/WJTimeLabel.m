//
//  WJTimeLabel.m
//  MHUAPP
//
//  Created by jinri on 2018/1/4.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import "WJTimeLabel.h"
#import "UIView+UIViewFrame.h"

@interface WJTimeLabel()

@property NSInteger  sCountDown;

@end


@implementation WJTimeLabel

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupLabelInit];
    }
    return self;
}
-(void)setupLabelInit
{

    //启动倒计时后会每秒钟调用一次方法 countDownAction

    CGFloat offset = 0;
    CGFloat lableWidth = 25;
    CGFloat height = 30;


  _startLable = [[UILabel alloc] initWithFrame:CGRectMake(kMSScreenWith/2-100, 10, 200 ,height)];
    _startLable.text = @"距离结束时间还剩";
    _startLable.textAlignment = NSTextAlignmentCenter;
    _startLable.textColor = [RegularExpressionsMethod ColorWithHexString:BASEBLACKCOLOR];
    _startLable.font = PFR14Font;
    [self addSubview:_startLable];

    self.hourLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(kMSScreenWith/2-75, 37, 14, 24)];
    self.hourLabel1.textAlignment = NSTextAlignmentCenter;
    self.hourLabel1.font = [UIFont systemFontOfSize:16];
    self.hourLabel1.backgroundColor = [RegularExpressionsMethod ColorWithHexString:BASEPINK];
    self.hourLabel1.textColor = [UIColor whiteColor];
    self.hourLabel1.layer.cornerRadius = 3;
    self.hourLabel1.layer.masksToBounds = YES;//设置圆角
    [self addSubview:self.hourLabel1];

    self.hourLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(self.hourLabel1.Right+2, 37, 14, 24)];
    self.hourLabel2.textAlignment = NSTextAlignmentCenter;
    self.hourLabel2.font = [UIFont systemFontOfSize:16];
    self.hourLabel2.backgroundColor = [RegularExpressionsMethod ColorWithHexString:BASEPINK];
    self.hourLabel2.textColor = [UIColor whiteColor];
    self.hourLabel2.layer.cornerRadius = 3;
    self.hourLabel2.layer.masksToBounds = YES;//设置圆角
    [self addSubview:self.hourLabel2];

    UILabel *firstLable = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_hourLabel2.frame)+1, 35, lableWidth, height)];
    firstLable.text = @"时";
    firstLable.textAlignment = NSTextAlignmentCenter;
    firstLable.font = [UIFont systemFontOfSize:15];
    [self addSubview:firstLable];

    self.minuteLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(firstLable.frame) + offset, 37, 14, 24)];
    self.minuteLabel1.textAlignment = NSTextAlignmentCenter;
    self.minuteLabel1.font = [UIFont systemFontOfSize:16];
    self.minuteLabel1.backgroundColor = [RegularExpressionsMethod ColorWithHexString:BASEPINK];
    self.minuteLabel1.textColor = [UIColor whiteColor];
    self.minuteLabel1.layer.cornerRadius = 3;
    self.minuteLabel1.layer.masksToBounds = YES;//设置圆角
    [self addSubview:_minuteLabel1];

    self.minuteLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(self.minuteLabel1.Right+2, 37, 14, 24)];
    self.minuteLabel2.textAlignment = NSTextAlignmentCenter;
    self.minuteLabel2.font = [UIFont systemFontOfSize:16];
    self.minuteLabel2.backgroundColor = [RegularExpressionsMethod ColorWithHexString:BASEPINK];
    self.minuteLabel2.textColor = [UIColor whiteColor];
    self.minuteLabel2.layer.cornerRadius = 3;
    self.minuteLabel2.layer.masksToBounds = YES;//设置圆角
    [self addSubview:_minuteLabel2];

    UILabel *secondLable = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_minuteLabel2.frame), 35, 25, height)];
    secondLable.text = @"分";
    secondLable.textAlignment = NSTextAlignmentCenter;
    secondLable.font = [UIFont systemFontOfSize:15];
    [self addSubview:secondLable];

    self.secondLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(secondLable.frame) + offset, 37, 14, 24)];
    self.secondLabel1.textAlignment = NSTextAlignmentCenter;
    self.secondLabel1.font = [UIFont systemFontOfSize:16];
    self.secondLabel1.backgroundColor = [RegularExpressionsMethod ColorWithHexString:BASEPINK];
    self.secondLabel1.textColor = [UIColor whiteColor];
    self.secondLabel1.layer.cornerRadius = 3;
    self.secondLabel1.layer.masksToBounds = YES;//设置圆角
    [self addSubview:_secondLabel1];

    self.secondLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(self.secondLabel1.Right+2, 37, 14, 24)];
    self.secondLabel2.textAlignment = NSTextAlignmentCenter;
    self.secondLabel2.font = [UIFont systemFontOfSize:16];
    self.secondLabel2.backgroundColor = [RegularExpressionsMethod ColorWithHexString:BASEPINK];
    self.secondLabel2.textColor = [UIColor whiteColor];
    self.secondLabel2.layer.cornerRadius = 3;
    self.secondLabel2.layer.masksToBounds = YES;//设置圆角
    [self addSubview:_secondLabel2];

    UILabel *thredLable = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_secondLabel2.frame), 35, 25, height)];
    thredLable.text = @"秒";
    thredLable.textAlignment = NSTextAlignmentCenter;
    thredLable.font = [UIFont systemFontOfSize:15];
    [self addSubview:thredLable];

    _sCountDown = [self getDateDifferenceWithNowDateStr:_secondsCountDown];

    //设置定时器
    _countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countDownAction) userInfo:nil repeats:YES];
}

//实现倒计时动作
-(void)countDownAction{
    //倒计时-1
    _sCountDown--;

    //重新计算 时/分/秒
    NSString *str_hour = [NSString stringWithFormat:@"%02ld",_sCountDown/3600];

    NSString *str_minute = [NSString stringWithFormat:@"%02ld",(_sCountDown%3600)/60];

    NSString *str_second = [NSString stringWithFormat:@"%02ld",_sCountDown%60];

    //修改倒计时标签及显示内容
    self.hourLabel1.text=[str_hour substringToIndex:1];
     self.hourLabel2.text=[str_hour substringFromIndex:1];
    self.minuteLabel1.text=[str_minute substringToIndex:1];
     self.minuteLabel2.text=[str_minute substringFromIndex:1];
    self.secondLabel1.text=[str_second substringToIndex:1];
    self.secondLabel2.text=[str_second substringFromIndex:1];

    //当倒计时到0时做需要的操作，比如验证码过期不能提交
    if(self.secondsCountDown==0){

        [_countDownTimer invalidate];
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
