//
//  WJCGPFFeatureTopCell.m
//  MHUAPP
//
//  Created by jinri on 2018/10/8.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import "WJCGPFFeatureTopCell.h"

@implementation WJCGPFFeatureTopCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
#pragma mark - Intial
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        [self setUpUI];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setUpUI
{
    _crossButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_crossButton setImage:[UIImage imageNamed:@"icon_cha"] forState:0];
    [_crossButton addTarget:self action:@selector(crossButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_crossButton];

    _goodImageView = [UIImageView new];
    [self addSubview:_goodImageView];

    UILabel *labPrice = LabelInit(DCMargin, 90, 40, 20);
    labPrice.text = @"价格";
    labPrice.textColor = [RegularExpressionsMethod ColorWithHexString:BASEBLACKCOLOR];
    labPrice.font = Font(13);
    [self addSubview:labPrice];

    _goodPriceLabel = [UILabel new];
    _goodPriceLabel.font = PFR18Font;
    _goodPriceLabel.textColor = [UIColor redColor];

    [self addSubview:_goodPriceLabel];

    _titleLabel = [UILabel new];
    _titleLabel.numberOfLines = 2;
    _titleLabel.font = PFR14Font;
    [self addSubview:_titleLabel];

}

- (void)layoutSubviews
{
    [super layoutSubviews];

    [_crossButton mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.right.mas_equalTo(self)setOffset:-DCMargin];
        [make.top.mas_equalTo(self)setOffset:DCMargin];
        make.size.mas_equalTo(CGSizeMake(35, 35));
    }];

    [_goodImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.left.mas_equalTo(self)setOffset:DCMargin];
        [make.top.mas_equalTo(self)setOffset:DCMargin];
        make.size.mas_equalTo(CGSizeMake(80, 80));
    }];

    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.left.mas_equalTo(_goodImageView.mas_right) setOffset:DCMargin];
     [make.right.mas_equalTo(_crossButton.mas_left)setOffset:DCMargin];
        [make.top.mas_equalTo(_goodImageView)setOffset:DCMargin];
    }];

    [_goodPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.left.mas_equalTo(self)setOffset:56];
        [make.right.mas_equalTo(self)setOffset:-DCMargin];
        [make.top.mas_equalTo(_goodImageView)setOffset:DCMargin];
    }];


}


- (void)crossButtonClick
{
    !_crossButtonClickBlock ?: _crossButtonClickBlock();
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
