//
//  WJMoneyListTableCell.m
//  MHUAPP
//
//  Created by wenchengjun on 2018/7/31.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import "WJMoneyListTableCell.h"
#import "UIView+UIViewFrame.h"



@implementation WJMoneyListTableCell

#pragma mark - Intial
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        [self setUpUI];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}


-(void)setUpUI
{
        self.backgroundColor = kMSCellBackColor;
    
        _img_content = [[UIImageView alloc]initWithFrame:CGRectMake(DCMargin, 11, 58, 58)];
        _img_content.backgroundColor = kMSCellBackColor;
        _img_content.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:_img_content];

        _lab_accountType = [[UILabel alloc]initWithFrame:CGRectMake(_img_content.Right+DCMargin, 13, 120, 20)];
        _lab_accountType.font = PFR13Font;
        _lab_accountType.textColor = [RegularExpressionsMethod ColorWithHexString:BASEBLACKCOLOR];
        _lab_accountType.textAlignment = NSTextAlignmentLeft;
        _lab_accountType.text = @"分销提现到--微信";
        [self.contentView addSubview:_lab_accountType];


        _lab_price= [[UILabel alloc]initWithFrame:CGRectMake(_lab_accountType.Right+DCMargin, 13, 120, 20)];
        _lab_price.font = PFR13Font;
        _lab_price.textColor = [RegularExpressionsMethod ColorWithHexString:BASEPINK];
        _lab_price.text = @"￥1000.00";
        _lab_price.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_lab_price];
        
        _lab_date = [[UILabel alloc]initWithFrame:CGRectMake(_img_content.Right+DCMargin, 47, 200, 20)];
        _lab_date.font = PFR12Font;
        _lab_date.textColor = [RegularExpressionsMethod ColorWithHexString:BASELITTLEBLACKCOLOR];
        _lab_date.text = @"2018-1-1 45:44:10";
        _lab_date.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_lab_date];
        
        _lab_state = [[UILabel alloc]initWithFrame:CGRectMake(kMSScreenWith-60, 30, 50, 20)];
        _lab_state.font = PFR13Font;
        _lab_state.textColor = [RegularExpressionsMethod ColorWithHexString:BASELITTLEBLACKCOLOR];
        _lab_state.text = @"已完成";
        _lab_state.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_lab_state];
        
        [RegularExpressionsMethod dc_setUpAcrossPartingLineWith:self WithColor:[[UIColor lightGrayColor]colorWithAlphaComponent:0.3]];
}

-(void)setModel:(WJMoneyListItem *)model
{
    if (model!=_model) {
    _model = model;
    }
    if ([_model.ewm_type integerValue]==2) {
        _img_content.image = [UIImage imageNamed:@"login_weixin.png"];
        _lab_accountType.text = [NSString stringWithFormat: @"分销提现到--微信"];
    }
    else
    {
        _img_content.image = [UIImage imageNamed:@"login_zfb.png"];
        _lab_accountType.text = [NSString stringWithFormat: @"分销提现到--支付宝"];
    }
    _lab_price.text = [NSString stringWithFormat:@"￥%@", _model.amount];
    _lab_date.text = [NSString stringWithFormat:@"申请时间：%@", _model.add_time];
    if ([_model.is_paid integerValue]==1) {
        _lab_state.text = [NSString stringWithFormat: @"已完成"];
    }
    else
    {
        _lab_state.text = [NSString stringWithFormat: @"待审核"];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
