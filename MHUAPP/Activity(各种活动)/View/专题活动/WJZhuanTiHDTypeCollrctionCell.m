//
//  WJZhuanTiHDTypeCollrctionCell.m
//  MHUAPP
//
//  Created by jinri on 2018/3/30.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import "WJZhuanTiHDTypeCollrctionCell.h"  //height 260
#import "UIView+UIViewFrame.h"
#import <UIImageView+WebCache.h>

@implementation WJZhuanTiHDTypeCollrctionCell
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {

        _grayView = [[UIView alloc]initWithFrame:CGRectMake(2, 0, self.width-3, self.height)];
        _grayView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_grayView];

        _img_content = [[UIImageView alloc]initWithFrame:CGRectMake(5, DCMargin, _grayView.width-10, 140)];
        _img_content.backgroundColor = kMSCellBackColor;
        _img_content.contentMode = UIViewContentModeScaleAspectFit;
        [_grayView addSubview:_img_content];

        _title = [[UILabel alloc]initWithFrame:CGRectMake(5, _img_content.Bottom, _grayView.width-10, 40)];
        _title.font = PFR14Font;
        _title.textColor = [RegularExpressionsMethod ColorWithHexString:BASEBLACKCOLOR];
        _title.textAlignment = NSTextAlignmentLeft;
        _title.numberOfLines = 0;
        [_grayView addSubview:_title];

        _lab_price = [[UILabel alloc]initWithFrame:CGRectMake(5, _title.Bottom, _grayView.width/2, 20)];
        _lab_price.font = PFR15Font;
        _lab_price.textColor = [RegularExpressionsMethod ColorWithHexString:BASEPINK];
        _lab_price.textAlignment = NSTextAlignmentLeft;
        [_grayView addSubview:_lab_price];

        _oldPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(_lab_price.Right+5, _title.Bottom, _grayView.width/2-10, 20)];
        _oldPriceLabel.font = PFR12Font;
        _oldPriceLabel.textAlignment = NSTextAlignmentRight;
        _oldPriceLabel.textColor = [UIColor darkGrayColor];
        [_grayView addSubview:_oldPriceLabel];

        _lab_count = [[UILabel alloc]initWithFrame:CGRectMake(5, _title.Bottom, _grayView.width-10, 20)];
        _lab_count.font = PFR12Font;
        _lab_count.textColor = [RegularExpressionsMethod ColorWithHexString:BASELITTLEBLACKCOLOR];
        _lab_count.textAlignment = NSTextAlignmentLeft;
        _lab_count.adjustsFontSizeToFitWidth = YES;
        [_grayView addSubview:_lab_count];


        _btn_buyNew = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btn_buyNew setBackgroundColor:[RegularExpressionsMethod ColorWithHexString:BASEPINK]];
        _btn_buyNew.frame = CGRectMake(10, _lab_count.Bottom+1, _grayView.width-20, 30);
        _btn_buyNew.titleLabel.font = PFR15Font;
        _btn_buyNew.titleLabel.textColor = kMSCellBackColor;
        _btn_buyNew.layer.cornerRadius = 2;
        _btn_buyNew.layer.masksToBounds = YES;//设置圆角
        [_grayView addSubview:_btn_buyNew];

    }
    return self;
}


-(void)setModel:(WJGoodsDataModel *)model
{
    if (model!=_model) {
        _model = model;
    }
    NSString *urlStr = [NSString stringWithFormat:@"%@",_model.goods_thumb] ;
    [_img_content sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:@"default_nomore.png"] completed:nil];
    //    _title.text = _model.goods_name;
    [self refreshUIWithTitle:_model.goods_name];

    NSString *price = [NSString stringWithFormat:@"￥%@",_model.shop_price];
    CGFloat width = [RegularExpressionsMethod widthOfString:price font:Font(15) height:20];
    _lab_price.frame = CGRectMake(10, _title.Bottom+5, width+2, 20);
    _lab_price.text = price;

    NSString *saleCount = [NSString stringWithFormat:@"%@人已付款",_model.num];
    _lab_count.frame = CGRectMake(width+12, _title.Bottom+5, self.width-width-18, 20);
    _lab_count.text = saleCount;

}

-(void)refreshUIWithTitle:(NSString *)title{
    NSString *str =  [title stringByAppendingString:@"\n"];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString: title];

    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:8];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [title length])];
    self.title.attributedText = attributedString;

    CGFloat heights = [self boundingRectWithString:str];

    if (heights>55) {
        self.title.numberOfLines = 2;
        self.title.lineBreakMode = NSLineBreakByTruncatingTail;
    }else{
        self.title.numberOfLines = 2;
    }

}

- (CGFloat)boundingRectWithString:(NSString *)string
{
    CGRect rect = [string boundingRectWithSize:CGSizeMake( _grayView.width-20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
    return  rect.size.height;
}

@end
