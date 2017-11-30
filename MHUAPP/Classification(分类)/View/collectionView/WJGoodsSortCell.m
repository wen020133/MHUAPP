//
//  WJGoodsSortCell.m
//  MHUAPP
//
//  Created by jinri on 2017/11/30.
//  Copyright © 2017年 wenchengjun. All rights reserved.
//

#import "WJGoodsSortCell.h"
#import "UIView+UIViewFrame.h"

// Vendors
#import <UIImageView+WebCache.h>

@implementation WJGoodsSortCell

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
    _goodsImageView = [[UIImageView alloc] init];
    _goodsImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_goodsImageView];

    _goodsTitleLabel = [[UILabel alloc] init];
    _goodsTitleLabel.font = PFR13Font;
    _goodsTitleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_goodsTitleLabel];

}
#pragma mark - 布局
- (void)layoutSubviews
{
    [_goodsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        [make.top.mas_equalTo(self)setOffset:5];
        make.size.mas_equalTo(CGSizeMake(self.width * 0.85, self.width * 0.85));
    }];

    [_goodsTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.top.mas_equalTo(_goodsImageView.mas_bottom)setOffset:5];
        make.width.mas_equalTo(_goodsImageView);
        make.centerX.mas_equalTo(self);
    }];
}


#pragma mark - Setter Getter Methods
-(void)setModel:(WJClassMainGoodTypeModel *)model
{
    _model = model;
    if ([_model.image_url containsString:@"http"]) {
        [_goodsImageView sd_setImageWithURL:[NSURL URLWithString:_model.image_url]];
    }else{
        _goodsImageView.image = [UIImage imageNamed:_model.image_url];
    }
    _goodsTitleLabel.text = _model.goods_title;
}
@end
