//
//  WJZhuanTiHDGridFootView.m
//  MHUAPP
//
//  Created by jinri on 2018/4/2.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import "WJZhuanTiHDGridFootView.h"
#import "UIView+UIViewFrame.h"

#define  width_meiri  kMSScreenWith*0.3


@implementation WJZhuanTiHDGridFootView
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

    UIImageView  *imagefirst= ImageViewInit(10, 0, kMSScreenWith-width_meiri-20, 40);
//    imagefirst.contentMode = UIViewContentModeScaleAspectFit;
    imagefirst.image = [UIImage imageNamed:@"zthd_manjian"];
    [self addSubview:imagefirst];

    UIButton  *btn_second= [UIButton buttonWithType:UIButtonTypeCustom];
    btn_second.frame = CGRectMake(kMSScreenWith-width_meiri-10, 0,width_meiri, 40);
    [btn_second setBackgroundImage:[UIImage imageNamed:@"zthd_lijigoumai"] forState:UIControlStateNormal];
    [btn_second setTitle:@"立即领取" forState:UIControlStateNormal];
    [self addSubview:btn_second];


    UILabel *labmeiribiqiang = LabelInit(10, 0, kMSScreenWith-width_meiri-20-100, 40);
    labmeiribiqiang.text = @"满199减50";
    labmeiribiqiang.font = Font(18);
    labmeiribiqiang.textAlignment = NSTextAlignmentCenter;
    labmeiribiqiang.textColor = [RegularExpressionsMethod ColorWithHexString:@"FFFF00"];
    [self addSubview:labmeiribiqiang];

    UILabel *lab_type =LabelInit(labmeiribiqiang.Right, 0,100, 40);
    lab_type.text = @"全场类目";
    lab_type.font = Font(18);
    lab_type.textColor = kMSCellBackColor;
    labmeiribiqiang.textAlignment = NSTextAlignmentCenter;
    [self addSubview:lab_type];

}

- (void)crossButtonClick
{
    !_newToGetYouhuiquan ?: _newToGetYouhuiquan();
}

@end
