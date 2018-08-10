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
        [self.contentView addSubview:_lab_title];
        
        _lab_price= [[UILabel alloc]initWithFrame:CGRectMake(_img_content.Right+5, _lab_title.Bottom+5, kMSScreenWith/2-100, 20)];
        _lab_price.font = PFR11Font;
        _lab_price.textColor = [RegularExpressionsMethod ColorWithHexString:BASELITTLEBLACKCOLOR];
        _lab_price.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_lab_price];
        
        _lab_count = [[UILabel alloc]initWithFrame:CGRectMake(_lab_price.Right+5, _lab_title.Bottom+5, kMSScreenWith/2-110, 20)];
        _lab_count.font = PFR11Font;
        _lab_count.textColor = [RegularExpressionsMethod ColorWithHexString:BASELITTLEBLACKCOLOR];
        _lab_count.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_lab_count];
        
        _lab_yongjin = [[UILabel alloc]initWithFrame:CGRectMake(_img_content.Right+5, _lab_price.Bottom+5, kMSScreenWith-220, 20)];
        _lab_yongjin.font = PFR13Font;
        _lab_yongjin.textColor = [RegularExpressionsMethod ColorWithHexString:BASEPINK];
        _lab_yongjin.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_lab_yongjin];
        
        _btn_fenXiao = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn_fenXiao.layer.cornerRadius = 3;
        _btn_fenXiao.layer.masksToBounds = YES;//设置圆角
        _btn_fenXiao.frame = CGRectMake(kMSScreenWith-90, 35, 80, 30);
        [_btn_fenXiao setTitle:@"我要分销" forState:UIControlStateNormal];
        _btn_fenXiao.titleLabel.font = Font(14);
        [_btn_fenXiao setTitleColor:kMSCellBackColor forState:UIControlStateNormal];
        _btn_fenXiao.backgroundColor = [RegularExpressionsMethod ColorWithHexString:BASEPINK];
        [_btn_fenXiao addTarget:self action:@selector(myFenXiaoInList:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_btn_fenXiao];
        
        [RegularExpressionsMethod dc_setUpAcrossPartingLineWith:self WithColor:[[UIColor lightGrayColor]colorWithAlphaComponent:0.3]];
        
    }
    return self;
}
-(void)myFenXiaoInList:(UIButton *)sender
{
     !_filtraFenXiaoClickBlock ? : _filtraFenXiaoClickBlock(sender.tag);
}
-(void)setModel:(WJDepositCateList *)model
{
    if (model!=_model) {
        _model = model;
    }
    NSString *urlStr = [NSString stringWithFormat:@"%@",_model.original_img] ;
    [_img_content sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:@"default_nomore.png"] completed:nil];
    _lab_title.text = _model.goods_name;
    _lab_price.text = [NSString stringWithFormat:@"￥%@",_model.shop_price];
     _lab_count.text = [NSString stringWithFormat:@"销量:%@",_model.num];
    _lab_yongjin.text = [NSString stringWithFormat:@"佣金:￥%@",_model.distrib_money];
}
@end
