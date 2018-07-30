//
//  WJKeFenxiaoListCell.m
//  MHUAPP
//
//  Created by wenchengjun on 2018/7/27.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import "WJKeFenxiaoListCell.h"
#import "UIView+UIViewFrame.h"               //heifht 100
#import <UIImageView+WebCache.h>


@implementation WJKeFenxiaoListCell


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
        
        _lab_price= [[UILabel alloc]initWithFrame:CGRectMake(_img_content.Right+5, _lab_title.Bottom+5, kMSScreenWith/2-100, 20)];
        _lab_price.font = PFR11Font;
        _lab_price.textColor = [RegularExpressionsMethod ColorWithHexString:BASELITTLEBLACKCOLOR];
        _lab_price.text = @"￥888.00";
        _lab_price.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_lab_price];
        
        _lab_count = [[UILabel alloc]initWithFrame:CGRectMake(_lab_price.Right+5, _lab_title.Bottom+5, kMSScreenWith/2-110, 20)];
        _lab_count.font = PFR11Font;
        _lab_count.textColor = [RegularExpressionsMethod ColorWithHexString:BASELITTLEBLACKCOLOR];
        _lab_count.text = @"销量:88888件";
        _lab_count.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_lab_count];
        
        _lab_yongjin = [[UILabel alloc]initWithFrame:CGRectMake(_img_content.Right+5, _lab_price.Bottom+5, kMSScreenWith-220, 20)];
        _lab_yongjin.font = PFR13Font;
        _lab_yongjin.textColor = [RegularExpressionsMethod ColorWithHexString:BASEPINK];
        _lab_yongjin.textAlignment = NSTextAlignmentLeft;
        _lab_yongjin.text = @"佣金:￥38.00";
        [self.contentView addSubview:_lab_yongjin];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.layer.cornerRadius = 3;
        btn.layer.masksToBounds = YES;//设置圆角
        btn.frame = CGRectMake(kMSScreenWith-90, 35, 80, 30);
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
     !_filtraFenXiaoClickBlock ? : _filtraFenXiaoClickBlock(sender.tag);
}
@end
