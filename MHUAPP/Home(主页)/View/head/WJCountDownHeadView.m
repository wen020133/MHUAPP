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

@property (nonatomic, strong)NSTimer *timer;
@end


@implementation WJCountDownHeadView


#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {

    self = [super initWithFrame:frame];
    if (self) {

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
    _countDownLabel.font = PFR16Font;
    [self addSubview:_countDownLabel];

    

}
- (void)timeHeadle{

     NSInteger secondsCountDown = [self getDateDifferenceWithNowDateStr:self.end_time];
    NSInteger startCountDown = [self getDateDifferenceWithStartStr:self.start_time];

    // 重新计算 时/分/秒
    NSString *str_hour = [NSString stringWithFormat:@"%02ld", secondsCountDown / 3600];
    NSString *str_minute = [NSString stringWithFormat:@"%02ld", (secondsCountDown % 3600) / 60];
    NSString *str_second = [NSString stringWithFormat:@"%02ld", secondsCountDown % 60];
    NSString *format_time = [NSString stringWithFormat:@"%@ : %@ : %@", str_hour, str_minute, str_second];
    // 修改倒计时标签及显示内容
    _countDownLabel.text = [NSString stringWithFormat:@"%@", format_time];

    if (startCountDown<= 0) {
        _timeLabel.text = @"秒杀开始时间";
    }
    // 当倒计时结束时做需要的操作: 比如活动到期不能提交
    if(secondsCountDown <= 0) {
        _timeLabel.text = @"秒杀剩余时间";
//        self.countDownLabel.text = @"当前活动已结束";
        [_timer invalidate];
        _timer = nil;
    }
}
-(void)setEnd_time:(NSString *)end_time
{
    if (end_time!=_end_time) {
        _end_time = end_time;
    }
     _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeHeadle) userInfo:nil repeats:YES];
}
#pragma mark - 布局
- (void)layoutSubviews
{
    [super layoutSubviews];
    _titleLabel.frame = CGRectMake(10, 8, 80, self.height-8);
    _timeLabel.frame = CGRectMake(100, 8, 90, self.height-8);
    _countDownLabel.frame = CGRectMake(CGRectGetMaxX(_timeLabel.frame), 8, kMSScreenWith-210, self.height-8);
}
- (NSInteger)getDateDifferenceWithStartStr:(NSString*)startStr {
    NSInteger timeDifference = 0;
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval nowDate=[dat timeIntervalSince1970];

    NSTimeInterval startTime = [startStr doubleValue];
    timeDifference = nowDate-startTime;

    return timeDifference;
}

- (NSInteger)getDateDifferenceWithNowDateStr:(NSString*)deadlineStr {
    NSInteger timeDifference = 0;
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval nowDate=[dat timeIntervalSince1970];

    NSTimeInterval endTime = [deadlineStr doubleValue];
    timeDifference = endTime-nowDate;

    return timeDifference;
}
@end
