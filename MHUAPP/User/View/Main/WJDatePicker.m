//
//  WJDatePicker.m
//  MHUAPP
//
//  Created by jinri on 2018/1/13.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import "WJDatePicker.h"
#import "UIView+UIViewFrame.h"

#define kAlpha 0.3
#define kPrompt_DismisTime 0.3

@interface WJDatePicker ()

@property(nonatomic,strong)UIDatePicker *datePickerView;

@property(nonatomic,strong)UIView *determineView;

@property(nonatomic,strong)UIView *backView;

@property(nonatomic,strong)UIView *currentView;

@end

@implementation WJDatePicker

+ (instancetype)sharedDatePicker {

    static WJDatePicker *datePicker = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!datePicker) {
            datePicker = [WJDatePicker new];
        }
    });
    return datePicker;
}

static void(^_determineChoose)(NSString *dateString);
+ (void)showDateDetermineChooseInView:(UIView *)view
                      determineChoose:(void(^)(NSString *dateString))determineChoose
{
    [WJDatePicker sharedDatePicker].currentView = view;
    [[WJDatePicker sharedDatePicker] showDateDetermineChoose:determineChoose];
}
- (void)showDateDetermineChoose:(void(^)(NSString *dateString))determineChoose
{
    _determineChoose = determineChoose;
    [self clearViews];
    [self.currentView addSubview:self.backView];
    [self.currentView addSubview:self.datePickerView];
    [self.currentView addSubview:self.determineView];
    [UIView animateWithDuration:kPrompt_DismisTime animations:^{

        self.backView.alpha = kAlpha;
        self.datePickerView.y = self.currentView.height - self.datePickerView.height;
        self.determineView.y = self.datePickerView.y - 30;
    }];
}
- (void)disapper
{
    [UIView animateWithDuration:kPrompt_DismisTime animations:^{

        self.backView.alpha = 0;
        self.datePickerView.Y = self.currentView.height + 30;
        self.determineView.Y = self.currentView.height;

    } completion:^(BOOL finished) {

        [self clearViews];

    }];
}
- (void)clearViews
{
    [self.backView removeFromSuperview];
    [self.datePickerView removeFromSuperview];
    [self.determineView removeFromSuperview];

    self.backView = nil;
    self.datePickerView = nil;
    self.determineView = nil;
}

- (void)determineAction:(UIButton *)BT
{
    NSDate *date = self.datePickerView.date;

    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    format.dateFormat = @"yyyy-MM-dd";
    NSString *dateString = [format stringFromDate:date];
    _determineChoose(dateString);
    [self disapper];
}
#pragma mark - lazy
- (UIDatePicker *)datePickerView
{
    if (!_datePickerView) {

        _datePickerView = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, self.currentView.height + 30, self.currentView.width, self.currentView.height/4)];
        _datePickerView.backgroundColor = kMSCellBackColor;

        _datePickerView.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_ch"];
        _datePickerView.timeZone = [NSTimeZone timeZoneWithName:@"GTM+8"];

        _datePickerView.datePickerMode = UIDatePickerModeDate;
    }
    return _datePickerView;
}
- (UIView *)determineView
{
    if (!_determineView) {

        _determineView = [[UIView alloc]initWithFrame:CGRectMake(0, self.currentView.height, self.currentView.width, 30)];
        _determineView.backgroundColor = kMSCellBackColor;
        UIButton *determineBT = [UIButton buttonWithType:UIButtonTypeSystem];
        [determineBT setTitleColor:[RegularExpressionsMethod ColorWithHexString:BASEPINK] forState:UIControlStateNormal];
        [determineBT setTitle:@"确定" forState:UIControlStateNormal];
        determineBT.frame = CGRectMake(_determineView.width - 70, 0, 70, 30);
        determineBT.titleLabel.font = PFR16Font;
        [determineBT addTarget:self action:@selector(determineAction:) forControlEvents:UIControlEventTouchUpInside];
        [_determineView addSubview:determineBT];

        UIButton *determineCancel = [UIButton buttonWithType:UIButtonTypeSystem];
        [determineCancel setTitleColor:[RegularExpressionsMethod ColorWithHexString:BASEPINK] forState:UIControlStateNormal];
        [determineCancel setTitle:@"取消" forState:UIControlStateNormal];
        determineCancel.frame = CGRectMake(0, 0, 70, 30);
        determineCancel.titleLabel.font = PFR16Font;
        [determineCancel addTarget:self action:@selector(disapper) forControlEvents:UIControlEventTouchUpInside];

        [_determineView addSubview:determineCancel];
    }
    return _determineView;
}
-(UIView *)backView
{
    if (!_backView) {

        _backView = [[UIView alloc]initWithFrame:self.currentView.bounds];
        _backView.backgroundColor = [UIColor blackColor];
        _backView.alpha = 0;

        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(disapper)];
        _backView.userInteractionEnabled = YES;
        [_backView addGestureRecognizer:tap];
    }
    return _backView;
}
@end
