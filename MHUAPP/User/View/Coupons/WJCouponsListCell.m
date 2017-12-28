//
//  WJCouponsListCell.m
//  MHUAPP
//
//  Created by jinri on 2017/12/27.
//  Copyright © 2017年 wenchengjun. All rights reserved.
//

#import "WJCouponsListCell.h"
#import "UIView+UIViewFrame.h"

@implementation WJCouponsListCell

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
    self.contentView.backgroundColor = kMSViewBackColor;
    _contentImg = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, self.contentView.height, self.contentView.height-10)];
    [self.contentView addSubview:_contentImg];

    _lab_couponsPrice = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, self.contentView.height, 35)];
    _lab_couponsPrice.backgroundColor = kMSViewTitleColor;
    _lab_couponsPrice.textAlignment = NSTextAlignmentCenter;
    _lab_couponsPrice.font = Font(25);
    [self.contentView addSubview:_lab_couponsPrice];

    _lab_highPrice = [[UILabel alloc] initWithFrame:CGRectMake(15, 50, self.contentView.height-10, 35)];
    _lab_highPrice.textAlignment = NSTextAlignmentRight;
    _lab_highPrice.textColor = kMSViewTitleColor;
    _lab_highPrice.font = Font(14);
    _lab_highPrice.numberOfLines = 2;
    [self.contentView addSubview:_lab_highPrice];

    _lab_type = [[UILabel alloc] initWithFrame:CGRectMake(20+_contentImg.width, 8, kMSScreenWith-30-_contentImg.width, 20)];
    _lab_type.textAlignment = NSTextAlignmentRight;
    _lab_type.textColor = [RegularExpressionsMethod ColorWithHexString:BASELITTLEBLACKCOLOR];
    _lab_type.font = Font(15);
    [self.contentView addSubview:_lab_type];

    _lab_date = [[UILabel alloc] initWithFrame:CGRectMake(20+_contentImg.width, 33, kMSScreenWith-30-_contentImg.width, 20)];
    _lab_date.textAlignment = NSTextAlignmentRight;
    _lab_date.textColor = [RegularExpressionsMethod ColorWithHexString:BASELITTLEBLACKCOLOR];
    _lab_date.font = Font(15);
    [self.contentView addSubview:_lab_date];

    _btn_use = [UIButton buttonWithType:UIButtonTypeCustom];
    _btn_use.frame = CGRectMake(kMSScreenWith-100, 60, 90, 36);
    _btn_use.layer.borderColor = [[UIColor redColor] CGColor];
    _btn_use.layer.borderWidth = 1.0f;
    _btn_use.layer.cornerRadius = 4.0f;
    _btn_use.layer.masksToBounds = YES;
    [self.contentView addSubview:_btn_use];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setListModel:(WJCouponsItem *)listModel
{
    _lab_couponsPrice.text = [NSString stringWithFormat:@"￥%@",@"20"];
    _lab_highPrice.text = [NSString stringWithFormat:@"满%@元可使用",@"300"];
    _lab_type.text = [NSString stringWithFormat:@"商城部分自营可用"];
    _lab_date.text = [NSString stringWithFormat:@"2018-1-31"];
}

@end
