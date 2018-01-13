//
//  WJSecondsKissCell.m
//  MHUAPP
//
//  Created by jinri on 2018/1/5.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import "WJSecondsKissCell.h"
#import <UIImageView+WebCache.h>

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
    _gridLabel.numberOfLines = 2;
    _gridLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_gridLabel];

    _priceLabel = [[UILabel alloc] init];
    _priceLabel.font = PFR18Font;
    _priceLabel.textColor = [UIColor redColor];
    [self addSubview:_priceLabel];

    _oldPriceLabel = [[UILabel alloc] init];
    _oldPriceLabel.font = PFR12Font;
    _oldPriceLabel.textColor = [UIColor darkGrayColor];
    [self addSubview:_oldPriceLabel];

    _btn_action = [UIButton buttonWithType:UIButtonTypeCustom];
    _btn_action.frame = CGRectMake(kMSScreenWith-100, 63, 90, 30);
    _btn_action.layer.borderColor = [[UIColor redColor] CGColor];
    _btn_action.layer.cornerRadius = 2.0f;
    _btn_action.layer.masksToBounds = YES;
    [self.contentView addSubview:_btn_action];

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
        [make.top.mas_equalTo(self)setOffset:-3];
        [make.right.mas_equalTo(self)setOffset:-DCMargin];
    }];


    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_gridImageView.mas_right);
    [make.top.mas_equalTo(_gridLabel.mas_bottom)setOffset:20];
    }];

    [_oldPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_gridImageView.mas_right);
        [make.top.mas_equalTo(_priceLabel.mas_bottom)setOffset:2];
    }];
}
-(void)setGoodsItem:(WJSecondsKillItem *)goodsItem
{
    _goodsItem = goodsItem;
    [_gridImageView sd_setImageWithURL:[NSURL URLWithString:_goodsItem.image_url]];
    _priceLabel.text = [NSString stringWithFormat:@"¥ %.2f",[_goodsItem.price floatValue]];
    NSString *oldprice = [NSString stringWithFormat:@"￥%@件",_goodsItem.old_price];
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:oldprice
                                                                                attributes:@{NSStrikethroughStyleAttributeName : @(NSUnderlineStyleSingle)}];
    _oldPriceLabel.attributedText = attrStr;
    _gridLabel.text = _goodsItem.main_title;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
