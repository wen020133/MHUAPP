//
//  WJTuiKuanThridTableCell.m
//  MHUAPP
//
//  Created by jinri on 2018/6/20.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import "WJTuiKuanThridTableCell.h"
#import "UIView+UIViewFrame.h"

@implementation WJTuiKuanThridTableCell

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

    NSArray *arr_buttonTitle = [NSArray arrayWithObjects:@"联系客服", nil];
    for (int aa=0; aa<arr_buttonTitle.count; aa++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.layer.borderColor = [[RegularExpressionsMethod ColorWithHexString:BASEBLACKCOLOR] CGColor];
        btn.layer.borderWidth = 1.0f;
        btn.layer.cornerRadius = 3;
        btn.layer.masksToBounds = YES;//设置圆角
        btn.frame = CGRectMake(kMSScreenWith-(70+10)*(aa+1), 35, 70, 28);
        [btn setTitle:[arr_buttonTitle objectAtIndex:aa] forState:UIControlStateNormal];
        btn.titleLabel.font = Font(14);
        [btn setTitleColor:[RegularExpressionsMethod ColorWithHexString:BASEBLACKCOLOR] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(aelesteGoodsInCart:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:btn];
    }


    UIImageView *imageline = ImageViewInit(0, 85, kMSScreenWith, 5);
    imageline.backgroundColor = [RegularExpressionsMethod ColorWithHexString:kMSVCBackgroundColor];
    [self.contentView addSubview:imageline];

    _lab_orderNo = LabelInit(DCMargin, 90+DCMargin, 220, 20);
    _lab_orderNo.font = PFR14Font;
    _lab_orderNo.textColor = [RegularExpressionsMethod ColorWithHexString:BASEBLACKCOLOR];
    [self.contentView addSubview:_lab_orderNo];

    _lab_back_id = LabelInit(DCMargin, _lab_orderNo.Bottom+4, 220, 20);
    _lab_back_id.font = PFR14Font;
    _lab_back_id.textColor = [RegularExpressionsMethod ColorWithHexString:BASEBLACKCOLOR];
    [self.contentView addSubview:_lab_back_id];

    _lab_add_time = LabelInit(DCMargin, _lab_back_id.Bottom+4, 220, 20);
    _lab_add_time.font = PFR14Font;
    _lab_add_time.textColor = [RegularExpressionsMethod ColorWithHexString:BASEBLACKCOLOR];
    [self addSubview:_lab_add_time];

    _lab_postscript = LabelInit(DCMargin, _lab_add_time.Bottom+4, 220, 20);
    _lab_postscript.font = PFR14Font;
    _lab_postscript.textColor = [RegularExpressionsMethod ColorWithHexString:BASEBLACKCOLOR];
    [self addSubview:_lab_postscript];

    _lab_IsShouhuo = LabelInit(DCMargin, _lab_postscript.Bottom+4, 220, 20);
    _lab_IsShouhuo.font = PFR14Font;
    _lab_IsShouhuo.textColor = [RegularExpressionsMethod ColorWithHexString:BASEBLACKCOLOR];
    [self addSubview:_lab_IsShouhuo];

    
    _lab_IsTuihuo = LabelInit(DCMargin, _lab_IsShouhuo.Bottom+4, 220, 20);
    _lab_IsTuihuo.font = PFR14Font;
    _lab_IsTuihuo.textColor = [RegularExpressionsMethod ColorWithHexString:BASEBLACKCOLOR];
    [self addSubview:_lab_IsTuihuo];

    _lab_tuiKuanPrice = LabelInit(DCMargin, _lab_IsTuihuo.Bottom+4, kMSScreenWith-DCMargin*4, 20);
    _lab_tuiKuanPrice.font = PFR14Font;
    _lab_tuiKuanPrice.textColor = [RegularExpressionsMethod ColorWithHexString:BASEBLACKCOLOR];
    [self addSubview:_lab_tuiKuanPrice];

    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.layer.borderColor = [[RegularExpressionsMethod ColorWithHexString:kGrayBgColor] CGColor];
    btn.layer.borderWidth = 1.0f;
    btn.layer.cornerRadius = 3;
    btn.layer.masksToBounds = YES;//设置圆角
    btn.frame = CGRectMake(kMSScreenWith-80, 88+DCMargin, 70, 24);
    [btn setTitle:@"复制" forState:UIControlStateNormal];
    btn.titleLabel.font = Font(14);
    [btn setTitleColor:[RegularExpressionsMethod ColorWithHexString:BASEBLACKCOLOR] forState:UIControlStateNormal];
    btn.tag = 100;
    [btn addTarget:self action:@selector(copyOrderNo:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:btn];

    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.layer.borderColor = [[RegularExpressionsMethod ColorWithHexString:kGrayBgColor] CGColor];
    btn2.layer.borderWidth = 1.0f;
    btn2.layer.cornerRadius = 3;
    btn2.layer.masksToBounds = YES;//设置圆角
    btn2.frame = CGRectMake(kMSScreenWith-80, btn.Bottom+4, 70, 24);
    [btn2 setTitle:@"复制" forState:UIControlStateNormal];
    btn2.titleLabel.font = Font(14);
    [btn2 setTitleColor:[RegularExpressionsMethod ColorWithHexString:BASEBLACKCOLOR] forState:UIControlStateNormal];
    btn2.tag = 1000;
    [btn2 addTarget:self action:@selector(copyOrderNo:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:btn2];
}
-(void)copyOrderNo:(UIButton *)sender
{
    UIPasteboard *pab = [UIPasteboard generalPasteboard];

    if (sender.tag == 100) {
        [pab setString:_str_orderNo];
    }
    else
    {
        [pab setString:_str_back_id];
    }


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
-(void)setStr_back_id:(NSString *)str_back_id
{
    _str_back_id  = str_back_id;
    self.lab_back_id.text = [NSString stringWithFormat:@"退款单号：%@",str_back_id];
}
-(void)aelesteGoodsInCart:(UIButton *)sender
{
    !_ClickdetailStateForStrBlock ? : _ClickdetailStateForStrBlock(sender.titleLabel.text);
}
@end
