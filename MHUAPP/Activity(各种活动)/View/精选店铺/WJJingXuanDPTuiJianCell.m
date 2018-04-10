//
//  WJJingXuanDPTuiJianCell.m
//  MHUAPP
//
//  Created by jinri on 2018/4/9.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import "WJJingXuanDPTuiJianCell.h"
#import "UIView+UIViewFrame.h"
#define  width_All  kMSScreenWith/3


@implementation WJJingXuanDPTuiJianCell

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupCellInit];
    }
    return self;
}

-(void)setupCellInit
{
    self.backgroundColor = kMSCellBackColor;
    
    UILabel *more = LabelInit(kMSScreenWith/2-100, 0, 200, 40);
    more.textColor = [RegularExpressionsMethod ColorWithHexString:BASEBLACKCOLOR];
    more.text = @"一 每日精选 一";
    more.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:more];
    more.font = PFR16Font;
    
    UIImageView *line1 = ImageViewInit(0, 40, kMSScreenWith, 1);
    line1.backgroundColor = [RegularExpressionsMethod ColorWithHexString:@"E6E6E6"];
    [self.contentView addSubview:line1];
    
    _img_shop1 = ImageViewInit(0, 41, width_All, 99);
    _img_shop1.contentMode = UIViewContentModeScaleAspectFit;
    _img_shop1.image = [UIImage imageNamed:@"home_snap_img"];
    [self.contentView addSubview:_img_shop1];
    
    _img_shop2 = ImageViewInit(width_All*2, 41, width_All, 99);
    _img_shop2.contentMode = UIViewContentModeScaleAspectFit;
    _img_shop2.image = [UIImage imageNamed:@"home_snap_img"];
    [self.contentView addSubview:_img_shop2];
    
    UIImageView *imageVB = ImageViewInit(width_All-20, 50, width_All+40, 80);
    imageVB.layer.borderColor = [[RegularExpressionsMethod ColorWithHexString:@"E6E6E6"] CGColor];
    imageVB.layer.borderWidth = 1.0f;
    [self.contentView addSubview:imageVB];
    
    
    _lab_aichaoliu = LabelInit(width_All-20, 70, width_All+40, 20);
    _lab_aichaoliu.text = @"精品优选 春日换新";
    _lab_aichaoliu.textAlignment = NSTextAlignmentCenter;
    _lab_aichaoliu.font = PFR12Font;
    _lab_aichaoliu.textColor = [RegularExpressionsMethod ColorWithHexString:BASEBLACKCOLOR];
    [self.contentView addSubview:_lab_aichaoliu];
    
    UILabel *labchaoliu_mess =LabelInit(width_All-20, 95, width_All/2+20, 20);
    labchaoliu_mess.text = @"全场直降·";
    labchaoliu_mess.font = Font(11);
    labchaoliu_mess.textAlignment = NSTextAlignmentRight;
    labchaoliu_mess.textColor = [RegularExpressionsMethod ColorWithHexString:@"707070"];
    [self.contentView addSubview:labchaoliu_mess];
    
    _lab_youzhihaohuo = LabelInit(kMSScreenWith/2, 95, width_All/2+20, 20);
    _lab_youzhihaohuo.text = @"低至5折";
    _lab_youzhihaohuo.textAlignment = NSTextAlignmentLeft;
    _lab_youzhihaohuo.font = Font(11);
    _lab_youzhihaohuo.textColor = [RegularExpressionsMethod ColorWithHexString:BASEPINK];
    [self.contentView addSubview:_lab_youzhihaohuo];
    
    UIImageView *line2 = ImageViewInit(0, 140, kMSScreenWith, 1);
    line2.backgroundColor = [RegularExpressionsMethod ColorWithHexString:@"E6E6E6"];
    [self.contentView addSubview:line2];
    
    
    _img_shop3 = ImageViewInit(0, 141, width_All, 99);
    _img_shop3.contentMode = UIViewContentModeScaleAspectFit;
    _img_shop3.image = [UIImage imageNamed:@"home_snap_img"];
    [self.contentView addSubview:_img_shop3];

    UIImageView *line3 = ImageViewInit(width_All, 140, 1, 100);
    line3.backgroundColor = [RegularExpressionsMethod ColorWithHexString:@"E6E6E6"];
    [self.contentView addSubview:line3];

    _img_shop4 = ImageViewInit(width_All, 141, width_All, 99);
    _img_shop4.contentMode = UIViewContentModeScaleAspectFit;
    _img_shop4.image = [UIImage imageNamed:@"home_snap_img"];
    [self.contentView addSubview:_img_shop4];

    UIImageView *line4 = ImageViewInit(width_All*2, 140, 1, 100);
    line4.backgroundColor = [RegularExpressionsMethod ColorWithHexString:@"E6E6E6"];
    [self.contentView addSubview:line4];

    _img_shop5 = ImageViewInit(width_All*2, 141, width_All, 99);
    _img_shop5.contentMode = UIViewContentModeScaleAspectFit;
    _img_shop5.image = [UIImage imageNamed:@"home_snap_img"];
    [self.contentView addSubview:_img_shop5];

}



@end
