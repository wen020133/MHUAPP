//
//  WJZhuanTiHDBenZhouZuiLXCell.m
//  MHUAPP
//
//  Created by jinri on 2018/3/29.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import "WJZhuanTiHDBenZhouZuiLXCell.h"
#import "UIView+UIViewFrame.h"

#define  width_meiri  kMSScreenWith*0.55
#define  width_baokuan  kMSScreenWith*0.45

@implementation WJZhuanTiHDBenZhouZuiLXCell
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


    _img_top = ImageViewInit(10, 0, kMSScreenWith-20, 100);
    _img_top.contentMode = UIViewContentModeScaleAspectFill;
    _img_top.image = [UIImage imageNamed:@"main_sspt_haowuyiqipin.jpg"];
    [self.contentView addSubview:_img_top];

    UILabel *labmeiribiqiang = LabelInit(10, 105, width_meiri/2-12, 20);
    labmeiribiqiang.text = @"潮流换新";
    labmeiribiqiang.font = Font(16);
    labmeiribiqiang.textColor = [RegularExpressionsMethod ColorWithHexString:@"B200B3"];
    [self.contentView addSubview:labmeiribiqiang];

    UILabel *labmeiri_mess =LabelInit(10, labmeiribiqiang.Bottom, width_meiri/2-12, 18);
    labmeiri_mess.text = @"BB气垫遮瑕";
    labmeiri_mess.font = Font(12);
    labmeiri_mess.textColor = [RegularExpressionsMethod ColorWithHexString:@"707070"];
    [self.contentView addSubview:labmeiri_mess];

    _img_chaoliuhuanxin = ImageViewInit(10, labmeiri_mess.Bottom+2, width_meiri/2-16, 50);
    _img_chaoliuhuanxin.contentMode = UIViewContentModeScaleAspectFit;
    _img_chaoliuhuanxin.image = [UIImage imageNamed:@"home_snap_img"];
    [self.contentView addSubview:_img_chaoliuhuanxin];

    UIImageView *line1 = ImageViewInit(width_meiri/2, 100, 1, 200);
    line1.backgroundColor = [RegularExpressionsMethod ColorWithHexString:@"E6E6E6"];
    [self.contentView addSubview:line1];

    UILabel *labbaokuan =LabelInit(width_meiri/2+5, 105, width_meiri/2-10, 20);
    labbaokuan.text = @"美妆达人";
    labbaokuan.font = Font(16);
    labbaokuan.textColor = [RegularExpressionsMethod ColorWithHexString:@"6515CF"];
    [self.contentView addSubview:labbaokuan];

    UILabel *labbaokuan_mess =LabelInit(width_meiri/2+5, labbaokuan.Bottom, width_meiri/2-10, 18);
    labbaokuan_mess.text = @"眉毛贴画眉";
    labbaokuan_mess.font = Font(12);
    labbaokuan_mess.textColor = [RegularExpressionsMethod ColorWithHexString:@"707070"];
    [self.contentView addSubview:labbaokuan_mess];

    _img_meizhuangdaren = ImageViewInit(width_meiri/2+5, labbaokuan_mess.Bottom+2, width_meiri/2-16, 50);
    _img_meizhuangdaren.contentMode = UIViewContentModeScaleAspectFit;
    _img_meizhuangdaren.image = [UIImage imageNamed:@"home_selling_img"];
    [self.contentView addSubview:_img_meizhuangdaren];

    UIImageView *line2 = ImageViewInit(width_meiri, 100, 1, 200);
    line2.backgroundColor = [RegularExpressionsMethod ColorWithHexString:@"E6E6E6"];
    [self addSubview:line2];

    UIImageView *line3 = ImageViewInit(0, 200, kMSScreenWith, 1);
    line3.backgroundColor = [RegularExpressionsMethod ColorWithHexString:@"E6E6E6"];
    [self addSubview:line3];

    UILabel *labchaoliu =LabelInit(width_meiri+5, 105, width_baokuan/2-15, 20);
    labchaoliu.text = @"保湿套装";
    labchaoliu.font = Font(16);
    labchaoliu.textColor = [RegularExpressionsMethod ColorWithHexString:@"DD3191"];
    [self addSubview:labchaoliu];

    UILabel *labchaoliu_mess =LabelInit(width_meiri+5, labchaoliu.Bottom, width_baokuan/2-15, 18);
    labchaoliu_mess.text = @"呵护肌肤";
    labchaoliu_mess.font = Font(12);
    labchaoliu_mess.textColor = [RegularExpressionsMethod ColorWithHexString:@"707070"];
    [self addSubview:labchaoliu_mess];

    _img_baoshitaozhuang = ImageViewInit(width_meiri+5, labchaoliu_mess.Bottom+2,width_baokuan/2-15, 50);
    _img_baoshitaozhuang.contentMode = UIViewContentModeScaleAspectFit;
    _img_baoshitaozhuang.image = [UIImage imageNamed:@"home_trend_img"];
    [self addSubview:_img_baoshitaozhuang];

    UIImageView *line4 = ImageViewInit(width_meiri+width_baokuan/2-5, 100, 1, 100);
    line4.backgroundColor = [RegularExpressionsMethod ColorWithHexString:@"E6E6E6"];
    [self addSubview:line4];

    UILabel *labshishang =LabelInit(width_meiri+width_baokuan/2, 105, width_baokuan/2-15, 20);
    labshishang.text = @"传奇今生";
    labshishang.font = Font(16);
    labshishang.textColor = [RegularExpressionsMethod ColorWithHexString:@"F16233"];
    [self addSubview:labshishang];

    UILabel *labshishang_mess =LabelInit(width_meiri+width_baokuan/2, labshishang.Bottom, width_baokuan/2-15, 18);
    labshishang_mess.text = @"千人千色";
    labshishang_mess.font = Font(12);
    labshishang_mess.textColor = [RegularExpressionsMethod ColorWithHexString:@"707070"];
    [self addSubview:labshishang_mess];

    _img_chuanqijinsheng = ImageViewInit(width_meiri+width_baokuan/2, labshishang_mess.Bottom+2, width_baokuan/2-15, 40);
    _img_chuanqijinsheng.contentMode = UIViewContentModeScaleAspectFit;
    _img_chuanqijinsheng.image = [UIImage imageNamed:@"home_brand_img"];
    [self addSubview:_img_chuanqijinsheng];


    UILabel *labmeironyi = LabelInit(10, 205, width_meiri/2-12, 20);
    labmeironyi.text = @"美容仪";
    labmeironyi.font = Font(16);
    labmeironyi.textColor = [RegularExpressionsMethod ColorWithHexString:@"158BD6"];
    [self.contentView addSubview:labmeironyi];

    UILabel *labmeironyi_mess =LabelInit(10, labmeironyi.Bottom, width_meiri/2-12, 18);
    labmeironyi_mess.text = @"无暇美肌";
    labmeironyi_mess.font = Font(12);
    labmeironyi_mess.textColor = [RegularExpressionsMethod ColorWithHexString:@"707070"];
    [self.contentView addSubview:labmeironyi_mess];

    _img_meirongyi = ImageViewInit(10, labmeironyi_mess.Bottom+2, width_meiri/2-16, 50);
    _img_meirongyi.contentMode = UIViewContentModeScaleAspectFit;
    _img_meirongyi.image = [UIImage imageNamed:@"home_snap_img"];
    [self.contentView addSubview:_img_meirongyi];

    UILabel *lab_ifashion =LabelInit(width_meiri/2+5, 205, width_meiri/2-10, 20);
    lab_ifashion.text = @"IFASHION";
    lab_ifashion.font = Font(16);
    lab_ifashion.textColor = [RegularExpressionsMethod ColorWithHexString:@"F16233"];
    [self.contentView addSubview:lab_ifashion];

    UILabel *labifashion_mess =LabelInit(width_meiri/2+5, lab_ifashion.Bottom, width_meiri/2-10, 18);
    labifashion_mess.text = @"有范有风尚";
    labifashion_mess.font = Font(12);
    labifashion_mess.textColor = [RegularExpressionsMethod ColorWithHexString:@"707070"];
    [self.contentView addSubview:labifashion_mess];

    _img_IFASHION = ImageViewInit(width_meiri/2+5, labbaokuan_mess.Bottom+2, width_meiri/2-16, 50);
    _img_IFASHION.contentMode = UIViewContentModeScaleAspectFit;
    _img_IFASHION.image = [UIImage imageNamed:@"home_selling_img"];
    [self.contentView addSubview:_img_IFASHION];

    UILabel *labzhuanyemeifa =LabelInit(width_meiri+5, 105, width_baokuan-40, 20);
    labzhuanyemeifa.text = @"专业美发";
    labzhuanyemeifa.font = Font(16);
    labzhuanyemeifa.textColor = [RegularExpressionsMethod ColorWithHexString:@"CF17AA"];
    [self addSubview:labzhuanyemeifa];

    UILabel *labzhuanyemeifa_mess =LabelInit(width_meiri+5, labzhuanyemeifa.Bottom, width_baokuan-40, 18);
    labzhuanyemeifa_mess.text = @"美丽加油站";
    labzhuanyemeifa_mess.font = Font(12);
    labzhuanyemeifa_mess.textColor = [RegularExpressionsMethod ColorWithHexString:@"707070"];
    [self addSubview:labzhuanyemeifa_mess];

    _img_zhuanyemeifa = ImageViewInit(width_meiri+5, labzhuanyemeifa_mess.Bottom+2,width_baokuan-40, 50);
    _img_zhuanyemeifa.contentMode = UIViewContentModeScaleAspectFit;
    _img_zhuanyemeifa.image = [UIImage imageNamed:@"home_trend_img"];
    [self addSubview:_img_zhuanyemeifa];

}
@end
