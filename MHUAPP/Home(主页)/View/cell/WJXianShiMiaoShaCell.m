//
//  WJXianShiMiaoShaCell.m
//  MHUAPP
//
//  Created by jinri on 2018/2/28.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import "WJXianShiMiaoShaCell.h"
#import "UIView+UIViewFrame.h"

@implementation WJXianShiMiaoShaCell
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {

        _grayView = [[UIView alloc]initWithFrame:CGRectMake(4, 0, self.width-8, self.height)];
        _grayView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_grayView];

        _img_content = [[UIImageView alloc]initWithFrame:CGRectMake(0, 2, _grayView.width, _grayView.height-80)];
        _img_content.backgroundColor = kMSCellBackColor;
        _img_content.contentMode = UIViewContentModeScaleAspectFit;
        [_grayView addSubview:_img_content];

        _lab_title = [[UILabel alloc]initWithFrame:CGRectMake(2, _grayView.height-78, _grayView.width-5, 40)];
        _lab_title.font = PFR14Font;
        _lab_title.textColor = [RegularExpressionsMethod ColorWithHexString:BASEBLACKCOLOR];
        _lab_title.numberOfLines = 2;
        _lab_title.textAlignment = NSTextAlignmentLeft;
        [_grayView addSubview:_lab_title];
        
        _hongbaoLabel = LabelInit(self.width-35, _lab_title.Bottom, 30, 15);
        _hongbaoLabel.textColor = kMSCellBackColor;
        _hongbaoLabel.backgroundColor = [RegularExpressionsMethod ColorWithHexString:BASEPINK];
        _hongbaoLabel.font = Font(11);
        _hongbaoLabel.textAlignment = NSTextAlignmentCenter;
        _hongbaoLabel.layer.cornerRadius = 5;
        _hongbaoLabel.layer.masksToBounds = YES;//设置圆角
        _hongbaoLabel.text = @"红包";
        [_grayView addSubview:_hongbaoLabel];


        _oldPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.width-65, _lab_title.Bottom+8, 50, 15)];
        _oldPriceLabel.font = PFR11Font;
        _oldPriceLabel.textAlignment = NSTextAlignmentRight;
        _oldPriceLabel.textColor = [UIColor darkGrayColor];
        [_grayView addSubview:_oldPriceLabel];
        
        _lab_price = [[UILabel alloc]initWithFrame:CGRectMake(2, _lab_title.Bottom, self.width-45, 23)];
        _lab_price.font = PFR15Font;
        _lab_price.textColor = [RegularExpressionsMethod ColorWithHexString:BASEPINK];
        _lab_price.textAlignment = NSTextAlignmentLeft;
        [_grayView addSubview:_lab_price];

        _lab_count = [[UILabel alloc]initWithFrame:CGRectMake(2, _oldPriceLabel.Bottom, self.width-15, 20)];
        _lab_count.font = PFR12Font;
        _lab_count.textColor = [RegularExpressionsMethod ColorWithHexString:BASELITTLEBLACKCOLOR];
        _lab_count.textAlignment = NSTextAlignmentLeft;
        [_grayView addSubview:_lab_count];
        
        

    }
    return self;
}


@end
