//
//  WJWAaitForGoodLogistTableCell.m
//  MHUAPP
//
//  Created by jinri on 2018/5/30.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import "WJWAaitForGoodLogistTableCell.h"
#import "UIView+UIViewFrame.h"

@implementation WJWAaitForGoodLogistTableCell

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
    UIImageView *imageV = ImageViewInit(DCMargin, 22, 13, 15);
    imageV.image = [UIImage imageNamed:@"cart_logistics"];
    [self.contentView addSubview:imageV];

    _lab_Name = LabelInit(imageV.Right+10, DCMargin, kMSScreenWith-50, 20);
    _lab_Name.font = PFR14Font;
    _lab_Name.textColor = [RegularExpressionsMethod ColorWithHexString:BASEBLACKCOLOR];
    [self.contentView addSubview:_lab_Name];

    _lab_time = [[UILabel alloc]initWithFrame:CGRectMake(imageV.Right+10, _lab_Name.Bottom+2, 220, 20)];
    _lab_time.font = PFR13Font;
    _lab_time.textColor = [RegularExpressionsMethod ColorWithHexString:BASELITTLEBLACKCOLOR];
    [self.contentView addSubview:_lab_time];

    _actionImageView = [[UIImageView alloc] init];
    _actionImageView.image = [UIImage imageNamed:@"home_more"];
    _actionImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:_actionImageView];

}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [_actionImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.right.mas_equalTo(self) setOffset:-14];
        make.centerY.mas_equalTo(self);
    }];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
