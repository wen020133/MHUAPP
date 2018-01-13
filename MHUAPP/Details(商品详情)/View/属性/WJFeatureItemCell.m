//
//  WJFeatureItemCell.m
//  MHUAPP
//
//  Created by jinri on 2018/1/9.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import "WJFeatureItemCell.h"

@implementation WJFeatureItemCell

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
    _attLabel = [[UILabel alloc] init];
    _attLabel.textAlignment = NSTextAlignmentCenter;
    _attLabel.font = PFR13Font;
    [self addSubview:_attLabel];

}

- (void)layoutSubviews
{
    [super layoutSubviews];

    [_attLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
}


#pragma mark - Setter Getter Methods

- (void)setContent:(WJFeatureList *)content
{
    _content = content;
    _attLabel.text = content.infoname;

    if (content.isSelect) {
        _attLabel.textColor = [UIColor redColor];
        [RegularExpressionsMethod dc_chageControlCircularWith:_attLabel AndSetCornerRadius:5 SetBorderWidth:1 SetBorderColor:[UIColor redColor] canMasksToBounds:YES];
    }else{
        _attLabel.textColor = [UIColor blackColor];
        [RegularExpressionsMethod dc_chageControlCircularWith:_attLabel AndSetCornerRadius:5 SetBorderWidth:1 SetBorderColor:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4] canMasksToBounds:YES];
    }
}

@end
