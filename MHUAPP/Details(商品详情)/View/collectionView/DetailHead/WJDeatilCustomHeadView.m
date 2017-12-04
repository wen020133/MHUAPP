//
//  WJDeatilCustomHeadView.m
//  MHUAPP
//
//  Created by jinri on 2017/12/4.
//  Copyright © 2017年 wenchengjun. All rights reserved.
//

#import "WJDeatilCustomHeadView.h"
#import "UIView+UIViewFrame.h"

@implementation WJDeatilCustomHeadView

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
    self.backgroundColor = [UIColor whiteColor];

    _guessMarkLabel = [[UILabel alloc] init];
    _guessMarkLabel.text = @"为你推荐";
    _guessMarkLabel.font = PFR15Font;
    [self addSubview:_guessMarkLabel];

    _guessMarkLabel.frame = CGRectMake(DCMargin, 0, 200, self.height);
    _guessMarkLabel.center = self.center;
}

@end
