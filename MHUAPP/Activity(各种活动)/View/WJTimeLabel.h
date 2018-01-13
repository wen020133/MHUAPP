//
//  WJTimeLabel.h
//  MHUAPP
//
//  Created by jinri on 2018/1/4.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WJTimeLabel : UIView

@property (nonatomic, strong) UILabel *hourLabel;
@property (nonatomic, strong) UILabel *minuteLabel;
@property (nonatomic, strong) UILabel *secondLabel;

//创建定时器(因为下面两个方法都使用,所以定时器拿出来设置为一个属性)
@property (nonatomic,strong) NSTimer *countDownTimer;

@property NSInteger  secondsCountDown;

@end
