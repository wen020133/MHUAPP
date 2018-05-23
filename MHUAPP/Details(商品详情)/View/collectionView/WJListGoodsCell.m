//
//  WJListGoodsCell.m
//  MHUAPP
//
//  Created by jinri on 2017/12/1.
//  Copyright © 2017年 wenchengjun. All rights reserved.
//

#import "WJListGoodsCell.h"
#import <UIImageView+WebCache.h>

@implementation WJListGoodsCell


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
    self.backgroundColor = [UIColor whiteColor];
    _freeSuitImageView = [[UIImageView alloc] init];
    _freeSuitImageView.image = [UIImage imageNamed:@"taozhuang_tag"];
    [self addSubview:_freeSuitImageView];

    _gridImageView = [[UIImageView alloc] init];
    _gridImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:_gridImageView];

    _gridLabel = [[UILabel alloc] init];
    _gridLabel.font = PFR14Font;
    _gridLabel.numberOfLines = 2;
    _gridLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_gridLabel];

    _priceLabel = [[UILabel alloc] init];
    _priceLabel.font = PFR20Font;
    _priceLabel.textColor = [UIColor redColor];
    [self addSubview:_priceLabel];


    _commentNumLabel = [[UILabel alloc] init];
    _commentNumLabel.font = PFR12Font;
    _commentNumLabel.textColor = [UIColor darkGrayColor];
    [self addSubview:_commentNumLabel];

    [RegularExpressionsMethod dc_setUpAcrossPartingLineWith:self WithColor:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]];
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
        [make.top.mas_equalTo(_gridImageView)setOffset:-3];
        [make.right.mas_equalTo(self)setOffset:-DCMargin];
    }];


    [_freeSuitImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_gridImageView.mas_right);
        [make.top.mas_equalTo(_gridLabel.mas_bottom)setOffset:2];
    }];

    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.left.mas_equalTo(_gridImageView.mas_right)setOffset:DCMargin];
        [make.top.mas_equalTo(_freeSuitImageView.mas_bottom)setOffset:20];
    }];

    [_commentNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.right.mas_equalTo(self)setOffset:-DCMargin];
        [make.top.mas_equalTo(_freeSuitImageView.mas_bottom)setOffset:20];
    }];
}
-(void)setGoodsItem:(WJGoodsListItem *)goodsItem
{
    _goodsItem = goodsItem;
    [_gridImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kMSBaseUserHeadPortURL,_goodsItem.goods_thumb]]];
    NSString *stringPrice = [NSString stringWithFormat:@"¥ %.2f",[_goodsItem.shop_price floatValue]];
    NSMutableAttributedString *LZString = [[NSMutableAttributedString alloc]initWithString:stringPrice];
    [LZString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, 2)];
    _priceLabel.attributedText =LZString;


     _commentNumLabel.text = [NSString stringWithFormat:@"已售%@件",ConvertString(_goodsItem.goods_number)];

    _gridLabel.text = _goodsItem.goods_name;
}
@end
