//
//  WJBrandsSortHeadView.m
//  MHUAPP
//
//  Created by jinri on 2017/11/30.
//  Copyright © 2017年 wenchengjun. All rights reserved.
//

#import "WJBrandsSortHeadView.h"
#import "UIView+UIViewFrame.h"

@implementation WJBrandsSortHeadView

#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {

    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUI];
    }
    return self;
}
#pragma mark - UI
- (void)setUpUI
{
    _headLabel = [[UILabel alloc] init];
    _headLabel.font = PFR14Font;
    _headLabel.textColor = [UIColor blackColor];
    [self addSubview:_headLabel];

    _headLabel.frame = CGRectMake(DCMargin, 0, self.width, self.height);
}



@end
