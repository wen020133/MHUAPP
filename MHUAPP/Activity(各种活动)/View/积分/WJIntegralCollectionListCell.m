//
//  WJIntegralCollectionListCell.m
//  MHUAPP
//
//  Created by jinri on 2018/5/15.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import "WJIntegralCollectionListCell.h"

@implementation WJIntegralCollectionListCell


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

    UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kMSScreenWith, 1)];
    line.backgroundColor = [RegularExpressionsMethod ColorWithHexString:@"E6E6E6"];
    [self addSubview:line];


    _lab_content = [[UILabel alloc] initWithFrame:CGRectMake(DCMargin, 10, kMSScreenWith-40, 24)];
    _lab_content.font = PFR14Font;
    _lab_content.textColor = [RegularExpressionsMethod ColorWithHexString:BASELITTLEBLACKCOLOR];
    [self addSubview:_lab_content];

}

@end
