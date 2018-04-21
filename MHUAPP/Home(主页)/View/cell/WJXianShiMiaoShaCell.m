//
//  WJXianShiMiaoShaCell.m
//  MHUAPP
//
//  Created by jinri on 2018/2/28.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import "WJXianShiMiaoShaCell.h"
#import "UIView+UIViewFrame.h"
#import <UIImageView+WebCache.h>

@implementation WJXianShiMiaoShaCell
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {

        _grayView = [[UIView alloc]initWithFrame:CGRectMake(4, 0, self.width-8, self.height)];
        _grayView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_grayView];

        _img_content = [[UIImageView alloc]initWithFrame:CGRectMake(0, 2, _grayView.width, _grayView.height-70)];
        _img_content.backgroundColor = kMSCellBackColor;
        _img_content.contentMode = UIViewContentModeScaleAspectFit;
        [_grayView addSubview:_img_content];

        _lab_title = [[UILabel alloc]initWithFrame:CGRectMake(10, _grayView.height-71, _grayView.width-20, 21)];
        _lab_title.font = PFR14Font;
        _lab_title.textColor = [RegularExpressionsMethod ColorWithHexString:BASEBLACKCOLOR];
        _lab_title.textAlignment = NSTextAlignmentLeft;
        [_grayView addSubview:_lab_title];

        _lab_price = [[UILabel alloc]initWithFrame:CGRectMake(10, _lab_title.Bottom+2, self.width-45, 23)];
        _lab_price.font = PFR15Font;
        _lab_price.textColor = [RegularExpressionsMethod ColorWithHexString:BASEPINK];
        _lab_price.textAlignment = NSTextAlignmentLeft;
        [_grayView addSubview:_lab_price];

        _oldPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.width-65, _lab_title.Bottom+2, 60, 23)];
        _oldPriceLabel.font = PFR11Font;
        _oldPriceLabel.textAlignment = NSTextAlignmentRight;
        _oldPriceLabel.textColor = [UIColor darkGrayColor];
        [_grayView addSubview:_oldPriceLabel];

        _lab_count = [[UILabel alloc]initWithFrame:CGRectMake(10, _lab_price.Bottom+2, self.width-15, 20)];
        _lab_count.font = PFR12Font;
        _lab_count.textColor = [RegularExpressionsMethod ColorWithHexString:BASELITTLEBLACKCOLOR];
        _lab_count.textAlignment = NSTextAlignmentLeft;
        [_grayView addSubview:_lab_count];

    }
    return self;
}


@end
