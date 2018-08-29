//
//  WJMyFenXiaoOrderItemCell.m
//  MHUAPP
//
//  Created by wenchengjun on 2018/8/20.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import "WJMyFenXiaoOrderItemCell.h"
#import "UIView+UIViewFrame.h"               //heifht 100
#define  LabelWidth  kMSScreenWith/4


@implementation WJMyFenXiaoOrderItemCell

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = kMSCellBackColor;
        
    _lab_orderNo= [[UILabel alloc]initWithFrame:CGRectMake(0, DCMargin, LabelWidth, 28)];
        _lab_orderNo.font = PFR13Font;
        _lab_orderNo.textColor = [RegularExpressionsMethod ColorWithHexString:BASEBLACKCOLOR];
        _lab_orderNo.textAlignment = NSTextAlignmentCenter;
        _lab_orderNo.text = @"订单号";
        [self.contentView addSubview:_lab_orderNo];
        
        _lab_yongjin= [[UILabel alloc]initWithFrame:CGRectMake(LabelWidth, DCMargin, LabelWidth, 28)];
        _lab_yongjin.font = PFR13Font;
        _lab_yongjin.textColor = [RegularExpressionsMethod ColorWithHexString:BASEBLACKCOLOR];
        _lab_yongjin.text = @"现金分成";
        _lab_yongjin.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_lab_yongjin];
        
        _lab_name = [[UILabel alloc]initWithFrame:CGRectMake(LabelWidth*2, DCMargin, LabelWidth, 28)];
        _lab_name.font = PFR13Font;
        _lab_name.textColor = [RegularExpressionsMethod ColorWithHexString:BASEBLACKCOLOR];
        _lab_name.text = @"下单人";
        _lab_name.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_lab_name];
        
        _lab_orderState = [[UILabel alloc]initWithFrame:CGRectMake(LabelWidth*3, DCMargin, LabelWidth, 28)];
        _lab_orderState.font = PFR13Font;
        _lab_orderState.textColor = [RegularExpressionsMethod ColorWithHexString:BASEBLACKCOLOR];
        _lab_orderState.textAlignment = NSTextAlignmentCenter;
        _lab_orderState.text = @"分成状态";
        [self.contentView addSubview:_lab_orderState];
        
       
        [RegularExpressionsMethod dc_setUpAcrossPartingLineWith:self WithColor:[[UIColor lightGrayColor]colorWithAlphaComponent:0.3]];
        
    }
    return self;
}

-(void)setModel:(WJDetailListFenxiao *)model
{
    if (model!=_model) {
        _model = model;
    }
    _lab_orderNo.font = _lab_yongjin.font =_lab_name.font =_lab_orderState.font = PFR11Font;
    _lab_orderNo.text = [RegularExpressionsMethod hiddenAccountMiddleRange:_model.order_sn];
    _lab_yongjin.text = [NSString stringWithFormat:@"￥%@",_model.split_money];
    _lab_name.text = [NSString stringWithFormat:@"%@",_model.user_name];
   
    switch ([_model.is_separate integerValue]) {
        case 0:
             _lab_orderState.text = @"未分成";
            break;
        case 1:
            _lab_orderState.text = @"已分成";
            break;
        default:
            _lab_orderState.text = @"等待处理";
            break;
    }
}
@end
