//
//  WJClassCategoryCell.m
//  MHUAPP
//
//  Created by jinri on 2017/11/30.
//  Copyright © 2017年 wenchengjun. All rights reserved.
//

#import "WJClassCategoryCell.h"


@implementation WJClassCategoryCell

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
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font = PFR15Font;
    [self addSubview:_titleLabel];
}

#pragma mark - 布局
- (void)layoutSubviews
{
    [super layoutSubviews];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self);
    }];

}

#pragma mark - cell点击
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    if (selected) {
        _titleLabel.textColor = [UIColor redColor];
        self.backgroundColor = [UIColor whiteColor];
    }else{
        _titleLabel.textColor = [UIColor blackColor];
        self.backgroundColor = [UIColor clearColor];
    }
}

#pragma mark - Setter Getter Methods
- (void)setTitleItem:(WJClassGoodsItem *)titleItem
{
    _titleItem = titleItem;
    self.titleLabel.text = titleItem.title;
}


@end
