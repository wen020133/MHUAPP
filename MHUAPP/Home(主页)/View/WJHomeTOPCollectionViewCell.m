//
//  WJHomeTOPCollectionViewCell.m
//  MHUAPP
//
//  Created by wenchengjun on 2017/11/28.
//  Copyright © 2017年 wenchengjun. All rights reserved.
//

#import "WJHomeTOPCollectionViewCell.h"
#import "UIView+UIViewFrame.h"
#import <Masonry.h>
#import <UIImageView+WebCache.h>

@implementation WJHomeTOPCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {

        _grayView = [[UIView alloc]init];
        _grayView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_grayView];

        _title = [[UILabel alloc]init];
        _title.font = PFR15Font;
        _title.textColor = [RegularExpressionsMethod ColorWithHexString:BASELITTLEBLACKCOLOR];
        _title.textAlignment = NSTextAlignmentLeft;
        _title.numberOfLines = 2;
        [_grayView addSubview:_title];

        _img_content = [[UIImageView alloc]init];
        [_grayView addSubview:_img_content];

        _lab_price = [UILabel new];
        _lab_price.font = PFR15Font;
        _lab_price.textColor = [RegularExpressionsMethod ColorWithHexString:BASEPINK];
        _lab_price.textAlignment = NSTextAlignmentLeft;
        [_grayView addSubview:_lab_price];

        _lab_count = [UILabel new];
        _lab_count.font = PFR11Font;
        _lab_count.textColor = [RegularExpressionsMethod ColorWithHexString:BASELITTLEBLACKCOLOR];
        _lab_count.textAlignment = NSTextAlignmentLeft;
        [_grayView addSubview:_lab_count];

        _btn_gou = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn_gou.backgroundColor =[UIColor redColor];
        _btn_gou.titleLabel.textColor = [UIColor whiteColor];
        _btn_gou.titleLabel.font = PFR15Font;
        [_grayView addSubview:_btn_gou];

    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];

    [_grayView mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.top.mas_equalTo(self)setOffset:DCMargin];
        make.size.mas_equalTo(CGSizeMake(kMSScreenWith-20, self.height-4));
        make.centerX.mas_equalTo(self);
    }];

    [_img_content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_grayView);
        make.size.mas_equalTo(CGSizeMake(kMSScreenWith-20, _grayView.height-50));
    }];
    
    [_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_img_content);
        make.size.mas_equalTo(CGSizeMake(kMSScreenWith-20, 30));
    }];

    [_lab_price mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_title);
        make.size.mas_equalTo(CGSizeMake(40, 23));
    }];

    [_lab_price mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(_grayView);
         make.left.mas_equalTo(_lab_price);
        make.size.mas_equalTo(CGSizeMake(40, 15));
    }];
    [_btn_gou mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(_grayView);
        make.size.mas_equalTo(CGSizeMake(60, 30));
    }];
}

-(void)setModel:(WJGoodsDataModel *)model
{
    if (model!=_model) {
        _model = model;
    }
    [_img_content sd_setImageWithURL:[NSURL URLWithString:_model.goodsIconImage] placeholderImage:[UIImage imageNamed:@"placeholder.jpg"] completed:nil];
    _title.text = _model.goodsTitle;
    _lab_price.text = [NSString stringWithFormat:@"￥%@",_model.goodPrice];
    _lab_count.text = [NSString stringWithFormat:@"月销量%@件",_model.goodPrice];
}
@end
