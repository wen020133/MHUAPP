//
//  WJJingXuanShopSonCell.m
//  MHUAPP
//
//  Created by jinri on 2018/2/25.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import "WJJingXuanShopSonCell.h"
#import "UIView+UIViewFrame.h"
#import <UIImageView+WebCache.h>


@implementation WJJingXuanShopSonCell


-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {

        _img_shopIcon = [[UIImageView alloc]initWithFrame:CGRectMake(10, 3, 35, 20)];
        _img_shopIcon.image = [UIImage imageNamed:@"home-store01_logo_img"];
        _img_shopIcon.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_img_shopIcon];

        _lab_shopName = [[UILabel alloc]initWithFrame:CGRectMake(50, 3, self.width-60, 21)];
        _lab_shopName.text = @"劲腾专营店";
        _lab_shopName.font = PFR14Font;
        _lab_shopName.textColor = [RegularExpressionsMethod ColorWithHexString:BASEBLACKCOLOR];
        _lab_shopName.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_lab_shopName];

        _lab_message = [[UILabel alloc]initWithFrame:CGRectMake(10, _img_shopIcon.Bottom+2, self.width-20, 20)];
        _lab_message.font = PFR12Font;
        _lab_message.text = @"礼遇之选，许你时尚型采";
        _lab_message.textColor = [RegularExpressionsMethod ColorWithHexString:BASELITTLEBLACKCOLOR];
        _lab_message.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_lab_message];

        _img_first = [[UIImageView alloc]initWithFrame:CGRectMake(10, _lab_message.Bottom+5, self.width-70,self.height-74)];
        _img_first.image = [UIImage imageNamed:@"home_snap_img"];
        _img_first.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_img_first];

        _img_second = [[UIImageView alloc]initWithFrame:CGRectMake(self.width-65, _lab_message.Bottom+5, 60, 60)];
        _img_second.image = [UIImage imageNamed:@"home_snap_img"];
        _img_second.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_img_second];

        _img_third = [[UIImageView alloc]initWithFrame:CGRectMake(self.width-65, self.height-65, 60, 60)];
        _img_third.image = [UIImage imageNamed:@"home_snap_img"];
        _img_third.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_img_third];
    }
    return self;
}

-(void)setModel:(WJJingXuanShopItem *)model
{
    if (model!=_model) {
        _model = model;
    }
     [_img_shopIcon sd_setImageWithURL:[NSURL URLWithString:_model.logo] placeholderImage:[UIImage imageNamed:@"default_nomore.png"] completed:nil];
    _lab_shopName.text = _model.supplier_name;
    _lab_message.text = _model.supplier_title;

}

@end
