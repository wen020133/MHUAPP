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

        _lab_describe= [[UILabel alloc]initWithFrame:CGRectMake(10, _lab_title.Bottom, _grayView.width-20, 20)];
        _lab_describe.font = PFR12Font;
        _lab_describe.textColor = [RegularExpressionsMethod ColorWithHexString:BASEBLACKCOLOR];
        _lab_describe.textAlignment = NSTextAlignmentLeft;
        [_grayView addSubview:_lab_describe];

        _lab_price = [[UILabel alloc] initWithFrame:CGRectMake(10, _lab_describe.Bottom, self.width/2, 20)];
        _lab_price.font = PFR11Font;
        _lab_price.textAlignment = NSTextAlignmentLeft;
        _lab_price.textColor = [UIColor darkGrayColor];
        [_grayView addSubview:_lab_price];

        _lab_count = [[UILabel alloc]initWithFrame:CGRectMake(self.width/2, _lab_describe.Bottom, self.width/2-20, 20)];
        _lab_count.font = PFR11Font;
        _lab_count.textColor = [RegularExpressionsMethod ColorWithHexString:BASELITTLEBLACKCOLOR];
        _lab_count.textAlignment = NSTextAlignmentRight;
        [_grayView addSubview:_lab_count];


        _btn_buy = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btn_buy setBackgroundColor:[RegularExpressionsMethod ColorWithHexString:BASEPINK]];
        _btn_buy.frame = CGRectMake(10, _lab_count.Bottom+1, _grayView.width-20, 30);
        _btn_buy.titleLabel.font = PFR15Font;
        _btn_buy.titleLabel.textColor = kMSCellBackColor;
        [_btn_buy setTitle:@"立即抢购" forState:UIControlStateNormal];
        _btn_buy.layer.cornerRadius = 15;
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
    NSString *urlStr = [NSString stringWithFormat:@"%@",_model.image_url] ;
    [_img_content sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:@"home_banner_img.png"] completed:nil];
    _lab_title.text = _model.main_title;
    _lab_describe.text = _model.main_title;


    _lab_count.text = [NSString stringWithFormat:@"已售%@",_model.sales];

}
@end
