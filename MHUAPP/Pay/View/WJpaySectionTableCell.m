//
//  WJpaySectionTableCell.m
//  MHUAPP
//
//  Created by jinri on 2018/5/7.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import "WJpaySectionTableCell.h"

@implementation WJpaySectionTableCell

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
    _img_icon = ImageViewInit(kMSScreenWith/2-60, 14, 30, 30);
    _img_icon.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:_img_icon];

    _lab_title = LabelInit(kMSScreenWith/2-20, 14, 120, 30);
    _lab_title.font = Font(15);
    _lab_title.textColor = [RegularExpressionsMethod ColorWithHexString:BASEBLACKCOLOR];
    [self.contentView addSubview:_lab_title];

    [RegularExpressionsMethod dc_setUpAcrossPartingLineWith:self WithColor:[[UIColor lightGrayColor]colorWithAlphaComponent:0.3]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
