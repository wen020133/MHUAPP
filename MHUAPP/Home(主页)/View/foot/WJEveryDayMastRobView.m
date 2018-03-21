//
//  WJEveryDayMastRobView.m
//  MHUAPP
//
//  Created by wenchengjun on 2018/2/24.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import "WJEveryDayMastRobView.h"
#import "UIView+UIViewFrame.h"

#define  width_meiri  kMSScreenWith*0.32
#define  width_baokuan  kMSScreenWith*0.25
#define  width_chaoliu  kMSScreenWith*0.43

@interface WJEveryDayMastRobView ()
/* 每日必抢 */
@property (strong , nonatomic) UIImageView *img_meiribiqiang;
/* 爆款热卖 */
@property (strong , nonatomic) UIImageView *img_baokuan;
/* 潮流精选 */
@property (strong , nonatomic) UIImageView *img_chaoliu;
/* 时尚大牌 */
@property (strong , nonatomic) UIImageView *img_shishang;
/* 新品首发 */
@property (strong , nonatomic) UIImageView *img_xinpin;
/* 好货不断 */
@property (strong , nonatomic) UIImageView *img_haohuo;

@end


@implementation WJEveryDayMastRobView

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
    
    UILabel *labmeiribiqiang = LabelInit(10, 5, width_meiri-12, 21);
    labmeiribiqiang.text = @"每日必抢";
    labmeiribiqiang.font = Font(16);
    labmeiribiqiang.textColor = [RegularExpressionsMethod ColorWithHexString:@"EE0000"];
    [self addSubview:labmeiribiqiang];
    
    UILabel *labmeiri_mess =LabelInit(10, labmeiribiqiang.Bottom, width_meiri-12, 20);
    labmeiri_mess.text = @"天天惠";
    labmeiri_mess.font = Font(12);
    labmeiri_mess.textColor = [RegularExpressionsMethod ColorWithHexString:@"707070"];
    [self addSubview:labmeiri_mess];
    
    _img_meiribiqiang = ImageViewInit(10, labmeiri_mess.Bottom+5, width_meiri-12, 130);
    _img_meiribiqiang.contentMode = UIViewContentModeScaleAspectFit;
    _img_meiribiqiang.image = [UIImage imageNamed:@"home_snap_img"];
    [self addSubview:_img_meiribiqiang];
    
    UIImageView *line1 = ImageViewInit(width_meiri, 3, 1, 193);
    line1.backgroundColor = [RegularExpressionsMethod ColorWithHexString:@"E6E6E6"];
    [self addSubview:line1];
    
    UILabel *labbaokuan =LabelInit(width_meiri+5, 5, width_baokuan-7, 21);
    labbaokuan.text = @"爆款热卖";
    labbaokuan.font = Font(16);
    labbaokuan.textColor = [RegularExpressionsMethod ColorWithHexString:@"CC66FF"];
    [self addSubview:labbaokuan];
    
    UILabel *labbaokuan_mess =LabelInit(width_meiri+5, labbaokuan.Bottom, width_baokuan-7, 20);
    labbaokuan_mess.text = @"限时抢";
    labbaokuan_mess.font = Font(12);
    labbaokuan_mess.textColor = [RegularExpressionsMethod ColorWithHexString:@"707070"];
    [self addSubview:labbaokuan_mess];
    
    _img_baokuan = ImageViewInit(width_meiri+5, labbaokuan_mess.Bottom+5, width_baokuan-7, 40);
    _img_baokuan.contentMode = UIViewContentModeScaleAspectFit;
    _img_baokuan.image = [UIImage imageNamed:@"home_selling_img"];
    [self addSubview:_img_baokuan];
    
    UIImageView *line2 = ImageViewInit(width_meiri, 100, kMSScreenWith-width_meiri-5, 1);
    line2.backgroundColor = [RegularExpressionsMethod ColorWithHexString:@"E6E6E6"];
    [self addSubview:line2];
    
    UIImageView *line3 = ImageViewInit(kMSScreenWith-width_chaoliu-2, 3, 1, 193);
    line3.backgroundColor = [RegularExpressionsMethod ColorWithHexString:@"E6E6E6"];
    [self addSubview:line3];
    
    UILabel *labchaoliu =LabelInit(kMSScreenWith-width_chaoliu+2, 5, width_chaoliu/2-2, 21);
    labchaoliu.text = @"潮流精选";
    labchaoliu.font = Font(16);
    labchaoliu.textColor = [RegularExpressionsMethod ColorWithHexString:@"FF5D5B"];
    [self addSubview:labchaoliu];
    
    UILabel *labchaoliu_mess =LabelInit(kMSScreenWith-width_chaoliu+2, labchaoliu.Bottom, width_chaoliu/2-7, 20);
    labchaoliu_mess.text = @"随时GO";
    labchaoliu_mess.font = Font(12);
    labchaoliu_mess.textColor = [RegularExpressionsMethod ColorWithHexString:@"707070"];
    [self addSubview:labchaoliu_mess];
    
    _img_chaoliu = ImageViewInit(kMSScreenWith-width_chaoliu+5, labmeiri_mess.Bottom+5, width_chaoliu/2-7, 40);
    _img_chaoliu.contentMode = UIViewContentModeScaleAspectFit;
    _img_chaoliu.image = [UIImage imageNamed:@"home_trend_img"];
    [self addSubview:_img_chaoliu];
    
    UILabel *labshishang =LabelInit(kMSScreenWith-width_chaoliu/2+2, 5, width_chaoliu/2-2, 21);
    labshishang.text = @"时尚大牌";
    labshishang.font = Font(16);
    labshishang.textColor = [RegularExpressionsMethod ColorWithHexString:@"F51385"];
    [self addSubview:labshishang];
    
    UILabel *labshishang_mess =LabelInit(kMSScreenWith-width_chaoliu/2+2, labshishang.Bottom, width_chaoliu/2-7, 20);
    labshishang_mess.text = @"珍品质";
    labshishang_mess.font = Font(12);
    labshishang_mess.textColor = [RegularExpressionsMethod ColorWithHexString:@"707070"];
    [self addSubview:labshishang_mess];
    
    _img_shishang = ImageViewInit(kMSScreenWith-width_chaoliu/2+5, labmeiri_mess.Bottom+5, width_chaoliu/2-7, 40);
    _img_shishang.contentMode = UIViewContentModeScaleAspectFit;
    _img_shishang.image = [UIImage imageNamed:@"home_brand_img"];
    [self addSubview:_img_shishang];
    
    UIImageView *line4 = ImageViewInit(kMSScreenWith-width_chaoliu/2, 3, 1, 97);
    line4.backgroundColor = [RegularExpressionsMethod ColorWithHexString:@"E6E6E6"];
    [self addSubview:line4];
    
    UILabel *labxinpin =LabelInit(width_meiri+5, 110, width_baokuan-7, 21);
    labxinpin.text = @"新品首发";
    labxinpin.font = Font(16);
    labxinpin.textColor = [RegularExpressionsMethod ColorWithHexString:@"3399FF"];
    [self addSubview:labxinpin];
    
    UILabel *labxinpin_mess =LabelInit(width_meiri+5, labxinpin.Bottom, width_baokuan-7, 20);
    labxinpin_mess.text = @"提醒您";
    labxinpin_mess.font = Font(12);
    labxinpin_mess.textColor = [RegularExpressionsMethod ColorWithHexString:@"707070"];
    [self addSubview:labxinpin_mess];
    
    _img_xinpin = ImageViewInit(width_meiri+5, labxinpin_mess.Bottom+5, width_baokuan-7, 40);
    _img_xinpin.contentMode = UIViewContentModeScaleAspectFit;
    _img_xinpin.image = [UIImage imageNamed:@"home_starting_img"];
    [self addSubview:_img_xinpin];
    
    UILabel *labhaohuo =LabelInit(kMSScreenWith-width_chaoliu+5, 110, width_chaoliu/2-2, 21);
    labhaohuo.text = @"好货不断";
    labhaohuo.font = Font(16);
    labhaohuo.textColor = [RegularExpressionsMethod ColorWithHexString:@"FF6600"];
    [self addSubview:labhaohuo];
    
    UILabel *labhaohuo_mess =LabelInit(kMSScreenWith-width_chaoliu+5, labhaohuo.Bottom, width_chaoliu/2-7, 20);
    labhaohuo_mess.text = @"惊喜多";
    labhaohuo_mess.font = Font(12);
    labhaohuo_mess.textColor = [RegularExpressionsMethod ColorWithHexString:@"707070"];
    [self addSubview:labhaohuo_mess];
    
    _img_haohuo = ImageViewInit(kMSScreenWith-width_chaoliu/2+1, 110, width_chaoliu/2-5, 90);
    _img_haohuo.contentMode = UIViewContentModeScaleAspectFit;
    _img_haohuo.image = [UIImage imageNamed:@"home_constantly_img"];
    [self addSubview:_img_haohuo];
    
}



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
