//
//  WJShiShiPingTuanCell.m
//  MHUAPP
//
//  Created by jinri on 2018/2/25.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import "WJShiShiPingTuanCell.h"
#import "UIView+UIViewFrame.h"
#define  width_All  kMSScreenWith/2

@interface WJShiShiPingTuanCell ()
/* 便宜好货 */
@property (strong , nonatomic) UIImageView *img_pianyihaohuo;
/* 遇见 */
@property (strong , nonatomic) UIImageView *img_yujian;
/* 热卖卖不停 */
@property (strong , nonatomic) UIImageView *img_remai;
/* 商品1 */
@property (strong , nonatomic) UIImageView *img_shop1;
/* 商品2 */
@property (strong , nonatomic) UIImageView *img_shop2;

@property (strong , nonatomic) UILabel *lab_pianyihaohuo;
@property (strong , nonatomic) UILabel *lab_yujian;
@property (strong , nonatomic) UILabel *lab_remai;
@property (strong , nonatomic) UILabel *lab_shop1;
@property (strong , nonatomic) UILabel *lab_shop2;

@property (strong , nonatomic) UILabel *lab_pingtuan1;
@property (strong , nonatomic) UILabel *lab_pingtuan2;

@end

@implementation WJShiShiPingTuanCell
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
    [self addSubview:line1];

    _img_pianyihaohuo = ImageViewInit(10, 5, width_All/2-15, 85);
    _img_pianyihaohuo.contentMode = UIViewContentModeScaleAspectFit;
    _img_pianyihaohuo.image = [UIImage imageNamed:@"home_snap_img"];
    [self addSubview:_img_pianyihaohuo];

    _lab_pianyihaohuo = LabelInit(width_All/2+10, 5,width_All/2-15, 40);
    _lab_pianyihaohuo.text = @"便宜好货时刻准备着";
    _lab_pianyihaohuo.numberOfLines = 2;
    _lab_pianyihaohuo.font = Font(14);
    _lab_pianyihaohuo.textColor = [RegularExpressionsMethod ColorWithHexString:BASEBLACKCOLOR];
    [self addSubview:_lab_pianyihaohuo];

    UIImageView *line2 = ImageViewInit(8, 100, kMSScreenWith-16, 1);
    line2.backgroundColor = [RegularExpressionsMethod ColorWithHexString:@"E6E6E6"];
    [self addSubview:line2];

    _lab_yujian =LabelInit(5, line2.Bottom+5, width_All/2-5, 20);
    _lab_yujian.text = @"遇见最美的自己";
    _lab_yujian.font = Font(14);
    _lab_yujian.textAlignment = NSTextAlignmentCenter;
    _lab_yujian.textColor = [RegularExpressionsMethod ColorWithHexString:BASEBLACKCOLOR];
    [self addSubview:_lab_yujian];

    _img_yujian = ImageViewInit(10, _lab_yujian.Bottom, width_All/2-15, 55);
    _img_yujian.contentMode = UIViewContentModeScaleAspectFit;
    _img_yujian.image = [UIImage imageNamed:@"home_snap_img"];
    [self addSubview:_img_yujian];

    UIImageView *line3 = ImageViewInit(width_All/2, 100, 1, 95);
    line3.backgroundColor = [RegularExpressionsMethod ColorWithHexString:@"E6E6E6"];
    [self addSubview:line3];



    _lab_remai =LabelInit(width_All/2+5, 105, width_All/2-15, 20);
    _lab_remai.text = @"热卖卖不停";
    _lab_remai.font = Font(14);
    _lab_remai.textAlignment = NSTextAlignmentCenter;
    _lab_remai.textColor = [RegularExpressionsMethod ColorWithHexString:BASEBLACKCOLOR];
    [self addSubview:_lab_remai];

    _img_remai = ImageViewInit(width_All/2+5, _lab_remai.Bottom, width_All/2-15, 55);
    _img_remai.contentMode = UIViewContentModeScaleAspectFit;
    _img_remai.image = [UIImage imageNamed:@"home_snap_img"];
    [self addSubview:_img_remai];

    UIImageView *line4 = ImageViewInit(width_All, 0, 1, 195);
    line4.backgroundColor = [RegularExpressionsMethod ColorWithHexString:@"E6E6E6"];
    [self addSubview:line4];

    _img_shop1 = ImageViewInit(width_All+5, 8, 85, 85);
    _img_shop1.contentMode = UIViewContentModeScaleAspectFit;
    _img_shop1.image = [UIImage imageNamed:@"home_snap_img"];
    [self addSubview:_img_shop1];

    _lab_shop1 =LabelInit(_img_shop1.Right+5, 15, width_All-95, 21);
    _lab_shop1.text = @"大功率家用吹风...";
    _lab_shop1.font = Font(14);
    _lab_shop1.textColor = [RegularExpressionsMethod ColorWithHexString:BASEBLACKCOLOR];
    [self addSubview:_lab_shop1];

    _lab_pingtuan1 =LabelInit(_img_shop1.Right+10, _lab_shop1.Bottom+10, width_All-95, 20);
    _lab_pingtuan1.text = @"拼团人数 968人";
    _lab_pingtuan1.font = Font(13);
    _lab_pingtuan1.textColor = [RegularExpressionsMethod ColorWithHexString:@"707070"];
    [self addSubview:_lab_pingtuan1];

    _img_shop2 = ImageViewInit(width_All+5, 108, 85, 85);
    _img_shop2.contentMode = UIViewContentModeScaleAspectFit;
    _img_shop2.image = [UIImage imageNamed:@"home_snap_img"];
    [self addSubview:_img_shop2];

    _lab_shop2 =LabelInit(_img_shop1.Right+10, 115, width_All-95, 21);
    _lab_shop2.text = @"雷瓦RIWAZ8卷...";
    _lab_shop2.font = Font(14);
    _lab_shop2.textColor = [RegularExpressionsMethod ColorWithHexString:BASEBLACKCOLOR];
    [self addSubview:_lab_shop2];

    _lab_pingtuan2 =LabelInit(_img_shop1.Right+10, _lab_shop2.Bottom+10, width_All-95, 20);
    _lab_pingtuan2.text = @"拼团人数 968人";
    _lab_pingtuan2.font = Font(13);
    _lab_pingtuan2.textColor = [RegularExpressionsMethod ColorWithHexString:@"707070"];
    [self addSubview:_lab_pingtuan2];

}



@end
