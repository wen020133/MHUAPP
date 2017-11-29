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
        [_grayView addSubview:_title];

        _content = [[UILabel alloc]init];
        _content.font = PFR13Font;
        _content.textColor = [RegularExpressionsMethod ColorWithHexString:BASELITTLEBLACKCOLOR];
        _content.textAlignment = NSTextAlignmentLeft;
        [_grayView addSubview:_content];

        _img_content = [[UIImageView alloc]init];
        [_grayView addSubview:_img_content];
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];

    [_grayView mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.top.mas_equalTo(self)setOffset:DCMargin];
        make.size.mas_equalTo(CGSizeMake(kMSScreenWith-20, self.height-5));
        make.centerX.mas_equalTo(self);
    }];

    [_img_content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_grayView);
        make.size.mas_equalTo(CGSizeMake(kMSScreenWith-20, _grayView.height-50));
    }];

    [_img_content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_grayView);
        make.size.mas_equalTo(CGSizeMake(kMSScreenWith-20, _grayView.height-50));
    }];

}
@end
