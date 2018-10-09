//
//  WJSSPTMRHHCollectionCell.m
//  MHUAPP
//
//  Created by jinri on 2018/3/28.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import "WJSSPTMRHHCollectionCell.h"   //110
#import "UIView+UIViewFrame.h"
#import <UIImageView+WebCache.h>


@implementation WJSSPTMRHHCollectionCell


-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {

        _grayView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kMSScreenWith, 105)];
        _grayView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_grayView];

        _img_content = [[UIImageView alloc]initWithFrame:CGRectMake(14, 8, 95, 95)];
        _img_content.backgroundColor = kMSCellBackColor;
        _img_content.contentMode = UIViewContentModeScaleAspectFit;
        [_grayView addSubview:_img_content];

        _lab_title= [[UILabel alloc]init];
        _lab_title.font = PFR15Font;
        _lab_title.textColor = [RegularExpressionsMethod ColorWithHexString:BASEBLACKCOLOR];
        _lab_title.textAlignment = NSTextAlignmentLeft;
        _lab_title.numberOfLines = 2;
        [_grayView addSubview:_lab_title];

//        _lab_describe= [[UILabel alloc]initWithFrame:CGRectMake(_img_content.Right+4, _lab_title.Bottom, _grayView.width-120, 20)];
//        _lab_describe.font = PFR12Font;
//        _lab_describe.textColor = [RegularExpressionsMethod ColorWithHexString:BASEBLACKCOLOR];
//        _lab_describe.textAlignment = NSTextAlignmentLeft;
//        [_grayView addSubview:_lab_describe];

        _priceLabel = [[UILabel alloc] init];
        _priceLabel.font = Font(17);
        _priceLabel.textColor = [UIColor redColor];
        [self addSubview:_priceLabel];

        _oldPriceLabel = [[UILabel alloc] init];
        _oldPriceLabel.font = PFR12Font;
        _oldPriceLabel.contentMode = NSTextAlignmentLeft;
        _oldPriceLabel.textColor = [RegularExpressionsMethod ColorWithHexString:kGrayBgColor];
        [self addSubview:_oldPriceLabel];

        _lab_minNum = [[UILabel alloc]init];
        _lab_minNum.font = PFR13Font;
        _lab_minNum.textColor = [RegularExpressionsMethod ColorWithHexString:BASELITTLEBLACKCOLOR];
        _lab_minNum.textAlignment = NSTextAlignmentCenter;
        [_grayView addSubview:_lab_minNum];

        _lab_count = [[UILabel alloc]init];
        _lab_count.font = PFR13Font;
        _lab_count.textColor = [RegularExpressionsMethod ColorWithHexString:BASELITTLEBLACKCOLOR];
        _lab_count.frame = CGRectMake(_img_content.Right+DCMargin, self.height-40, 150, 30);
        _lab_count.textAlignment = NSTextAlignmentLeft;
        [_grayView addSubview:_lab_count];


        _btn_price = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btn_price setBackgroundColor:[RegularExpressionsMethod ColorWithHexString:BASEPINK]];
        _btn_price.titleLabel.font = PFR15Font;
        _btn_price.titleLabel.textColor = kMSCellBackColor;
        _btn_price.layer.cornerRadius = 7;
        _btn_price.layer.masksToBounds = YES;//设置圆角
        _btn_price.userInteractionEnabled = NO;
        [_grayView addSubview:_btn_price];
    }
    return self;
}


-(void)setModel:(WJJRPTItem *)model
{
    if (model!=_model) {
        _model = model;
    }
    NSString *urlStr = [NSString stringWithFormat:@"%@",_model.original_img] ;
    [_img_content sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:@"default_nomore.png"] completed:nil];

    _lab_title.frame =CGRectMake(_img_content.Right+DCMargin, 2, kMSScreenWith-DCMargin*2-100, [RegularExpressionsMethod dc_calculateTextSizeWithText:_model.goods_name WithTextFont:15 WithMaxW:kMSScreenWith - DCMargin * 2-100].height+2);
    _lab_title.text = _model.goods_name;
//    _lab_describe.text = _model.goods_brief;

    _priceLabel.text = [NSString stringWithFormat:@"¥%@",_model.start_price];
    _priceLabel.frame = CGRectMake(_img_content.Right+DCMargin, self.height-62, [RegularExpressionsMethod widthOfString:_priceLabel.text font:Font(17) height:21]+5, 21);

    if (_model.shop_price.length>0) {
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:_model.shop_price
                                                                                    attributes:@{NSStrikethroughStyleAttributeName : @(NSUnderlineStyleSingle)}];
        _oldPriceLabel.attributedText = attrStr;

        _oldPriceLabel.frame = CGRectMake(_priceLabel.Right, self.height-58, [RegularExpressionsMethod widthOfString:_model.shop_price font:Font(12) height:17]+2, 17);
    }



    _lab_minNum.frame = CGRectMake(kMSScreenWith-108, self.height-62, 100, 21);
    _lab_minNum.text = [NSString stringWithFormat:@"起批量:%@件",_model.start_num];

    [_btn_price setTitle:@"立即批发" forState:UIControlStateNormal];
    _btn_price.frame = CGRectMake(kMSScreenWith-108, self.height-40, 100, 28);


    _lab_count.text = [NSString stringWithFormat:@"已批发%@件",_model.num];

}

@end
