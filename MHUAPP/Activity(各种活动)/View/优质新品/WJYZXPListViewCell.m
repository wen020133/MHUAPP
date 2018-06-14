//
//  WJYZXPListViewCell.m
//  MHUAPP
//
//  Created by jinri on 2018/3/31.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import "WJYZXPListViewCell.h"
#import "UIView+UIViewFrame.h"
#import <UIImageView+WebCache.h>


@implementation WJYZXPListViewCell

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {

        self.backgroundColor = self.contentView.backgroundColor = [UIColor clearColor];
        _grayView = [[UIView alloc]initWithFrame:CGRectMake(2, 0, self.width-3, self.height)];
        _grayView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_grayView];

        _img_content = [[UIImageView alloc]initWithFrame:CGRectMake(0, 2, _grayView.width, 130)];
        _img_content.backgroundColor = kMSCellBackColor;
        _img_content.contentMode = UIViewContentModeScaleAspectFit;
        [_grayView addSubview:_img_content];

        _lab_title= [[UILabel alloc]initWithFrame:CGRectMake(10, 135, _grayView.width-20, 20)];
        _lab_title.font = PFR14Font;
        _lab_title.textColor = [RegularExpressionsMethod ColorWithHexString:BASEBLACKCOLOR];
        _lab_title.textAlignment = NSTextAlignmentLeft;
        [_grayView addSubview:_lab_title];

        _lab_describe= [[UILabel alloc]initWithFrame:CGRectMake(10, _lab_title.Bottom, _grayView.width-20, 20)];
        _lab_describe.font = PFR12Font;
        _lab_describe.textColor = [RegularExpressionsMethod ColorWithHexString:BASELITTLEBLACKCOLOR];
        _lab_describe.textAlignment = NSTextAlignmentLeft;
        [_grayView addSubview:_lab_describe];

        _priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, _lab_describe.Bottom, 100, 20)];
        _priceLabel.font = PFR14Font;
        _priceLabel.textAlignment = NSTextAlignmentLeft;
        _priceLabel.textColor = [UIColor redColor];
        [_grayView addSubview:_priceLabel];

        _lab_count = [[UILabel alloc]initWithFrame:CGRectMake(self.width-50, _lab_describe.Bottom, 45, 20)];
        _lab_count.font = PFR11Font;
        _lab_count.textColor = [RegularExpressionsMethod ColorWithHexString:BASELITTLEBLACKCOLOR];
        _lab_count.textAlignment = NSTextAlignmentRight;
//        [_grayView addSubview:_lab_count];


        _btn_price = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btn_price setBackgroundColor:[RegularExpressionsMethod ColorWithHexString:BASEPINK]];
        _btn_price.frame = CGRectMake(10, _lab_count.Bottom+1, _grayView.width-20, 30);
        _btn_price.titleLabel.font = PFR15Font;
        _btn_price.titleLabel.textColor = kMSCellBackColor;
        [_btn_price setTitle:@"立即购买" forState:UIControlStateNormal];
        _btn_price.layer.cornerRadius = 2;
        _btn_price.layer.masksToBounds = YES;//设置圆角
        [_grayView addSubview:_btn_price];
    }
    return self;
}


-(void)setModel:(WJJRPTItem *)model
{
    if (model!=_model) {
        _model = model;
    }
    NSString *urlStr = [NSString stringWithFormat:@"%@",_model.goods_thumb] ;
    [_img_content sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:@"default_nomore.png"] completed:nil];
    _lab_title.text = _model.goods_name;
    _lab_describe.text = _model.goods_brief;
    _priceLabel.text = [NSString stringWithFormat:@"¥ %.2f",[_model.shop_price floatValue]];
//    NSString *oldprice = [NSString stringWithFormat:@"￥%@",_model.market_price];
//    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:oldprice
//                                                                                attributes:@{NSStrikethroughStyleAttributeName : @(NSUnderlineStyleSingle)}];
//    _oldPriceLabel.attributedText = attrStr;


    _lab_count.text = [NSString stringWithFormat:@"已售%@",_model.shop_num];

}
@end
