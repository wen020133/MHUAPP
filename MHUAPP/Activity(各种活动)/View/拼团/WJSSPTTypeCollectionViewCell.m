//
//  WJSSPTTypeCollectionViewCell.m
//  MHUAPP
//
//  Created by jinri on 2018/3/29.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import "WJSSPTTypeCollectionViewCell.h"      //240
#import "UIView+UIViewFrame.h"
//#import <UIImageView+WebCache.h>

@implementation WJSSPTTypeCollectionViewCell


#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {

    self = [super initWithFrame:frame];
    if (self) {

        [self setUpUI];
    }
    return self;
}


#pragma mark - UI
- (void)setUpUI
{
    _grayView = [[UIView alloc]initWithFrame:CGRectMake(4, 0, self.width-8, self.height)];
    _grayView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_grayView];
    
    _img_content = [[UIImageView alloc] init];
    _img_content.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_img_content];

    _lab_title = [[UILabel alloc] init];
    _lab_title.font = PFR14Font;
    _lab_title.numberOfLines = 2;
    [self addSubview:_lab_title];

    _priceLabel = [[UILabel alloc] init];
    _priceLabel.font = PFR15Font;
    _priceLabel.textColor = [UIColor redColor];
    [self addSubview:_priceLabel];

    _lab_count = [[UILabel alloc] init];
    _lab_count.font = PFR10Font;
    _lab_count.textColor = [UIColor darkGrayColor];
    [self addSubview:_lab_count];

    _btn_price = [UIButton buttonWithType:UIButtonTypeCustom];
    [_btn_price setBackgroundColor:[RegularExpressionsMethod ColorWithHexString:BASEPINK]];
    _btn_price.titleLabel.font = PFR15Font;
    _btn_price.titleLabel.textColor = kMSCellBackColor;
    _btn_price.layer.cornerRadius = 15;
    _btn_price.layer.masksToBounds = YES;//设置圆角
    [_btn_price setTitle:@"立即拼团" forState:UIControlStateNormal];
    [self addSubview:_btn_price];
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    [_img_content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        [make.top.mas_equalTo(self)setOffset:DCMargin];
        make.size.mas_equalTo(CGSizeMake(self.width-8, 130));
    }];


    [_lab_title mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.left.mas_equalTo(self) setOffset:6];
        [make.top.mas_equalTo(_img_content.mas_bottom) setOffset:6];
        [make.right.mas_equalTo(self)setOffset:6];
    }];



    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.left.mas_equalTo(self) setOffset:6];
        [make.top.mas_equalTo(_lab_title.mas_bottom)setOffset:6];
    }];

    [_lab_count mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.right.mas_equalTo(self) setOffset:-6];
        [make.top.mas_equalTo(_lab_title.mas_bottom)setOffset:6];
    }];

    [_btn_price mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        [make.bottom.mas_equalTo(self.mas_bottom)setOffset:-6];
        [make.left.mas_equalTo(self) setOffset:10];
        [make.right.mas_equalTo(self) setOffset:-10];
        make.height.equalTo(@32);
    }];



}



//-(void)setModel:(WJJRPTItem *)model
//{
//    if (model!=_model) {
//        _model = model;
//    }
//    NSString *urlStr = [NSString stringWithFormat:@"%@",_model.goods_thumb] ;
//    [_img_content sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:@"home_banner_img.png"] completed:nil];
//    _lab_title.text = _model.goods_name;
//    _lab_describe.text = _model.goods_brief;
//    [_btn_price setTitle:[NSString stringWithFormat:@"五人团：￥%@",_model.shop_price] forState:UIControlStateNormal];
//
//    NSString *oldprice = [NSString stringWithFormat:@"￥%@",_model.market_price];
//    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:oldprice
//                                                                                attributes:@{NSStrikethroughStyleAttributeName : @(NSUnderlineStyleSingle)}];
//    _oldPriceLabel.attributedText = attrStr;
//
//
//    _lab_count.text = [NSString stringWithFormat:@"已售%@",_model.sales];
//
//}
@end
