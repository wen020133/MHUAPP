//
//  WJStoreInfoCollectionCell.m
//  MHUAPP
//
//  Created by jinri on 2018/5/14.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import "WJStoreInfoCollectionCell.h"
#import "UIView+UIViewFrame.h"
#import <UIImageView+WebCache.h>

@implementation WJStoreInfoCollectionCell
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {

        _grayView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        _grayView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_grayView];

        _img_content = [[UIImageView alloc]initWithFrame:CGRectMake(0, 2, _grayView.width, _grayView.height-70)];
        _img_content.backgroundColor = kMSCellBackColor;
        _img_content.contentMode = UIViewContentModeScaleAspectFit;
        [_grayView addSubview:_img_content];

        _title = [[UILabel alloc]initWithFrame:CGRectMake(10, _grayView.height-71, _grayView.width-20, 40)];
        _title.font = PFR14Font;
        _title.textColor = [RegularExpressionsMethod ColorWithHexString:BASEBLACKCOLOR];
        _title.textAlignment = NSTextAlignmentLeft;
        _title.numberOfLines = 0;
        [_grayView addSubview:_title];

        _lab_price = [[UILabel alloc]init];
        _lab_price.font = PFR15Font;
        _lab_price.textColor = [RegularExpressionsMethod ColorWithHexString:BASEPINK];
        _lab_price.textAlignment = NSTextAlignmentLeft;
        [_grayView addSubview:_lab_price];


    }
    return self;
}


-(void)setItem:(WJGoodsDataModel *)item
{
    if (item!=_item) {
        _item = item;
    }
    [_img_content sd_setImageWithURL:[NSURL URLWithString:_item.goods_thumb] placeholderImage:[UIImage imageNamed:@"default_nomore.png"] completed:nil];
    //    _title.text = _model.goods_name;
    [self refreshUIWithTitle:_item.goods_name];

    NSString *price = [NSString stringWithFormat:@"￥%@",_item.shop_price];
    CGFloat width = [RegularExpressionsMethod widthOfString:price font:Font(15) height:20];
    _lab_price.frame = CGRectMake(10, _title.Bottom+5, width, 20);
    _lab_price.text = price;
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
