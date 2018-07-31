//
//  WJMyFenXiaoListCell.m
//  MHUAPP
//
//  Created by wenchengjun on 2018/7/30.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import "WJMyFenXiaoListCell.h"
#import "UIView+UIViewFrame.h"               //heifht 100
#import <UIImageView+WebCache.h>


@implementation WJMyFenXiaoListCell


-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = kMSCellBackColor;
        
        _img_content = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 90, 90)];
        _img_content.backgroundColor = kMSCellBackColor;
        _img_content.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:_img_content];
        
        _lab_title= [[UILabel alloc]initWithFrame:CGRectMake(_img_content.Right+5, DCMargin, kMSScreenWith-200, 20)];
        _lab_title.font = PFR13Font;
        _lab_title.textColor = [RegularExpressionsMethod ColorWithHexString:BASEBLACKCOLOR];
        _lab_title.textAlignment = NSTextAlignmentLeft;
        _lab_title.text = @"lena卷发棒直卷两用夹国学生...";
        [self.contentView addSubview:_lab_title];
        
        _lab_count= [[UILabel alloc]initWithFrame:CGRectMake(_img_content.Right+5, _lab_title.Bottom+5, kMSScreenWith/2-100, 20)];
        _lab_count.font = PFR11Font;
        _lab_count.textColor = [RegularExpressionsMethod ColorWithHexString:BASELITTLEBLACKCOLOR];
        _lab_count.text = @"销量:8888件";
        _lab_count.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_lab_count];
        
        _lab_yongjin = [[UILabel alloc]initWithFrame:CGRectMake(_lab_count.Right+5, _lab_title.Bottom+5, kMSScreenWith/2-110, 20)];
        _lab_yongjin.font = PFR11Font;
        _lab_yongjin.textColor = [RegularExpressionsMethod ColorWithHexString:BASELITTLEBLACKCOLOR];
        _lab_yongjin.text = @"佣金:￥38.00";
        _lab_yongjin.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_lab_yongjin];
        
        _lab_num = [[UILabel alloc]initWithFrame:CGRectMake(_img_content.Right+5, _lab_count.Bottom+5, kMSScreenWith/2-100, 20)];
        _lab_num.font = PFR13Font;
        _lab_num.textColor = [RegularExpressionsMethod ColorWithHexString:BASELITTLEBLACKCOLOR];
        _lab_num.textAlignment = NSTextAlignmentLeft;
        _lab_num.text = @"已分销:10件";
        [self.contentView addSubview:_lab_num];
        
        _lab_profitPrice = [[UILabel alloc]initWithFrame:CGRectMake(_lab_num.Right+5, _lab_yongjin.Bottom+5, kMSScreenWith/2-110, 20)];
        _lab_profitPrice.font = PFR11Font;
        _lab_profitPrice.textColor = [RegularExpressionsMethod ColorWithHexString:BASEPINK];
        _lab_profitPrice.text = @"获利:￥80.00";
        _lab_profitPrice.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_lab_profitPrice];
        
        UIButton *btn_fenxiaoDetail = [UIButton buttonWithType:UIButtonTypeCustom];
        btn_fenxiaoDetail.layer.borderColor = [[RegularExpressionsMethod ColorWithHexString:BASEBLACKCOLOR] CGColor];
        btn_fenxiaoDetail.layer.borderWidth = 1.0f;
        btn_fenxiaoDetail.layer.cornerRadius = 3;
        btn_fenxiaoDetail.layer.masksToBounds = YES;//设置圆角
        btn_fenxiaoDetail.frame = CGRectMake(kMSScreenWith-90, 10, 80, 30);
        [btn_fenxiaoDetail setTitle:@"分销详情" forState:UIControlStateNormal];
        btn_fenxiaoDetail.titleLabel.font = Font(14);
        [btn_fenxiaoDetail setTitleColor:[RegularExpressionsMethod ColorWithHexString:BASEBLACKCOLOR] forState:UIControlStateNormal];
        [btn_fenxiaoDetail addTarget:self action:@selector(myFenXiaoDetail:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:btn_fenxiaoDetail];
        
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.layer.cornerRadius = 3;
        btn.layer.masksToBounds = YES;//设置圆角
        btn.frame = CGRectMake(kMSScreenWith-90, 60, 80, 30);
        [btn setTitle:@"我要分销" forState:UIControlStateNormal];
        btn.titleLabel.font = Font(14);
        [btn setTitleColor:kMSCellBackColor forState:UIControlStateNormal];
        btn.backgroundColor = [RegularExpressionsMethod ColorWithHexString:BASEPINK];
        [btn addTarget:self action:@selector(myFenXiaoInList:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:btn];
        
        [RegularExpressionsMethod dc_setUpAcrossPartingLineWith:self WithColor:[[UIColor lightGrayColor]colorWithAlphaComponent:0.3]];
        
    }
    return self;
}
-(void)myFenXiaoInList:(UIButton *)sender
{
    !_filtraMyFenXiaoClickBlock ? : _filtraMyFenXiaoClickBlock(sender.tag);
}

-(void)myFenXiaoDetail:(UIButton *)sender
{
    !_myFenXiaoDetailClickBlock ? : _myFenXiaoDetailClickBlock(sender.tag);
}
@end
