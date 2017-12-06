//
//  WJDetailOverFooterView.m
//  MHUAPP
//
//  Created by jinri on 2017/12/5.
//  Copyright © 2017年 wenchengjun. All rights reserved.
//

#import "WJDetailOverFooterView.h"
#import "DCLIRLButton.h"
#import "UIView+UIViewFrame.h"

@interface WJDetailOverFooterView ()

/* 底部上拉提示 */
@property (strong , nonatomic)DCLIRLButton *overMarkButton;

@end

@implementation WJDetailOverFooterView

#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {

    self = [super initWithFrame:frame];
    if (self) {

        [self setUpUI];
    }
    return self;
}

- (void)setUpUI
{
    self.backgroundColor = [RegularExpressionsMethod ColorWithHexString:kMSVCBackgroundColor];
    _overMarkButton = [DCLIRLButton buttonWithType:UIButtonTypeCustom];
    [_overMarkButton setImage:[UIImage imageNamed:@"Details_Btn_Up"] forState:UIControlStateNormal];
    [_overMarkButton setTitle:@"上拉查看图文详情" forState:UIControlStateNormal];
    _overMarkButton.titleLabel.font = PFR12Font;
    [_overMarkButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [self addSubview:_overMarkButton];

    _overMarkButton.frame = CGRectMake(0, 0, self.width, self.height);
}

@end
