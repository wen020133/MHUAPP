//
//  WJCGPFHeaderFeatureView.m
//  MHUAPP
//
//  Created by jinri on 2018/10/8.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import "WJCGPFHeaderFeatureView.h"

@implementation WJCGPFHeaderFeatureView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = kMSCellBackColor;
        [self setupUI];
    }

    return self;
}

- (void)setupUI {

    UILabel *valueLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, kMSScreenWith/2, 24)];
    valueLabel.text = @"商品属性";
    valueLabel.font = [UIFont systemFontOfSize:14];
    valueLabel.textAlignment = NSTextAlignmentCenter;
    valueLabel.textColor = [RegularExpressionsMethod ColorWithHexString:BASEBLACKCOLOR];
    [self addSubview:valueLabel];

    UILabel *numLabel = [[UILabel alloc]initWithFrame:CGRectMake(kMSScreenWith/2, 10, kMSScreenWith/2, 24)];
    numLabel.text = @"数量";
    numLabel.font = [UIFont systemFontOfSize:14];
    numLabel.textAlignment = NSTextAlignmentCenter;
    numLabel.textColor = [RegularExpressionsMethod ColorWithHexString:BASEBLACKCOLOR];
    [self addSubview:numLabel];

}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
