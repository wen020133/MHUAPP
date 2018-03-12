//
//  WJNewTuiJianCell.m
//  MHUAPP
//
//  Created by jinri on 2018/2/25.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import "WJNewTuiJianCell.h"
#import "UIView+UIViewFrame.h"


#define  width_width  kMSScreenWith*0.5   //height 200


@implementation WJNewTuiJianCell

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

    UIImageView *ima_dian = [[UIImageView alloc]initWithFrame:CGRectMake(10, 0, width_width-14, 92)];
    ima_dian.backgroundColor = kMSCellBackColor;
    ima_dian.layer.cornerRadius = 3;
    ima_dian.layer.masksToBounds = true;
    ima_dian.layer.borderWidth = 1.f;
    ima_dian.layer.borderColor = [RegularExpressionsMethod ColorWithHexString:@"B3B3B3"].CGColor;
    [self addSubview:ima_dian];

    UILabel *lab_dianchui = LabelInit(ima_dian.Right-100, ima_dian.y+23,90, 21);
    lab_dianchui.text = @"电吹风类";
    lab_dianchui.font = Font(15);
    lab_dianchui.textAlignment = NSTextAlignmentRight;
    lab_dianchui.textColor = [RegularExpressionsMethod ColorWithHexString:BASEBLACKCOLOR];
    [self addSubview:lab_dianchui];
    
    UILabel *lab_dianmess = LabelInit(ima_dian.Right-100, lab_dianchui.Bottom+5,90, 17);
    lab_dianmess.text = @"愿你与美同行";
    lab_dianmess.font = Font(12);
    lab_dianmess.textAlignment = NSTextAlignmentRight;
    lab_dianmess.textColor = [RegularExpressionsMethod ColorWithHexString:@"ED7700"];
    [self addSubview:lab_dianmess];

    _img_dianchui = ImageViewInit(20, 10, 50, 80);
    _img_dianchui.contentMode = UIViewContentModeScaleAspectFit;
    _img_dianchui.image = [UIImage imageNamed:@"main_newTuiJian"];
    [self addSubview:_img_dianchui];
    
    UIImageView *ima_meijia = [[UIImageView alloc]initWithFrame:CGRectMake(width_width+4, 0, width_width-14, 92)];
    ima_meijia.layer.cornerRadius = 3;
    ima_meijia.layer.masksToBounds = true;
    ima_meijia.layer.borderWidth = 1.f;
    ima_meijia.layer.borderColor = [RegularExpressionsMethod ColorWithHexString:@"B3B3B3"].CGColor;
    [self addSubview:ima_meijia];
    
    UILabel *lab_meijia = LabelInit(ima_meijia.x+10, ima_meijia.y+23,90, 21);
    lab_meijia.text = @"美甲类";
    lab_meijia.font = Font(15);
    lab_meijia.textAlignment = NSTextAlignmentLeft;
    lab_meijia.textColor = [RegularExpressionsMethod ColorWithHexString:BASEBLACKCOLOR];
    [self addSubview:lab_meijia];
    
    UILabel *lab_meijiaMess = LabelInit(ima_meijia.x+10, lab_meijia.Bottom+5,90, 21);
    lab_meijiaMess.text = @"指甲美丽的秘密";
    lab_meijiaMess.font = Font(12);
    lab_meijiaMess.textAlignment = NSTextAlignmentLeft;
    lab_meijiaMess.textColor = [RegularExpressionsMethod ColorWithHexString:@"9D00FF"];
    [self addSubview:lab_meijiaMess];
    
    _img_meijia = ImageViewInit(ima_meijia.Right-70, 10, 50, 80);
    _img_meijia.contentMode = UIViewContentModeScaleAspectFit;
    _img_meijia.image = [UIImage imageNamed:@"main_newTuiJian2"];
    [self addSubview:_img_meijia];
    
    
    UIImageView *ima_fuhu = [[UIImageView alloc]initWithFrame:CGRectMake(10, 100, width_width-14, 92)];
    ima_fuhu.layer.cornerRadius = 3;
    ima_fuhu.layer.masksToBounds = true;
    ima_fuhu.layer.borderWidth = 1.f;
    ima_fuhu.layer.borderColor = [RegularExpressionsMethod ColorWithHexString:@"B3B3B3"].CGColor;
    [self addSubview:ima_fuhu];
    
    UILabel *lab_fuhu = LabelInit(ima_fuhu.Right-100, ima_fuhu.y+23,90, 21);
    lab_fuhu.text = @"护肤类";
    lab_fuhu.font = Font(15);
    lab_fuhu.textAlignment = NSTextAlignmentRight;
    lab_fuhu.textColor = [RegularExpressionsMethod ColorWithHexString:BASEBLACKCOLOR];
    [self addSubview:lab_fuhu];
    
    UILabel *lab_fuhumess = LabelInit(ima_fuhu.Right-130, lab_fuhu.Bottom+5,120, 21);
    lab_fuhumess.text = @"健康肌肤有你我有我";
    lab_fuhumess.font = Font(12);
    lab_fuhumess.textAlignment = NSTextAlignmentRight;
    lab_fuhumess.textColor = [RegularExpressionsMethod ColorWithHexString:@"FF110D"];
    [self addSubview:lab_fuhumess];
    
    _img_fuhu = ImageViewInit(20, 110, 50, 80);
    _img_fuhu.contentMode = UIViewContentModeScaleAspectFit;
    _img_fuhu.image = [UIImage imageNamed:@"main_newTuiJian3"];
    [self addSubview:_img_fuhu];
    
    
    UIImageView *ima_meifa = [[UIImageView alloc]initWithFrame:CGRectMake(width_width+4, 100, width_width-14, 92)];
    ima_meifa.layer.borderWidth = 1.f;
    ima_meifa.layer.borderColor = [RegularExpressionsMethod ColorWithHexString:@"B3B3B3"].CGColor;
    ima_meifa.layer.cornerRadius = 5;
    ima_meifa.layer.masksToBounds = true;
    [self addSubview:ima_meifa];
    
    UILabel *lab_meifa = LabelInit(ima_meifa.x+10, ima_meifa.y+23,90, 21);
    lab_meifa.text = @"美发类";
    lab_meifa.font = Font(15);
    lab_meifa.textAlignment = NSTextAlignmentLeft;
    lab_meifa.textColor = [RegularExpressionsMethod ColorWithHexString:BASEBLACKCOLOR];
    [self addSubview:lab_meifa];
    
    UILabel *lab_meifaMess = LabelInit(ima_meifa.x+10, lab_meifa.Bottom+5,90, 21);
    lab_meifaMess.text = @"愿你与美同行";
    lab_meifaMess.font = Font(12);
    lab_meifaMess.textAlignment = NSTextAlignmentLeft;
    lab_meifaMess.textColor = [RegularExpressionsMethod ColorWithHexString:@"0F4DDB"];
    [self addSubview:lab_meifaMess];
    
    _img_meifa = ImageViewInit(ima_meijia.Right-70,110, 50, 80);
    _img_meifa.contentMode = UIViewContentModeScaleAspectFit;
    _img_meifa.image = [UIImage imageNamed:@"main_newTuiJian4"];
    [self addSubview:_img_meifa];
}


@end
