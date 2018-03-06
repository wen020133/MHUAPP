//
//  WJPeopleTuiJianCell.m
//  MHUAPP
//
//  Created by jinri on 2018/2/25.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import "WJPeopleTuiJianCell.h"
#import "UIView+UIViewFrame.h"
#import "UIButton+LZCategory.h"

#define  width_first  kMSScreenWith*0.32   //height 250
#define Cell_height 250
@implementation WJPeopleTuiJianCell


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
    self.backgroundColor = kMSCellBackColor;


    UIButton *right1 = [UIButton buttonWithType:UIButtonTypeCustom];
    right1.titleLabel.font = PFR14Font;
    right1.frame = CGRectMake(width_first-60, 3, 55, 21);
    [right1 setImage:[UIImage imageNamed:@"home_sentiment01_icon"] forState:UIControlStateNormal];
    [right1 setTitleColor:[RegularExpressionsMethod ColorWithHexString:@"#FF0000"] forState:UIControlStateNormal];
    [right1 setTitle:@"人气值 " forState:UIControlStateNormal];
    [right1 setbuttonType:LZCategoryTypeLeft];
    [self addSubview:right1];

    _img_first = ImageViewInit(10, right1.Bottom+5, width_first-15, Cell_height-right1.Bottom-15);
    _img_first.contentMode = UIViewContentModeScaleAspectFit;
    _img_first.image = [UIImage imageNamed:@"home_snap_img"];
    [self addSubview:_img_first];

    UIImageView *line1 = ImageViewInit(width_first, 0, 1, Cell_height-5);
    line1.backgroundColor = [RegularExpressionsMethod ColorWithHexString:@"E6E6E6"];
    [self addSubview:line1];

    _img_second = ImageViewInit(width_first+5, 3,kMSScreenWith-width_first-75, 90);
    _img_second.contentMode = UIViewContentModeScaleAspectFit;
    _img_second.image = [UIImage imageNamed:@"home_sentiment02_img"];
    [self addSubview:_img_second];

    UIButton *right2 = [UIButton buttonWithType:UIButtonTypeCustom];
    right2.titleLabel.font = PFR14Font;
    right2.frame = CGRectMake(_img_second.Right, 3, 55, 21);
    right2.titleLabel.textAlignment = NSTextAlignmentLeft;
    [right2 setImage:[UIImage imageNamed:@"home_sentiment01_icon"] forState:UIControlStateNormal];
    [right2 setTitleColor:[RegularExpressionsMethod ColorWithHexString:@"#FF0000"] forState:UIControlStateNormal];
    [right2 setTitle:@"人气值 " forState:UIControlStateNormal];
     [right2 setbuttonType:LZCategoryTypeLeft];
    [self addSubview:right2];

    UIImageView *line2 = ImageViewInit(width_first, 99, kMSScreenWith-width_first-10, 1);
    line2.backgroundColor = [RegularExpressionsMethod ColorWithHexString:@"E6E6E6"];
    [self addSubview:line2];



    UIImageView *line3 = ImageViewInit(width_first+(kMSScreenWith-10-width_first)/2, 100, 1, Cell_height-105);
    line3.backgroundColor = [RegularExpressionsMethod ColorWithHexString:@"E6E6E6"];
    [self addSubview:line3];

    _img_third = ImageViewInit(width_first+5, line2.Bottom+ 26,(kMSScreenWith-10-width_first)/2-10, 117);
    _img_third.contentMode = UIViewContentModeScaleAspectFit;
    _img_third.image = [UIImage imageNamed:@"home_snap_img"];
    [self addSubview:_img_third];

    UIButton *right3 = [UIButton buttonWithType:UIButtonTypeCustom];
    right3.titleLabel.font = PFR14Font;
    right3.frame = CGRectMake(width_first+(kMSScreenWith-10-width_first)/2-60, line2.Bottom+3, 55, 21);
    [right3 setImage:[UIImage imageNamed:@"home_sentiment01_icon"] forState:UIControlStateNormal];
    [right3 setTitleColor:[RegularExpressionsMethod ColorWithHexString:@"#FF0000"] forState:UIControlStateNormal];
    [right3 setTitle:@"人气值 " forState:UIControlStateNormal];
    [right3 setbuttonType:LZCategoryTypeLeft];
    [self addSubview:right3];



    _img_fourth = ImageViewInit(line3.Right+5, line2.Bottom+ 26,(kMSScreenWith-10-width_first)/2-10, 117);
    _img_fourth.contentMode = UIViewContentModeScaleAspectFit;
    _img_fourth.image = [UIImage imageNamed:@"home_snap_img"];
    [self addSubview:_img_fourth];


    UIButton *right4 = [UIButton buttonWithType:UIButtonTypeCustom];
    right4.titleLabel.font = PFR14Font;
    right4.frame = CGRectMake(kMSScreenWith-70, line2.Bottom+3, 55, 21);
    [right4 setImage:[UIImage imageNamed:@"home_sentiment01_icon"] forState:UIControlStateNormal];
    [right4 setTitleColor:[RegularExpressionsMethod ColorWithHexString:@"#FF0000"] forState:UIControlStateNormal];
    [right4 setTitle:@"人气值 " forState:UIControlStateNormal];
     [right4 setbuttonType:LZCategoryTypeLeft];
    [self addSubview:right4];
}
@end
