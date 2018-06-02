//
//  WJWAaitForGoodThridTableCell.m
//  MHUAPP
//
//  Created by jinri on 2018/5/30.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import "WJWAaitForGoodThridTableCell.h"
#import "UIView+UIViewFrame.h"


@implementation WJWAaitForGoodThridTableCell

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

    _totalPayPrice = [[UILabel alloc] initWithFrame:CGRectMake(50, 5, kMSScreenWith-60, 20)];
    _totalPayPrice.textColor = [RegularExpressionsMethod ColorWithHexString:BASEBLACKCOLOR];
    _totalPayPrice.font = Font(15);
    _totalPayPrice.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_totalPayPrice];


    UIImageView *imageline = ImageViewInit(0, 60, kMSScreenWith, 3);
    imageline.backgroundColor = [RegularExpressionsMethod ColorWithHexString:kMSVCBackgroundColor];
    [self.contentView addSubview:imageline];

    _lab_orderNo = LabelInit(DCMargin, 60+DCMargin, 220, 20);
    _lab_orderNo.font = PFR14Font;
    _lab_orderNo.textColor = [RegularExpressionsMethod ColorWithHexString:BASEBLACKCOLOR];
    [self.contentView addSubview:_lab_orderNo];

    _lab_add_time = LabelInit(DCMargin, _lab_orderNo.Bottom+4, 220, 20);
    _lab_add_time.font = PFR14Font;
    _lab_add_time.textColor = [RegularExpressionsMethod ColorWithHexString:BASEBLACKCOLOR];
    [self addSubview:_lab_add_time];

    _lab_payTime = LabelInit(DCMargin, _lab_add_time.Bottom+4, 220, 20);
    _lab_payTime.font = PFR14Font;
    _lab_payTime.textColor = [RegularExpressionsMethod ColorWithHexString:BASEBLACKCOLOR];
    [self addSubview:_lab_payTime];

    _lab_shipping_time = LabelInit(DCMargin, _lab_payTime.Bottom+4, 220, 20);
    _lab_shipping_time.font = PFR14Font;
    _lab_shipping_time.textColor = [RegularExpressionsMethod ColorWithHexString:BASEBLACKCOLOR];
    [self addSubview:_lab_shipping_time];

    _lab_pay_name = LabelInit(DCMargin, _lab_shipping_time.Bottom+4, 220, 20);
    _lab_pay_name.font = PFR14Font;
    _lab_pay_name.textColor = [RegularExpressionsMethod ColorWithHexString:BASEBLACKCOLOR];
    [self addSubview:_lab_pay_name];

    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.layer.borderColor = [[RegularExpressionsMethod ColorWithHexString:kGrayBgColor] CGColor];
    btn.layer.borderWidth = 1.0f;
    btn.layer.cornerRadius = 3;
    btn.layer.masksToBounds = YES;//设置圆角
    btn.frame = CGRectMake(kMSScreenWith-80, 60+DCMargin, 70, 28);
    [btn setTitle:@"复制" forState:UIControlStateNormal];
    btn.titleLabel.font = Font(14);
    [btn setTitleColor:[RegularExpressionsMethod ColorWithHexString:BASEBLACKCOLOR] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(copyOrderNo:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:btn];
}
-(void)copyOrderNo:(UIButton *)sender
{
    UIPasteboard *pab = [UIPasteboard generalPasteboard];

    [pab setString:_str_orderNo];

    if (pab == nil) {
        [SVProgressHUD showSuccessWithStatus:@"复制失败"];
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        [SVProgressHUD dismissWithDelay:1.0];

    }else
    {
        [SVProgressHUD showSuccessWithStatus:@"已复制"];
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        [SVProgressHUD dismissWithDelay:1.0];
    }
}
-(void)setStr_orderNo:(NSString *)str_orderNo
{
    _str_orderNo  = str_orderNo;
    self.lab_orderNo.text = [NSString stringWithFormat:@"订单号：%@",str_orderNo];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
