//
//  WJZhuanTiHDXinPinCell.m
//  MHUAPP
//
//  Created by jinri on 2018/3/29.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import "WJZhuanTiHDXinPinCell.h"
#import "UIView+UIViewFrame.h"
#define  width_All  kMSScreenWith/2

@interface WJZhuanTiHDXinPinCell ()
/* 爱潮流 */
@property (strong , nonatomic) UIImageView *img_aichaoliu1;
@property (strong , nonatomic) UIImageView *img_aichaoliu2;
/* 优质好货 */
@property (strong , nonatomic) UIImageView *img_youzhihaohuo1;
@property (strong , nonatomic) UIImageView *img_youzhihaohuo2;
/* 爱逛街 */
@property (strong , nonatomic) UIImageView *img_aiguangjie1;
@property (strong , nonatomic) UIImageView *img_aiguangjie2;
/* 女神范 */
@property (strong , nonatomic) UIImageView *img_nvshenfan;
/* 精致 */
@property (strong , nonatomic) UIImageView *img_jingzhi;

@property (strong , nonatomic) UILabel *lab_aichaoliu;
@property (strong , nonatomic) UILabel *lab_youzhihaohuo;
@property (strong , nonatomic) UILabel *lab_aiguangjie;
@property (strong , nonatomic) UILabel *lab_nvshenfan;
@property (strong , nonatomic) UILabel *lab_jingzhi;


@end

@implementation WJZhuanTiHDXinPinCell

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

    UIImageView *line1 = ImageViewInit(0, 0, kMSScreenWith, 1);
    line1.backgroundColor = [RegularExpressionsMethod ColorWithHexString:@"E6E6E6"];
    [self.contentView addSubview:line1];

    _lab_aichaoliu = LabelInit(10, 3,width_All-20, 20);
    _lab_aichaoliu.text = @"爱潮流";
    _lab_aichaoliu.font = PFR16Font;
    _lab_aichaoliu.textColor = [RegularExpressionsMethod ColorWithHexString:@"ED2B55"];
    [self.contentView addSubview:_lab_aichaoliu];

    UILabel *labchaoliu_mess =LabelInit(10, _lab_aichaoliu.Bottom, width_All-20, 18);
    labchaoliu_mess.text = @"正品好货 一件八折";
    labchaoliu_mess.font = Font(12);
    labchaoliu_mess.textColor = [RegularExpressionsMethod ColorWithHexString:@"707070"];
    [self.contentView addSubview:labchaoliu_mess];

    _img_aichaoliu1 = ImageViewInit(15, labchaoliu_mess.Bottom+2, width_All/2-20, 50);
    _img_aichaoliu1.contentMode = UIViewContentModeScaleAspectFit;
    _img_aichaoliu1.image = [UIImage imageNamed:@"home_snap_img"];
    [self.contentView addSubview:_img_aichaoliu1];

    _img_aichaoliu2 = ImageViewInit(_img_aichaoliu1.Right+5, labchaoliu_mess.Bottom+2, width_All/2-20, 50);
    _img_aichaoliu2.contentMode = UIViewContentModeScaleAspectFit;
    _img_aichaoliu2.image = [UIImage imageNamed:@"home_snap_img"];
    [self.contentView addSubview:_img_aichaoliu2];

    UIImageView *line2 = ImageViewInit(0, 100, kMSScreenWith, 1);
    line2.backgroundColor = [RegularExpressionsMethod ColorWithHexString:@"E6E6E6"];
    [self.contentView addSubview:line2];

    UIImageView *line3 = ImageViewInit(width_All, 0, 1, 200);
    line3.backgroundColor = [RegularExpressionsMethod ColorWithHexString:@"E6E6E6"];
    [self.contentView addSubview:line3];

    _lab_youzhihaohuo =LabelInit(width_All+10, 3, width_All-20, 20);
    _lab_youzhihaohuo.text = @"优质好货";
    _lab_youzhihaohuo.font = PFR16Font;
    _lab_youzhihaohuo.textAlignment = NSTextAlignmentLeft;
    _lab_youzhihaohuo.textColor = [RegularExpressionsMethod ColorWithHexString:@"F16233"];
    [self.contentView addSubview:_lab_youzhihaohuo];

    UILabel *labyouzhi_mess =LabelInit(width_All+10, _lab_youzhihaohuo.Bottom, width_All-20, 18);
    labyouzhi_mess.text = @"高颜值 好品质美物";
    labyouzhi_mess.font = Font(12);
    labyouzhi_mess.textColor = [RegularExpressionsMethod ColorWithHexString:@"707070"];
    [self.contentView addSubview:labyouzhi_mess];

    _img_youzhihaohuo1 = ImageViewInit(width_All+15, labyouzhi_mess.Bottom+2, width_All/2-20, 50);
    _img_youzhihaohuo1.contentMode = UIViewContentModeScaleAspectFit;
    _img_youzhihaohuo1.image = [UIImage imageNamed:@"home_snap_img"];
    [self.contentView addSubview:_img_youzhihaohuo1];

    _img_youzhihaohuo2 = ImageViewInit(_img_youzhihaohuo1.Right+5, labyouzhi_mess.Bottom+2, width_All/2-20, 50);
    _img_youzhihaohuo2.contentMode = UIViewContentModeScaleAspectFit;
    _img_youzhihaohuo2.image = [UIImage imageNamed:@"home_snap_img"];
    [self.contentView addSubview:_img_youzhihaohuo2];


    _lab_aiguangjie = LabelInit(10, 103,width_All-20, 20);
    _lab_aiguangjie.text = @"爱逛街";
    _lab_aiguangjie.font = PFR16Font;
    _lab_aiguangjie.textColor = [RegularExpressionsMethod ColorWithHexString:@"EF73D1"];
    [self.contentView addSubview:_lab_aiguangjie];

    UILabel *labaiguangjie_mess =LabelInit(10, _lab_aiguangjie.Bottom, width_All-20, 18);
    labaiguangjie_mess.text = @"优惠GO 满199减50";
    labaiguangjie_mess.font = Font(12);
    labaiguangjie_mess.textColor = [RegularExpressionsMethod ColorWithHexString:@"707070"];
    [self.contentView addSubview:labaiguangjie_mess];

    _img_aiguangjie1 = ImageViewInit(15, labaiguangjie_mess.Bottom+2, width_All/2-20, 50);
    _img_aiguangjie1.contentMode = UIViewContentModeScaleAspectFit;
    _img_aiguangjie1.image = [UIImage imageNamed:@"home_snap_img"];
    [self.contentView addSubview:_img_aiguangjie1];

    _img_aiguangjie2 = ImageViewInit(_img_aiguangjie1.Right+5, labaiguangjie_mess.Bottom+2, width_All/2-20, 50);
    _img_aiguangjie2.contentMode = UIViewContentModeScaleAspectFit;
    _img_aiguangjie2.image = [UIImage imageNamed:@"home_snap_img"];
    [self.contentView addSubview:_img_aiguangjie2];

    UIImageView *line4 = ImageViewInit(width_All*1.5, 100, 1, 100);
    line4.backgroundColor = [RegularExpressionsMethod ColorWithHexString:@"E6E6E6"];
    [self.contentView addSubview:line4];

    _lab_nvshenfan = LabelInit(width_All+10, 103,width_All/2-20, 20);
    _lab_nvshenfan.text = @"女神范";
    _lab_nvshenfan.font = PFR16Font;
    _lab_nvshenfan.textColor = [RegularExpressionsMethod ColorWithHexString:@"23A0E8"];
    [self.contentView addSubview:_lab_nvshenfan];

    UILabel *labnvshenfan_mess =LabelInit(width_All+10, _lab_nvshenfan.Bottom, width_All/2-20, 18);
    labnvshenfan_mess.text = @"神仙水套装";
    labnvshenfan_mess.font = Font(12);
    labnvshenfan_mess.textColor = [RegularExpressionsMethod ColorWithHexString:@"707070"];
    [self.contentView addSubview:labnvshenfan_mess];

    _img_nvshenfan = ImageViewInit(width_All+15, labnvshenfan_mess.Bottom+2, width_All/2-20, 50);
    _img_nvshenfan.contentMode = UIViewContentModeScaleAspectFit;
    _img_nvshenfan.image = [UIImage imageNamed:@"home_snap_img"];
    [self.contentView addSubview:_img_nvshenfan];

    _lab_jingzhi = LabelInit(width_All*1.5+10, 103,width_All/2-20, 20);
    _lab_jingzhi.text = @"精致有格";
    _lab_jingzhi.font = PFR16Font;
    _lab_jingzhi.textColor = [RegularExpressionsMethod ColorWithHexString:@"23A0E8"];
    [self.contentView addSubview:_lab_jingzhi];

    UILabel *labjinzhi_mess =LabelInit(width_All*1.5+10, _lab_jingzhi.Bottom, width_All/2-20, 18);
    labjinzhi_mess.text = @"魅力美甲";
    labjinzhi_mess.font = Font(12);
    labjinzhi_mess.textColor = [RegularExpressionsMethod ColorWithHexString:@"707070"];
    [self.contentView addSubview:labjinzhi_mess];

    _img_nvshenfan = ImageViewInit(width_All*1.5+15, labjinzhi_mess.Bottom+2, width_All/2-20, 50);
    _img_nvshenfan.contentMode = UIViewContentModeScaleAspectFit;
    _img_nvshenfan.image = [UIImage imageNamed:@"home_snap_img"];
    [self.contentView addSubview:_img_nvshenfan];
}

@end
