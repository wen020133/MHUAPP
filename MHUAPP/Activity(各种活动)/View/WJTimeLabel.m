//
//  WJTimeLabel.m
//  MHUAPP
//
//  Created by jinri on 2018/1/4.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import "WJTimeLabel.h"



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
    //设置定时器
    _countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countDownAction) userInfo:nil repeats:YES];
    //启动倒计时后会每秒钟调用一次方法 countDownAction

    CGFloat offset = 5;
    CGFloat lableWidth = 25;
    CGFloat height = 30;

    UIImageView *imageVtime = [[UIImageView alloc]initWithFrame:CGRectMake(kMSScreenWith/2-140, 10, 30, 30)];
    imageVtime.contentMode = UIViewContentModeScaleToFill;
    imageVtime.image = [UIImage imageNamed:@"user_time.png"];
    [self addSubview:imageVtime];

    UILabel *startLable = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imageVtime.frame)+5, 10, 80 ,height)];
    startLable.text = @"开始时间:";
    startLable.font = [UIFont systemFontOfSize:16];
    [self addSubview:startLable];

    self.hourLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(startLable.frame) , 10, lableWidth, height)];
    self.hourLabel.textAlignment = NSTextAlignmentCenter;
    self.hourLabel.font = [UIFont systemFontOfSize:16];
    self.hourLabel.textColor = [UIColor redColor];
    [self addSubview:_hourLabel];

    UILabel *firstLable = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_hourLabel.frame), 10, 25, height)];
    firstLable.text = @"时:";
    firstLable.textAlignment = NSTextAlignmentLeft;
    firstLable.font = [UIFont systemFontOfSize:15];
    [self addSubview:firstLable];

    self.minuteLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(firstLable.frame) + offset, 10, lableWidth, height)];
    self.minuteLabel.textAlignment = NSTextAlignmentCenter;
    self.minuteLabel.font = [UIFont systemFontOfSize:16];
    self.minuteLabel.textColor = [UIColor redColor];
    [self addSubview:_minuteLabel];

    UILabel *secondLable = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_minuteLabel.frame), 10, 25, height)];
    secondLable.text = @"分:";
    secondLable.textAlignment = NSTextAlignmentLeft;
    secondLable.font = [UIFont systemFontOfSize:15];
    [self addSubview:secondLable];

    self.secondLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(secondLable.frame) + offset, 10, lableWidth, height)];
    self.secondLabel.textAlignment = NSTextAlignmentCenter;
    self.secondLabel.font = [UIFont systemFontOfSize:16];
    self.secondLabel.textColor = [UIColor redColor];
    [self addSubview:_secondLabel];

    UILabel *thredLable = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_secondLabel.frame), 10, 25, height)];
    thredLable.text = @"秒";
    thredLable.textAlignment = NSTextAlignmentLeft;
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
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
