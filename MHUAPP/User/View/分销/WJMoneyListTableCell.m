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

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = kMSCellBackColor;
    
        
        _lab_price= [[UILabel alloc]initWithFrame:CGRectMake(DCMargin, 10, kMSScreenWith-40, 20)];
        _lab_price.font = PFR13Font;
        _lab_price.textColor = [RegularExpressionsMethod ColorWithHexString:BASEBLACKCOLOR];
        _lab_price.text = @"减少：￥1000.00";
        _lab_price.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_lab_price];
        
        _lab_date = [[UILabel alloc]initWithFrame:CGRectMake(DCMargin, _lab_price.Bottom+10, kMSScreenWith-40, 20)];
        _lab_date.font = PFR11Font;
        _lab_date.textColor = [RegularExpressionsMethod ColorWithHexString:BASELITTLEBLACKCOLOR];
        _lab_date.text = @"2018-1-1";
        _lab_date.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_lab_date];
        
        _lab_num = [[UILabel alloc]initWithFrame:CGRectMake(DCMargin, _lab_date.Bottom+10, kMSScreenWith-40, 20)];
        _lab_num.font = PFR13Font;
        _lab_num.textColor = [RegularExpressionsMethod ColorWithHexString:BASELITTLEBLACKCOLOR];
        _lab_num.textAlignment = NSTextAlignmentLeft;
        _lab_num.text = @"支付订单 201819928888";
        [self.contentView addSubview:_lab_num];
        
        [RegularExpressionsMethod dc_setUpAcrossPartingLineWith:self WithColor:[[UIColor lightGrayColor]colorWithAlphaComponent:0.3]];
    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
