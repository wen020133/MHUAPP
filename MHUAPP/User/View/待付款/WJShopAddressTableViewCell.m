//
//  WJShopAddressTableViewCell.m
//  MHUAPP
//
//  Created by jinri on 2018/4/28.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import "WJShopAddressTableViewCell.h"
#import "UIView+UIViewFrame.h"

@implementation WJShopAddressTableViewCell

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
    UIImageView *imageV = ImageViewInit(DCMargin, 35, 13, 15);
    imageV.image = [UIImage imageNamed:@"cart_positioning"];
    [self.contentView addSubview:imageV];

    _lab_Name = LabelInit(imageV.Right+5, DCMargin, 220, 20);
    _lab_Name.font = PFR16Font;
    _lab_Name.textColor = [RegularExpressionsMethod ColorWithHexString:BASEBLACKCOLOR];
    [self.contentView addSubview:_lab_Name];

    _lab_telephone = LabelInit(imageV.Right+5, _lab_Name.Bottom, 220, 20);
    _lab_telephone.font = PFR16Font;
    _lab_telephone.textColor = [RegularExpressionsMethod ColorWithHexString:BASEBLACKCOLOR];
    [self addSubview:_lab_telephone];

    _lab_address = LabelInit(imageV.Right+5, _lab_telephone.Bottom, kMSScreenWith-70, 20);
    _lab_address.font = PFR14Font;
    _lab_address.textColor = [RegularExpressionsMethod ColorWithHexString:BASEBLACKCOLOR];
    [self.contentView addSubview:_lab_address];

    UIImageView *actionImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kMSScreenWith-26, self.contentView.height/2-5, 6, 10)];
    actionImageView.image = [UIImage imageNamed:@"home_more"];
    actionImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:actionImageView];

}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
