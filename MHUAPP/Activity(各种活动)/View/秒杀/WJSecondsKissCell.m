//
//  WJSecondsKissCell.m
//  MHUAPP
//
//  Created by jinri on 2018/1/5.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import "WJSecondsKissCell.h"
#import <UIImageView+WebCache.h>


@interface WJSecondsKissCell()


@end


@implementation WJSecondsKissCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
#pragma mark - Intial
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        [self setUpUI];
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return self;
}

#pragma mark - UI
- (void)setUpUI
{
    self.backgroundColor = [UIColor whiteColor];

    _gridImageView = [[UIImageView alloc] init];
    _gridImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:_gridImageView];

    _gridLabel = [[UILabel alloc] init];
    _gridLabel.font = PFR14Font;
    _gridLabel.textColor = [RegularExpressionsMethod ColorWithHexString:BASEBLACKCOLOR];
    _gridLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_gridLabel];

    _goods_briefLabel = [[UILabel alloc] init];
    _goods_briefLabel.font = PFR12Font;
    _goods_briefLabel.textColor = [RegularExpressionsMethod ColorWithHexString:BASELITTLEBLACKCOLOR];
    _goods_briefLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_goods_briefLabel];

    _priceLabel = [[UILabel alloc] init];
    _priceLabel.font = PFR18Font;
    _priceLabel.textColor = [UIColor redColor];
    [self addSubview:_priceLabel];

    _oldPriceLabel = [[UILabel alloc] init];
    _oldPriceLabel.font = PFR12Font;
    _oldPriceLabel.textColor = [UIColor darkGrayColor];
    [self addSubview:_oldPriceLabel];

    _lab_count = [[UILabel alloc] init];
    _lab_count.font = PFR12Font;
    _lab_count.textColor = [UIColor darkGrayColor];
    [self addSubview:_lab_count];

    _btn_action = [UIButton buttonWithType:UIButtonTypeCustom];
    _btn_action.frame = CGRectMake(kMSScreenWith-100, 45, 90, 30);
    [_btn_action setBackgroundColor:[UIColor redColor]];
    _btn_action.layer.cornerRadius = 2.0f;
    _btn_action.layer.masksToBounds = YES;
    [_btn_action setTitle:@"立即抢购" forState:UIControlStateNormal];
    _btn_action.titleLabel.font = Font(14);
    [_btn_action setTitleColor:kMSCellBackColor forState:UIControlStateNormal];
    [self.contentView addSubview:_btn_action];

     _slider = [[HYSlider alloc]initWithFrame:CGRectMake(kMSScreenWith-100, 80, 90, 10)];
    _slider.currentValueColor = [RegularExpressionsMethod ColorWithHexString:@"409EFF"];
    _slider.showTouchView = NO;
    [self.contentView addSubview:_slider];

    [RegularExpressionsMethod dc_setUpAcrossPartingLineWith:self WithColor:[[UIColor lightGrayColor]colorWithAlphaComponent:0.3]];
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    [_gridImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        [make.left.mas_equalTo(self)setOffset:DCMargin * 2];
        make.size.mas_equalTo(CGSizeMake(90, 90));
    }];



    [_gridLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.left.mas_equalTo(_gridImageView.mas_right)setOffset:DCMargin];
        [make.top.mas_equalTo(self)setOffset:3];
        [make.right.mas_equalTo(self)setOffset:-DCMargin];
    }];

    [_goods_briefLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.left.mas_equalTo(_gridImageView.mas_right)setOffset:DCMargin];
        [make.top.mas_equalTo(_gridLabel.mas_bottom)setOffset:3];
        [make.right.mas_equalTo(self)setOffset:-DCMargin];
    }];


    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.left.mas_equalTo(_gridImageView.mas_right)setOffset:DCMargin];
        [make.top.mas_equalTo(self)setOffset:45];
    }];

    [_oldPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.left.mas_equalTo(_gridImageView.mas_right)setOffset:10];
        make.top.mas_equalTo(_priceLabel.mas_bottom);
    }];

    [_lab_count mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.left.mas_equalTo(_oldPriceLabel.mas_right)setOffset:50];
        make.top.mas_equalTo(_priceLabel.mas_bottom);
    }];
}
//-(void)setGoodsItem:(WJSecondsKillItem *)goodsItem
//{
//    _goodsItem = goodsItem;
//    _gridLabel.text = _goodsItem.goods_name;
//    _goods_briefLabel.text = _goodsItem.goods_brief;
//    [_gridImageView sd_setImageWithURL:[NSURL URLWithString:_goodsItem.goods_thumb]];
//    _priceLabel.text = [NSString stringWithFormat:@"¥ %.2f",[_goodsItem.shop_price floatValue]];
//    NSString *oldprice = [NSString stringWithFormat:@"￥%@件",_goodsItem.market_price];
//    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:oldprice
//                                                                                attributes:@{NSStrikethroughStyleAttributeName : @(NSUnderlineStyleSingle)}];
//    _oldPriceLabel.attributedText = attrStr;
//
//}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
