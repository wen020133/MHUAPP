//
//  WJTimeLabel.h
//  MHUAPP
//
//  Created by jinri on 2018/1/4.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WJTimeLabel : UIView

@property (nonatomic, strong) UILabel *hourLabel1;
@property (nonatomic, strong) UILabel *hourLabel2;
@property (nonatomic, strong) UILabel *minuteLabel1;
@property (nonatomic, strong) UILabel *minuteLabel2;
@property (nonatomic, strong) UILabel *secondLabel1;
@property (nonatomic, strong) UILabel *secondLabel2;
@property (nonatomic, strong) UILabel *startLable;
//创建定时器(因为下面两个方法都使用,所以定时器拿出来设置为一个属性)
@property (nonatomic,strong) NSTimer *countDownTimer;

@property (nonatomic, assign) NSString  *secondsCountDown;

-(void)dissMissTheNSTimer;
@end
