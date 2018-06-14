//
//  WJHotSellCollectionViewCell.m
//  MHUAPP
//
//  Created by jinri on 2018/3/31.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import "WJHotSellCollectionViewCell.h"
#import "UIView+UIViewFrame.h"               //heifht 120
#import <UIImageView+WebCache.h>

@implementation WJHotSellCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = kMSCellBackColor;
        
        _img_content = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 110, 110)];
        _img_content.backgroundColor = kMSCellBackColor;
        _img_content.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:_img_content];

        _lab_title= [[UILabel alloc]initWithFrame:CGRectMake(_img_content.Right+5, DCMargin, kMSScreenWith-130, 20)];
        _lab_title.font = PFR13Font;
        _lab_title.textColor = [RegularExpressionsMethod ColorWithHexString:BASEBLACKCOLOR];
        _lab_title.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_lab_title];

        _lab_describe= [[UILabel alloc]initWithFrame:CGRectMake(_img_content.Right+5, _lab_title.Bottom, kMSScreenWith-130, 20)];
        _lab_describe.font = PFR12Font;
        _lab_describe.textColor = [RegularExpressionsMethod ColorWithHexString:BASEBLACKCOLOR];
        _lab_describe.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_lab_describe];

        _lab_price = [[UILabel alloc]initWithFrame:CGRectMake(_img_content.Right+5, _lab_describe.Bottom+30, 120, 20)];
        _lab_price.font = PFR15Font;
        _lab_price.textColor = [RegularExpressionsMethod ColorWithHexString:BASEPINK];
        _lab_price.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_lab_price];

        _lab_count = [[UILabel alloc]initWithFrame:CGRectMake(kMSScreenWith-120, _lab_describe.Bottom+30, 100, 20)];
        _lab_count.font = PFR11Font;
        _lab_count.textColor = [RegularExpressionsMethod ColorWithHexString:BASELITTLEBLACKCOLOR];
        _lab_count.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_lab_count];

        _lab_tiaoshu = [[UILabel alloc]initWithFrame:CGRectMake(_img_content.Right+5, _lab_count.Bottom+5, 100, 20)];
        _lab_tiaoshu.font = PFR11Font;
        _lab_tiaoshu.textColor = [RegularExpressionsMethod ColorWithHexString:BASELITTLEBLACKCOLOR];
        _lab_tiaoshu.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_lab_tiaoshu];

        _lab_shopName = [[UILabel alloc]initWithFrame:CGRectMake(kMSScreenWith-100, _lab_count.Bottom+5, 90, 20)];
        _lab_shopName.font = PFR11Font;
        _lab_shopName.textColor = [RegularExpressionsMethod ColorWithHexString:BASELITTLEBLACKCOLOR];
        _lab_shopName.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_lab_shopName];

        [RegularExpressionsMethod dc_setUpAcrossPartingLineWith:self WithColor:[[UIColor lightGrayColor]colorWithAlphaComponent:0.3]];

    }
    return self;
}


-(void)setModel:(WJJRPTItem *)model
{
    if (model!=_model) {
        _model = model;
    }
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",kMSBaseUserHeadPortURL,_model.goods_thumb] ;
    [_img_content sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:@"default_nomore.png"] completed:nil];
    _lab_title.text = _model.goods_name;
    _lab_describe.text = _model.goods_brief;
    _lab_price.text = [NSString stringWithFormat:@"¥ %.2f",[_model.shop_price floatValue]];

//    NSString *oldprice = [NSString stringWithFormat:@"￥%@",_model.price];
//    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:oldprice
//                                                                                attributes:@{NSStrikethroughStyleAttributeName : @(NSUnderlineStyleSingle)}];
//    _oldPriceLabel.attributedText = attrStr;


    _lab_count.text = [NSString stringWithFormat:@"已售%@件",_model.shop_num];

}
@end
