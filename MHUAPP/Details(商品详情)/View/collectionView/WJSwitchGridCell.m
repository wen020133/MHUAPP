//
//  WJSwitchGridCell.m
//  MHUAPP
//
//  Created by jinri on 2017/12/1.
//  Copyright © 2017年 wenchengjun. All rights reserved.
//

#import "WJSwitchGridCell.h"
#import "UIView+UIViewFrame.h"
#import <UIImageView+WebCache.h>


@implementation WJSwitchGridCell
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
//    _freeSuitImageView = [[UIImageView alloc] init];
//    _freeSuitImageView.image = [UIImage imageNamed:@"taozhuang_tag"];
//    [self addSubview:_freeSuitImageView];

    _gridImageView = [[UIImageView alloc] init];
    _gridImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:_gridImageView];

    _gridLabel = [[UILabel alloc] init];
    _gridLabel.font = PFR14Font;
    _gridLabel.numberOfLines = 2;
    [self addSubview:_gridLabel];

    _priceLabel = [[UILabel alloc] init];
    _priceLabel.font = PFR20Font;
    _priceLabel.textColor = [UIColor redColor];
    [self addSubview:_priceLabel];

    _commentNumLabel = [[UILabel alloc] init];
    _commentNumLabel.font = PFR12Font;
    _commentNumLabel.textColor = [UIColor darkGrayColor];
    [self addSubview:_commentNumLabel];
    
    _hongbaoLabel = [[UILabel alloc] init];
    _hongbaoLabel.textColor = kMSCellBackColor;
    _hongbaoLabel.backgroundColor = [RegularExpressionsMethod ColorWithHexString:BASEPINK];
    _hongbaoLabel.font = Font(11);
    _hongbaoLabel.textAlignment = NSTextAlignmentCenter;
    _hongbaoLabel.layer.cornerRadius = 5;
    _hongbaoLabel.layer.masksToBounds = YES;//设置圆角
    _hongbaoLabel.text = @"红包";
    [self addSubview:_hongbaoLabel];
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    [_gridImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        [make.top.mas_equalTo(self)setOffset:DCMargin];
        make.size.mas_equalTo(CGSizeMake(self.width * 0.8, self.width * 0.8));
    }];


    [_gridLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.left.mas_equalTo(self) setOffset:2];
        [make.top.mas_equalTo(_gridImageView.mas_bottom) setOffset:2];
        [make.right.mas_equalTo(self)setOffset:2];
    }];
    
    [_hongbaoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.right.mas_equalTo(self)setOffset:-DCMargin];
    [make.top.mas_equalTo(_gridLabel.mas_bottom)setOffset:1];
        make.size.mas_equalTo(CGSizeMake(30, 15));
    }];
//    [_freeSuitImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        [make.left.mas_equalTo(self) setOffset:2];
//        [make.top.mas_equalTo(_gridLabel.mas_bottom)setOffset:2];
//    }];

    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       [make.left.mas_equalTo(self) setOffset:2];
        [make.bottom.mas_equalTo(self.mas_bottom)setOffset:-DCMargin];
    }];

    [_commentNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.right.mas_equalTo(self) setOffset:-DCMargin];
         [make.bottom.mas_equalTo(self.mas_bottom)setOffset:-DCMargin];
    }];


}

-(void)setGoodsItem:(WJGoodsListItem *)goodsItem
{
    _goodsItem = goodsItem;
    [_gridImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",_goodsItem.goods_thumb]]];
    NSString *stringPrice = [NSString stringWithFormat:@"¥ %.2f",[_goodsItem.shop_price floatValue]];
    NSMutableAttributedString *LZString = [[NSMutableAttributedString alloc]initWithString:stringPrice];
    [LZString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, 2)];
    _priceLabel.attributedText =LZString;

     _commentNumLabel.text = [NSString stringWithFormat:@"已售%@件",ConvertString(_goodsItem.num)];
    _gridLabel.text = _goodsItem.goods_name;
    if([_goodsItem.is_use_bonus integerValue]==1)
    {
        _hongbaoLabel.hidden = NO;
    }
    else
    {
        _hongbaoLabel.hidden = YES;
    }
}


@end
