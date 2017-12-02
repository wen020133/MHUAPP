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

    _autotrophyImageView = [[UIImageView alloc] init];
    [self addSubview:_autotrophyImageView];
    _autotrophyImageView.image = [UIImage imageNamed:@"detail_title_ziying_tag"];

    _gridImageView = [[UIImageView alloc] init];
    _gridImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:_gridImageView];

    _gridLabel = [[UILabel alloc] init];
    _gridLabel.font = PFR14Font;
    _gridLabel.numberOfLines = 2;
    _gridLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_gridLabel];

    _priceLabel = [[UILabel alloc] init];
    _priceLabel.font = PFR15Font;
    _priceLabel.textColor = [UIColor redColor];
    [self addSubview:_priceLabel];


    _commentNumLabel = [[UILabel alloc] init];
    NSInteger pNum = arc4random() % 10000;
    _commentNumLabel.text = [NSString stringWithFormat:@"%zd人已评价",pNum];
    _commentNumLabel.font = PFR10Font;
    _commentNumLabel.textColor = [UIColor darkGrayColor];
    [self addSubview:_commentNumLabel];
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    [_gridImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        [make.left.mas_equalTo(self)setOffset:DCMargin * 2];
        make.size.mas_equalTo(CGSizeMake(90, 90));
    }];

    [_autotrophyImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.left.mas_equalTo(_gridImageView.mas_right)setOffset:DCMargin];
        make.top.mas_equalTo(_gridImageView);
    }];

    [_gridLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.left.mas_equalTo(_gridImageView.mas_right)setOffset:DCMargin];
        [make.top.mas_equalTo(_gridImageView)setOffset:-3];
        [make.right.mas_equalTo(self)setOffset:-DCMargin];
    }];


    [_freeSuitImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_autotrophyImageView);
        [make.top.mas_equalTo(_gridLabel.mas_bottom)setOffset:2];
    }];

    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_autotrophyImageView);
        [make.top.mas_equalTo(_freeSuitImageView.mas_bottom)setOffset:2];
    }];

    [_commentNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_autotrophyImageView);
        [make.top.mas_equalTo(_priceLabel.mas_bottom)setOffset:2];
    }];
}
-(void)setGoodsItem:(WJGoodsListItem *)goodsItem
{
    _goodsItem = goodsItem;
    [_gridImageView sd_setImageWithURL:[NSURL URLWithString:_goodsItem.image_url]];
    _priceLabel.text = [NSString stringWithFormat:@"¥ %.2f",[_goodsItem.price floatValue]];
    _gridLabel.text = _goodsItem.main_title;
}
@end
