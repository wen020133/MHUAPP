//
//  WJUnLoginStateTypeView.m
//  MHUAPP
//
//  Created by jinri on 2018/6/25.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import "WJUnLoginStateTypeView.h"
#import "UIView+UIViewFrame.h"

@implementation WJUnLoginStateTypeView

- (id)initWithFrame:(CGRect)frame withContent:(NSString *)str withImage:(NSString *)imageName
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initnoMoredata:str withImageBack:imageName];
    }
    return self;
}
-(void)initnoMoredata:(NSString *)str withImageBack:(NSString *)imageName
{
    UIView *backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kMSScreenWith, kMSScreenHeight - kMSNaviHight-kTabBarHeight)];
    [self addSubview:backgroundView];


    UILabel *warnLabel = [[UILabel alloc]init];
    warnLabel.center = CGPointMake(kMSScreenWith/2.0, backgroundView.height/2.0 - 70);
    warnLabel.bounds = CGRectMake(0, 0, kMSScreenWith, 30);
    warnLabel.textAlignment = NSTextAlignmentCenter;
    warnLabel.text = @"亲，您还没有登录！";
    warnLabel.font = [UIFont systemFontOfSize:16];
    warnLabel.textColor = [RegularExpressionsMethod ColorWithHexString:@"706F6F"];
    [backgroundView addSubview:warnLabel];

    UIButton *goShoppingButton = [[UIButton alloc] init];
    goShoppingButton.center = CGPointMake(kMSScreenWith/2.0, backgroundView.height/2.0 - 10);
    goShoppingButton.bounds = CGRectMake(0, 0, 120, 44);
    [goShoppingButton setTitle:str forState:UIControlStateNormal];
    [goShoppingButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    goShoppingButton.backgroundColor = [RegularExpressionsMethod ColorWithHexString:BASEPINK];
    goShoppingButton.layer.cornerRadius = 5;
    goShoppingButton.clipsToBounds = YES;
    [goShoppingButton addTarget:self action:@selector(gologinBtn) forControlEvents:UIControlEventTouchUpInside];
    [backgroundView addSubview:goShoppingButton];
}
- (void)hide
{
    [self removeFromSuperview];
}
-(void)gologinBtn
{
    !_jumpToLoginPage ? : _jumpToLoginPage();
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
