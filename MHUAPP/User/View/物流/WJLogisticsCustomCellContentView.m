//
//  WJLogisticsCustomCellContentView.m
//  MHUAPP
//
//  Created by jinri on 2018/5/8.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import "WJLogisticsCustomCellContentView.h"
#import "WJLogisticsModel.h"
#import <YYKit.h>

@interface WJLogisticsCustomCellContentView ()

@property (strong, nonatomic)YYLabel *infoLabel;
@property (strong, nonatomic)UILabel *dateLabel;
@property (nonatomic,strong) UIWebView *phoneCallWebView;

@end

#define PHONEREGULAR @"\\d{3,4}[- ]?\\d{7,8}"//匹配10到12位连续数字，或者带连字符/空格的固话号，空格和连字符可以省略。

@implementation WJLogisticsCustomCellContentView
-(instancetype)init
{
    self = [super init];

    if (self) {
        [self creatSubViewsUI];
    }
    return self;
}

//看看model里面有不有电话号码
- (void)reloadDataWithModel:(WJLogisticsModel *)model {
    NSRange stringRange = NSMakeRange(0, model.dsc.length);
    //正则匹配
    NSError *error;
    NSRegularExpression *regexps = [NSRegularExpression regularExpressionWithPattern:PHONEREGULAR options:0 error:&error];
    // 转为富文本
    NSMutableAttributedString *dsc = [[NSMutableAttributedString alloc]initWithString:model.dsc];
    // NSFontAttributeName
    [dsc addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(0, model.dsc.length)];
    if (self.currented) {
        [dsc addAttribute:NSForegroundColorAttributeName value:kMSColorFromRGB(7, 166, 40) range:NSMakeRange(0, model.dsc.length)];
    }else {
        [dsc addAttribute:NSForegroundColorAttributeName value:kMSColorFromRGB(139, 139, 139) range:NSMakeRange(0, model.dsc.length)];
    }
    if (!error && regexps != nil) {
        [regexps enumerateMatchesInString:model.dsc options:0 range:stringRange usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {
            //可能为电话号码的字符串及其所在位置
            NSMutableAttributedString *actionString = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@",[model.dsc substringWithRange:result.range]]];
            NSRange phoneRange = result.range;
            //这里需要判断是否是电话号码，并添加链接
            if ([RegularExpressionsMethod validateMobile:actionString.string]) {
                [dsc setTextHighlightRange:phoneRange
                                     color:[RegularExpressionsMethod ColorWithHexString:@"59A3E8"]
                           backgroundColor:[UIColor whiteColor]
                                 tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
                                     [self callPhoneThree:actionString.string];
                                 }];

            }
        }];
    }

    self.infoLabel.attributedText = dsc;
    self.dateLabel.text = model.date;

    [self setNeedsDisplay];
}
//开始打电话
- (void)callPhoneThree:(NSString *)phoneNum{
    /*--------拨号方法三-----------*/
    NSURL *phoneURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",phoneNum]];
    if ( !_phoneCallWebView ) {

        _phoneCallWebView = [[UIWebView alloc] initWithFrame:CGRectZero];// 这个webView只是一个后台的容易 不需要add到页面上来  效果跟方法二一样 但是这个方法是合法的
    }
    [_phoneCallWebView loadRequest:[NSURLRequest requestWithURL:phoneURL]];
}

//创建子视图
- (void)creatSubViewsUI
{
    self.backgroundColor = [UIColor whiteColor];

    YYLabel *info= [[YYLabel alloc]init];
    info.numberOfLines = 0;
    [self addSubview:info];
    _infoLabel = info;

    UILabel *date = [[UILabel alloc]init];
    date.font = [UIFont systemFontOfSize:12];
    date.textColor = kMSColorFromRGB(185, 185, 185);
    [self addSubview:date];
    _dateLabel = date;

    UILabel *line = [[UILabel alloc]init];
    line.backgroundColor = kMSColorFromRGB(238, 238, 238);
    [self addSubview:line];


    [info mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).offset(10);
        make.left.mas_equalTo(self).offset(50);
        make.right.mas_equalTo(self).offset(-10);
        make.bottom.mas_equalTo(date.mas_top).offset(-4);
    }];

    [date mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(info);
        make.bottom.mas_equalTo(self).offset(-10);
        make.right.mas_equalTo(info);
        make.top.mas_equalTo(info.mas_bottom).offset(4);
        make.height.mas_equalTo(@20);
    }];

    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(50);
        make.right.mas_equalTo(self);
        make.bottom.mas_equalTo(self);
        make.height.mas_equalTo(@1);
    }];


}
//画出左面流程
-(void)drawRect:(CGRect)rect
{
    CGFloat height = self.bounds.size.height;
    CGFloat cicleWith = self.currented?12:8;

    //顶部画线(从中心源点向上开始画)
    if (self.hasUpLine) {
        UIBezierPath *topBezier = [UIBezierPath bezierPath];
        [topBezier moveToPoint:CGPointMake(50 / 2.0, 0)];
        [topBezier addLineToPoint:CGPointMake(50 /2.0, height / 2 - cicleWith / 2 - cicleWith / 6)];
        topBezier.lineWidth = 1.0;
        UIColor *stroke = [RegularExpressionsMethod ColorWithHexString:BASEBLACKCOLOR];
        [stroke set];
        [topBezier stroke];
    }
    //画出物流最新的位置
    if (self.currented) {
        UIBezierPath *currentPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(50 / 2 - cicleWith / 2, height / 2 - cicleWith / 2, cicleWith, cicleWith)];
        currentPath.lineWidth = cicleWith / 3;
        UIColor *CurrenColor = BASEGreenColor;
        [CurrenColor set];
        [currentPath stroke];
    }
    else
    {
        //画出每个cell的中心点
        UIBezierPath *cicle = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(50/2.0-cicleWith/2.0, height/2.0 - cicleWith/2.0, cicleWith, cicleWith)];

        UIColor *cColor = [RegularExpressionsMethod ColorWithHexString:kGrayBgColor];
        [cColor set];
        [cicle fill];
        [cicle stroke];

    }
    //从中心点向下画出.
    if (self.hasDownLine) {
        UIBezierPath *downBezier = [UIBezierPath bezierPath];
        [downBezier moveToPoint:CGPointMake(50/2.0, height/2.0 + cicleWith/2.0 + cicleWith/6.0)];
        [downBezier addLineToPoint:CGPointMake(50/2.0, height)];

        downBezier.lineWidth = 1.0;
        UIColor *stroke = [RegularExpressionsMethod ColorWithHexString:BASEBLACKCOLOR];
        [stroke set];
        [downBezier stroke];
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
