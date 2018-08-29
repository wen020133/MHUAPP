//
//  WJToast.m
//  MHUAPP
//
//  Created by wenchengjun on 2018/8/29.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import "WJToast.h"
#import "UIView+UIViewFrame.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@implementation WJToast

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+ (void)showToastWithMessage:(NSString *)message checkCouponButtonClickedBlock:(void(^)(void))checkButtonClickedBlock
{
    // 大背景
    UIView *bgView = [[self alloc] initWithFrame:CGRectMake(0, kMSNaviHight+DCMargin, kMSScreenWith, 30)];
    bgView.backgroundColor = [UIColor clearColor];
    [[UIApplication sharedApplication].keyWindow addSubview:bgView];
    // 名字
    float nameWidth = [RegularExpressionsMethod widthOfString:message font:[UIFont systemFontOfSize:13] height:20];
     NSString *stringSub = [NSString stringWithFormat:@" 在%u秒前成功下单",1+arc4random() % 59];
    float strSubWidth = [RegularExpressionsMethod widthOfString:stringSub font:[UIFont systemFontOfSize:13] height:20];
    
    UIImageView *backImag = ImageViewInit(DCMargin, 0, nameWidth+strSubWidth+82, 30);
    backImag.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    backImag.layer.cornerRadius = 7;
    backImag.layer.masksToBounds = YES;//设置圆角
    [bgView addSubview:backImag];
    
    UIImageView *bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_sound.png"]];
    [bgView addSubview:bgImageView];
    bgImageView.frame = CGRectMake(DCMargin*2, 2, 26, 26);
    
   
    UILabel *signLabel = [[UILabel alloc] initWithFrame:CGRectMake(bgImageView.Right+DCMargin, 5,  nameWidth, 20)];
    [bgView addSubview:signLabel];
    signLabel.textColor = [RegularExpressionsMethod ColorWithHexString:BASEPINK];
    signLabel.text = message;
    signLabel.textAlignment = NSTextAlignmentRight;
    signLabel.font = [UIFont systemFontOfSize:13];
    
   
    
    // 在1-60秒下单
    UILabel *scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(signLabel.Right, 5,strSubWidth, 20)];
    scoreLabel.text = stringSub;
    [bgView addSubview:scoreLabel];
    scoreLabel.textColor = kMSCellBackColor;
    scoreLabel.adjustsFontSizeToFitWidth = YES; // 避免尴尬情况
    scoreLabel.font = [UIFont systemFontOfSize:13];
    scoreLabel.textAlignment = NSTextAlignmentCenter;
    
    
    // 去商品详情箭头
    UIImageView *conversionimage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_right.png"]];
    [bgView addSubview:conversionimage];
    conversionimage.frame = CGRectMake(scoreLabel.Right+DCMargin, 5, 20, 20);
    
    UIButton *conversionButton = [[UIButton alloc] initWithFrame:bgView.frame];
    [bgView addSubview:conversionButton];
    conversionButton.backgroundColor = [UIColor clearColor];
    [[conversionButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        checkButtonClickedBlock();
        [bgView removeFromSuperview];
    }];
    [conversionButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    // 2秒后移除toast
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.5 animations:^{
            bgView.alpha = 0;
        } completion:^(BOOL finished) {
            [bgView removeFromSuperview];
        }];
    });
}
@end
