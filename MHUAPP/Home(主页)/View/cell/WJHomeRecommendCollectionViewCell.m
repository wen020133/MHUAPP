//
//  WJHomeRecommendCollectionViewCell.m
//  MHUAPP
//
//  Created by wenchengjun on 2017/11/28.
//  Copyright © 2017年 wenchengjun. All rights reserved.
//

#import "WJHomeRecommendCollectionViewCell.h"
#import "UIView+UIViewFrame.h"
#import <UIImageView+WebCache.h>

@implementation WJHomeRecommendCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        _grayView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        _grayView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_grayView];
        
        _img_content = [[UIImageView alloc]initWithFrame:CGRectMake(0, DCMargin, _grayView.width, _grayView.height-90)];
        _img_content.backgroundColor = kMSCellBackColor;
        _img_content.contentMode = UIViewContentModeScaleAspectFit;
        [_grayView addSubview:_img_content];
        
        _title = [[UILabel alloc]initWithFrame:CGRectMake(10, _grayView.height-91, _grayView.width-20, 40)];
        _title.font = PFR14Font;
        _title.textColor = [RegularExpressionsMethod ColorWithHexString:BASEBLACKCOLOR];
        _title.textAlignment = NSTextAlignmentLeft;
        _title.numberOfLines = 0;
        [_grayView addSubview:_title];
        
        _hongbaoLabel = LabelInit(self.width-35, _title.Bottom, 30, 15);
        _hongbaoLabel.textColor = kMSCellBackColor;
        _hongbaoLabel.backgroundColor = [RegularExpressionsMethod ColorWithHexString:BASEPINK];
        _hongbaoLabel.font = Font(11);
        _hongbaoLabel.textAlignment = NSTextAlignmentCenter;
        _hongbaoLabel.layer.cornerRadius = 5;
        _hongbaoLabel.layer.masksToBounds = YES;//设置圆角
        _hongbaoLabel.text = @"红包";
        [_grayView addSubview:_hongbaoLabel];
        
        _lab_price = [[UILabel alloc]init];
        _lab_price.font = PFR15Font;
        _lab_price.textColor = [RegularExpressionsMethod ColorWithHexString:BASEPINK];
        _lab_price.textAlignment = NSTextAlignmentLeft;
        [_grayView addSubview:_lab_price];
        
        _lab_count = [[UILabel alloc]init];
        _lab_count.font = PFR12Font;
        _lab_count.textColor = [RegularExpressionsMethod ColorWithHexString:BASELITTLEBLACKCOLOR];
        _lab_count.textAlignment = NSTextAlignmentRight;
        _lab_count.adjustsFontSizeToFitWidth = YES;
        [_grayView addSubview:_lab_count];

    }
    return self;
}


-(void)setModel:(WJGoodsDataModel *)model
{
    if (model!=_model) {
        _model = model;
    }
    [_img_content sd_setImageWithURL:[NSURL URLWithString:_model.original_img] placeholderImage:[UIImage imageNamed:@"default_nomore.png"] completed:nil];
//    _title.text = _model.goods_name;
    [self refreshUIWithTitle:_model.goods_name];

    NSString *price = [NSString stringWithFormat:@"￥%@",_model.shop_price];
    CGFloat width = [RegularExpressionsMethod widthOfString:price font:Font(15) height:20];
    _lab_price.frame = CGRectMake(10, _hongbaoLabel.Bottom+5, width+5, 20);
    _lab_price.text = price;
    
    NSString *saleCount = [NSString stringWithFormat:@"%@人已付款",_model.num];
    _lab_count.frame = CGRectMake(width+12, _hongbaoLabel.Bottom+5, self.width-width-18, 20);
    _lab_count.text = saleCount;
    if([model.is_use_bonus integerValue]==1)
    {
        _hongbaoLabel.alpha = 1.0f;
    }
    else
    {
        _hongbaoLabel.alpha = 0.0f;
    }
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
