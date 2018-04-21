//
//  WJDetailGoodReferral_m
//  MHUAPP
//
//  Created by jinri on 2017/12/4.
//  Copyright © 2017年 wenchengjun. All rights reserved.
//

#import "WJDetailGoodReferralCell.h"
#import "UIView+UIViewFrame.h"



@implementation WJDetailGoodReferralCell

#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {

    self = [super initWithFrame:frame];
    if (self) {

        [self setUpUI];
    }
    return self;
}

#pragma mark - UI
- (void)setUpUI
{
    self.backgroundColor = [UIColor whiteColor];

    _goodTitleLabel = [[UILabel alloc] init];
    _goodTitleLabel.font = PFR16Font;
    _goodPriceLabel.textColor = [RegularExpressionsMethod ColorWithHexString:@"2B2B2B"];
    _goodTitleLabel.numberOfLines = 0;
    [self addSubview:_goodTitleLabel];

    _goodPriceLabel = [[UILabel alloc] init];
    _goodPriceLabel.font = PFR20Font;
    _goodPriceLabel.textColor = [UIColor redColor];
    [self addSubview:_goodPriceLabel];

    _market_priceLabel = [[UILabel alloc] init];
    _market_priceLabel.font = PFR12Font;
    _market_priceLabel.contentMode = NSTextAlignmentLeft;
    _market_priceLabel.textColor = [RegularExpressionsMethod ColorWithHexString:kGrayBgColor];
    [self addSubview:_market_priceLabel];

    _lab_soldNum = [[UILabel alloc] init];
    _lab_soldNum.font = PFR12Font;
    _lab_soldNum.contentMode = NSTextAlignmentCenter;
    _lab_soldNum.textColor = [RegularExpressionsMethod ColorWithHexString:kGrayBgColor];
    [self addSubview:_lab_soldNum];

    _lab_address = [[UILabel alloc] init];
    _lab_address.font = PFR12Font;
    _lab_address.contentMode = NSTextAlignmentRight;
    _lab_address.textColor = [RegularExpressionsMethod ColorWithHexString:kGrayBgColor];;
    [self addSubview:_lab_address];


    [RegularExpressionsMethod dc_setUpAcrossPartingLineWith:self WithColor:[[UIColor lightGrayColor]colorWithAlphaComponent:0.3]];


}
#pragma mark - 布局
- (void)assignmentAllLabel
{
    _goodTitleLabel.frame =CGRectMake(DCMargin, 2, kMSScreenWith-DCMargin*2, [RegularExpressionsMethod dc_calculateTextSizeWithText:_goodTitle WithTextFont:16 WithMaxW:kMSScreenWith - DCMargin * 2].height);
    _goodTitleLabel.text = _goodTitle;

//    [RegularExpressionsMethod dc_setUpLabel:cell.goodTitleLabel Content:_goodTitle IndentationFortheFirstLineWith:cell.goodPriceLabel.font.pointSize * 2];


    _goodPriceLabel.text = [NSString stringWithFormat:@"¥%@",_goodPrice];
    _goodPriceLabel.frame = CGRectMake(DCMargin, _goodTitleLabel.Bottom+2, [RegularExpressionsMethod widthOfString:_goodPriceLabel.text font:Font(20) height:30], 30);

    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:_oldPrice
                                                                                attributes:@{NSStrikethroughStyleAttributeName : @(NSUnderlineStyleSingle)}];
    _market_priceLabel.attributedText = attrStr;

    _market_priceLabel.frame = CGRectMake(_goodPriceLabel.Right, _goodTitleLabel.Bottom+12, 60, 20);

   _lab_soldNum.text =[NSString stringWithFormat:@"已售100%@",@"1"];
    _lab_soldNum.frame = CGRectMake(kMSScreenWith/2-40, _goodTitleLabel.Bottom+12, 80, 20);
   _lab_address.text =@"广东 深圳";
   _lab_address.frame = CGRectMake(kMSScreenWith-100, _goodTitleLabel.Bottom+12, 80, 20);

}

@end
