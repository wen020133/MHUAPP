//
//  WJXianShiMiaoShaCell.m
//  MHUAPP
//
//  Created by jinri on 2018/2/28.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import "WJXianShiMiaoShaCell.h"
#import "UIView+UIViewFrame.h"
#import <UIImageView+WebCache.h>

@implementation WJXianShiMiaoShaCell
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {

        _grayView = [[UIView alloc]initWithFrame:CGRectMake(4, 0, self.width-8, self.height)];
        _grayView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_grayView];

        _img_content = [[UIImageView alloc]initWithFrame:CGRectMake(0, 2, _grayView.width, _grayView.height-70)];
        _img_content.backgroundColor = kMSCellBackColor;
        _img_content.contentMode = UIViewContentModeScaleAspectFit;
        [_grayView addSubview:_img_content];

        _title = [[UILabel alloc]initWithFrame:CGRectMake(10, _grayView.height-71, _grayView.width-20, 21)];
        _title.font = PFR14Font;
        _title.textColor = [RegularExpressionsMethod ColorWithHexString:BASEBLACKCOLOR];
        _title.textAlignment = NSTextAlignmentLeft;
        [_grayView addSubview:_title];

        _lab_price = [[UILabel alloc]initWithFrame:CGRectMake(10, _title.Bottom+2, self.width-45, 23)];
        _lab_price.font = PFR15Font;
        _lab_price.textColor = [RegularExpressionsMethod ColorWithHexString:BASEPINK];
        _lab_price.textAlignment = NSTextAlignmentLeft;
        [_grayView addSubview:_lab_price];

        _oldPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.width-65, _title.Bottom+2, 60, 23)];
        _oldPriceLabel.font = PFR11Font;
        _oldPriceLabel.textAlignment = NSTextAlignmentRight;
        _oldPriceLabel.textColor = [UIColor darkGrayColor];
        [_grayView addSubview:_oldPriceLabel];

        _lab_count = [[UILabel alloc]initWithFrame:CGRectMake(10, _lab_price.Bottom+2, self.width-15, 20)];
        _lab_count.font = PFR12Font;
        _lab_count.textColor = [RegularExpressionsMethod ColorWithHexString:BASELITTLEBLACKCOLOR];
        _lab_count.textAlignment = NSTextAlignmentLeft;
        [_grayView addSubview:_lab_count];

    }
    return self;
}


-(void)setModel:(WJXianShiMiaoShaModel *)model
{
    if (model!=_model) {
        _model = model;
    }
    NSString *urlStr = [NSString stringWithFormat:@"%@",_model.image_url] ;
    [_img_content sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:@"home_banner_img.png"] completed:nil];
    _title.text = _model.main_title;
//    NSString *price = [NSString stringWithFormat:@"￥%@",_model.price];
//    CGFloat width = [RegularExpressionsMethod widthOfString:price font:Font(15) height:20];
//    _lab_price.frame = CGRectMake(10, _title.Bottom+5, width, 20);
    _lab_price.text = [NSString stringWithFormat:@"￥%@",_model.price];

    NSString *oldprice = [NSString stringWithFormat:@"￥%@",_model.price];
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:oldprice
                                                                                attributes:@{NSStrikethroughStyleAttributeName : @(NSUnderlineStyleSingle)}];
    _oldPriceLabel.attributedText = attrStr;

//    NSString *saleCount = [NSString stringWithFormat:@"%@人已付款",_model.sales];
//    CGFloat saleWidth = [RegularExpressionsMethod widthOfString:saleCount font:Font(12) height:15];
//    _lab_count.frame = CGRectMake(10+width+5, _title.Bottom+10, saleWidth, 15);
    _lab_count.text = [NSString stringWithFormat:@"%@人已付款",_model.sales];

}
@end
