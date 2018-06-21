//
//  WJOrderHeader.m
//  MHUAPP
//
//  Created by jinri on 2017/12/21.
//  Copyright © 2017年 wenchengjun. All rights reserved.
//

#import "WJOrderHeader.h"
// Vendors
#import <UIImageView+WebCache.h>
#import "UIView+UIViewFrame.h"

@implementation WJOrderHeader

-(id)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor clearColor];
        [self setUpInitV];
    }
    return self;
}
-(void)setUpInitV
{
    UIImageView *imaBV = ImageViewInit(0, 8, kMSScreenWith,40);
    imaBV.backgroundColor =kMSCellBackColor;
    [self.contentView addSubview:imaBV];

    UIImageView *line = ImageViewInit(0, 47, kMSScreenWith, 1);
    line.backgroundColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.4];
    [self.contentView addSubview:line];

    self.shangjiaIcon = ImageViewInit(DCMargin, 18, 20, 20);
    self.shangjiaIcon.contentMode = UIViewContentModeScaleAspectFit;
    self.shangjiaIcon.image = [UIImage imageNamed:@"shop_default"];
    [self addSubview:self.shangjiaIcon];

    UILabel *label = [[UILabel alloc]init];
    label.frame = CGRectMake(self.shangjiaIcon.Right+10, 13, kMSScreenWith - 100, 30);
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = [RegularExpressionsMethod ColorWithHexString:BASEBLACKCOLOR];
    [self.contentView addSubview:label];
    self.shangjiaName = label;



    _state = [[UILabel alloc] initWithFrame:CGRectMake(kMSScreenWith-130, 18, 120, 20)];
    _state.textColor = [RegularExpressionsMethod ColorWithHexString:BASEPINK];
    _state.font = [UIFont systemFontOfSize:13];
    _state.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_state];
}

- (void)setShangjiaTitle:(NSString *)shangjiaTitle {
    self.shangjiaName.text = shangjiaTitle;
    _shangjiaTitle = shangjiaTitle;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
