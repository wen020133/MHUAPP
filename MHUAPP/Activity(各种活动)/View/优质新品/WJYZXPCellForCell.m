//
//  WJYZXPCellForCell.m
//  MHUAPP
//
//  Created by jinri on 2018/3/31.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import "WJYZXPCellForCell.h"
#import "UIView+UIViewFrame.h"
#import <UIImageView+WebCache.h>

@implementation WJYZXPCellForCell
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {



        _img_content = [[UIImageView alloc]initWithFrame:CGRectMake(5, 0, self.width-5, self.height)];
        _img_content.backgroundColor = kMSCellBackColor;
        _img_content.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:_img_content];

        UILabel *lab_moeny= [[UILabel alloc]initWithFrame:CGRectMake(self.width/2-30, self.height/2-15, 20, 20)];
        lab_moeny.font = PFR13Font;
        lab_moeny.text = @"￥";
        lab_moeny.textColor = kMSCellBackColor;
        lab_moeny.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:lab_moeny];

        _lab_title= [[UILabel alloc]initWithFrame:CGRectMake(self.width/2-10, 15, 50, 40)];
        _lab_title.font = PFR20Font;
        _lab_title.text =@"20";
        _lab_title.textColor = kMSCellBackColor;
        _lab_title.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_lab_title];

        _lab_title= [[UILabel alloc]initWithFrame:CGRectMake(self.width/2-10, 15, 50, 40)];
        _lab_title.font = PFR20Font;
        _lab_title.text =@"20";
        _lab_title.textColor = kMSCellBackColor;
        _lab_title.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_lab_title];

        _lab_describe = [[UILabel alloc]initWithFrame:CGRectMake(10, _lab_title.Bottom, 80, 20)];
        _lab_describe.font = PFR12Font;
        _lab_describe.textColor = kMSCellBackColor;
        _lab_describe.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_lab_describe];


        _btn_nowGet = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btn_nowGet setBackgroundColor:[RegularExpressionsMethod ColorWithHexString:BASEPINK]];
        _btn_nowGet.frame = CGRectMake(20, 77, 60, 20);
        _btn_nowGet.titleLabel.font = PFR15Font;
        [_btn_nowGet setTitle:@"立即领取" forState:UIControlStateNormal];
        _btn_nowGet.titleLabel.textColor = kMSCellBackColor;
        _btn_nowGet.layer.cornerRadius = 10;
        _btn_nowGet.layer.masksToBounds = YES;//设置圆角
        [self.contentView addSubview:_btn_nowGet];
    }
    return self;
}


-(void)setModel:(WJJRPTItem *)model
{
    if (model!=_model) {
        _model = model;
    }
    NSString *urlStr = [NSString stringWithFormat:@"%@",_model.goods_thumb] ;
    [_img_content sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:@"home_banner_img.png"] completed:nil];
    _lab_title.text = _model.goods_name;
    _lab_describe.text = _model.goods_brief;


}

@end
