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
        
        _grayView = [[UIView alloc]initWithFrame:CGRectMake(4, 0, self.width-8, self.height-3)];
        _grayView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_grayView];
        
        _img_content = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, _grayView.width, _grayView.height-60)];
        [_grayView addSubview:_img_content];
        
        _title = [[UILabel alloc]initWithFrame:CGRectMake(10, _grayView.height-61, _grayView.width-20, 40)];
        _title.font = PFR15Font;
        _title.textColor = [RegularExpressionsMethod ColorWithHexString:BASEBLACKCOLOR];
        _title.textAlignment = NSTextAlignmentLeft;
        _title.numberOfLines = 2;
        [_grayView addSubview:_title];
        
        _lab_price = [[UILabel alloc]init];
        _lab_price.font = PFR15Font;
        _lab_price.textColor = [RegularExpressionsMethod ColorWithHexString:BASEPINK];
        _lab_price.textAlignment = NSTextAlignmentLeft;
        [_grayView addSubview:_lab_price];
        
        _lab_count = [[UILabel alloc]init];
        _lab_count.font = PFR12Font;
        _lab_count.textColor = [RegularExpressionsMethod ColorWithHexString:BASELITTLEBLACKCOLOR];
        _lab_count.textAlignment = NSTextAlignmentLeft;
        [_grayView addSubview:_lab_count];
        
    }
    return self;
}


-(void)setModel:(WJGoodsDataModel *)model
{
    if (model!=_model) {
        _model = model;
    }
    [_img_content sd_setImageWithURL:[NSURL URLWithString:_model.image_url] placeholderImage:[UIImage imageNamed:@"placeholder.jpg"] completed:nil];
    _title.text = _model.main_title;
    NSString *price = [NSString stringWithFormat:@"￥%@",_model.price];
    CGFloat width = [RegularExpressionsMethod widthOfString:price font:Font(15) height:20];
    _lab_price.frame = CGRectMake(10, _title.Bottom+5, width, 20);
    _lab_price.text = price;
    
    NSString *saleCount = [NSString stringWithFormat:@"月销量%@件",_model.sale_count];
    CGFloat saleWidth = [RegularExpressionsMethod widthOfString:saleCount font:Font(12) height:15];
    _lab_count.frame = CGRectMake(10+width+5, _title.Bottom+10, saleWidth, 15);
    _lab_count.text = saleCount;
    
}

@end
