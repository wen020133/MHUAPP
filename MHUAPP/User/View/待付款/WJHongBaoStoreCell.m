//
//  WJHongBaoStoreCell.m
//  MHUAPP
//
//  Created by wenchengjun on 2018/9/7.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import "WJHongBaoStoreCell.h"
#import "UIView+UIViewFrame.h"

@implementation WJHongBaoStoreCell

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
    
    UILabel *subtract = LabelInit(DCMargin, 10, 20, 20);
    subtract.backgroundColor = [RegularExpressionsMethod ColorWithHexString:BASEPINK];
    subtract.text = @"减";
    subtract.font = Font(14);
    subtract.textColor = [UIColor whiteColor];
    [self.contentView addSubview:subtract];
    
    UILabel *subtract_Describe = LabelInit(subtract.Right+DCMargin, 10, 100, 20);
    subtract_Describe.text = @"满减优惠";
    subtract_Describe.textColor = [RegularExpressionsMethod ColorWithHexString:BASELITTLEBLACKCOLOR];
    [self.contentView addSubview:subtract_Describe];
    
    _lab_amount = LabelInit(kMSScreenWith-128, 10, 120, 20);
    _lab_amount.font = PFR16Font;
    _lab_amount.textColor = [RegularExpressionsMethod ColorWithHexString:BASEPINK];
    [self.contentView addSubview:_lab_amount];
    
    UIImageView *line1 = ImageViewInit(0, 40, kMSScreenWith, 1);
    line1.backgroundColor = [RegularExpressionsMethod ColorWithHexString:@"E6E6E6"];
    [self addSubview:line1];
    
    UILabel *lab_hongbaoT = LabelInit(DCMargin, 50, 80, 20);
    lab_hongbaoT.text = @"红包";
    lab_hongbaoT.font = Font(14);
    lab_hongbaoT.textColor = [RegularExpressionsMethod ColorWithHexString:BASEBLACKCOLOR];
    [self.contentView addSubview:lab_hongbaoT];
    
    _lab_hbName = LabelInit(kMSScreenWith-160, 50, 120, 20);
    _lab_hbName.font = PFR14Font;
    _lab_hbName.textColor = [RegularExpressionsMethod ColorWithHexString:BASEPINK];
    _lab_hbName.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_lab_hbName];
    
    
    UIImageView *actionImageView = ImageViewInit(kMSScreenWith-35, 58, 9, 5);
    actionImageView.image = [UIImage imageNamed:@"price_no_down"];
    [self.contentView addSubview:actionImageView];
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
