//
//  WJJIFenListCollectionViewCell.m
//  MHUAPP
//
//  Created by jinri on 2018/3/31.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import "WJJIFenListCollectionViewCell.h"
#import "UIView+UIViewFrame.h"
#import <UIImageView+WebCache.h>


@implementation WJJIFenListCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {

        _grayView = [[UIView alloc]initWithFrame:CGRectMake(4, 0, self.width-8, self.height)];
        _grayView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_grayView];

        _img_content = [[UIImageView alloc]initWithFrame:CGRectMake(0, 2, _grayView.width, 130)];
        _img_content.backgroundColor = kMSCellBackColor;
        _img_content.contentMode = UIViewContentModeScaleAspectFit;
        [_grayView addSubview:_img_content];

        _lab_title= [[UILabel alloc]initWithFrame:CGRectMake(10, 135, _grayView.width-20, 20)];
        _lab_title.font = PFR13Font;
        _lab_title.textColor = [RegularExpressionsMethod ColorWithHexString:BASEBLACKCOLOR];
        _lab_title.textAlignment = NSTextAlignmentLeft;
        [_grayView addSubview:_lab_title];


        _lab_price = [[UILabel alloc] initWithFrame:CGRectMake(10, _lab_title.Bottom, self.width/2, 20)];
        _lab_price.font = PFR13Font;
        _lab_price.textAlignment = NSTextAlignmentLeft;
        _lab_price.textColor = [RegularExpressionsMethod ColorWithHexString:BASEPINK];
        [_grayView addSubview:_lab_price];


        _btn_buy = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btn_buy setBackgroundColor:[RegularExpressionsMethod ColorWithHexString:BASEPINK]];
        _btn_buy.frame = CGRectMake(10, _lab_price.Bottom+10, _grayView.width-20, 40);
        _btn_buy.titleLabel.font = PFR15Font;
        _btn_buy.titleLabel.textColor = kMSCellBackColor;
        [_btn_buy setTitle:@"立即兑换" forState:UIControlStateNormal];
        _btn_buy.layer.cornerRadius = 20;
        _btn_buy.layer.masksToBounds = YES;//设置圆角
        [_grayView addSubview:_btn_buy];
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
    _lab_price.text = [NSString stringWithFormat:@"%@积分",_model.integral];

}
@end
