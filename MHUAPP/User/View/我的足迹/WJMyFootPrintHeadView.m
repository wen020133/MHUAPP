//
//  WJMyFootPrintHeadView.m
//  MHUAPP
//
//  Created by jinri on 2018/6/6.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import "WJMyFootPrintHeadView.h"
#import "UIView+UIViewFrame.h"

@implementation WJMyFootPrintHeadView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUpUI];
    }

    return self;
}

- (void)setUpUI
{
    self.backgroundColor = [RegularExpressionsMethod ColorWithHexString:kMSVCBackgroundColor];

    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font = Font(16);
    _titleLabel.textColor = [RegularExpressionsMethod ColorWithHexString:BASEBLACKCOLOR];
    [self addSubview:_titleLabel];


}

#pragma mark - 布局
- (void)layoutSubviews
{
    [super layoutSubviews];

    _titleLabel.frame = CGRectMake(10, 0, 200, self.height);
}
@end
