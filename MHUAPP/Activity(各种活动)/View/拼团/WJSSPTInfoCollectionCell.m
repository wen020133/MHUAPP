//
//  WJSSPTInfoCollectionCell.m
//  MHUAPP
//
//  Created by jinri on 2018/5/22.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import "WJSSPTInfoCollectionCell.h"
#import "UIView+UIViewFrame.h"
#import "WJCountdownView.h"

@interface WJSSPTInfoCollectionCell()

/* 商品标题 */
@property (strong , nonatomic)UILabel *goodTitleLabel;
/* 商品价格 */
@property (strong , nonatomic)UILabel *goodPriceLabel;
@property (strong , nonatomic)UILabel *market_priceLabel;

@property (strong , nonatomic)UILabel *lab_soldNum;

@property (strong , nonatomic) WJCountdownView *view_time;

/* 优惠按钮 */
@property (strong , nonatomic)UIButton *preferentialButton;

@end


@implementation WJSSPTInfoCollectionCell

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

    UIImageView *imgblack = ImageViewInit(0, 0, kMSScreenWith, 44);
    imgblack.backgroundColor = [RegularExpressionsMethod ColorWithHexString:@"1A1A1A"];
    [self addSubview:imgblack];

    _goodPriceLabel = [[UILabel alloc] init];
    _goodPriceLabel.font = Font(30);
    _goodPriceLabel.textColor = [UIColor redColor];
    [self addSubview:_goodPriceLabel];
    
    _goodTitleLabel = [[UILabel alloc] init];
    _goodTitleLabel.font = PFR16Font;
    _goodTitleLabel.textColor = [RegularExpressionsMethod ColorWithHexString:@"2B2B2B"];
    _goodTitleLabel.numberOfLines = 0;
    [self addSubview:_goodTitleLabel];

    _market_priceLabel = [[UILabel alloc] init];
    _market_priceLabel.font = PFR12Font;
    _market_priceLabel.contentMode = NSTextAlignmentLeft;
    _market_priceLabel.textColor = [RegularExpressionsMethod ColorWithHexString:kGrayBgColor];
    [self addSubview:_market_priceLabel];

    _lab_soldNum = [[UILabel alloc] init];
    _lab_soldNum.font = PFR14Font;
    _lab_soldNum.contentMode = NSTextAlignmentCenter;
    _lab_soldNum.textColor = [RegularExpressionsMethod ColorWithHexString:BASEPINK];
    [self addSubview:_lab_soldNum];



    [RegularExpressionsMethod dc_setUpAcrossPartingLineWith:self WithColor:[[UIColor lightGrayColor]colorWithAlphaComponent:0.3]];


}
-(void)setEndTimeStr:(NSString *)endTimeStr
{
    _endTimeStr = endTimeStr;
}
#pragma mark - 布局
- (void)assignmentAllLabel
{

    NSString *stringPrice =
    [NSString stringWithFormat:@"¥ %@",_goodPrice];
    _goodPriceLabel.frame = CGRectMake(DCMargin, 6, [RegularExpressionsMethod widthOfString:stringPrice font:Font(30) height:30], 30);
     NSMutableAttributedString *LZString = [[NSMutableAttributedString alloc]initWithString:stringPrice];
    [LZString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:NSMakeRange(0, 2)];
    _goodPriceLabel.attributedText = LZString;

    if (_oldPrice&&_oldPrice.length>0) {
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:_oldPrice
                                                                                attributes:@{NSStrikethroughStyleAttributeName : @(NSUnderlineStyleSingle)}];
    _market_priceLabel.attributedText = attrStr;

    _market_priceLabel.frame = CGRectMake(_goodPriceLabel.Right+DCMargin, 5, 60, 16);
    }
    _lab_soldNum.text =[NSString stringWithFormat:@"已售%@件",_soldNum];
    _lab_soldNum.frame = CGRectMake(_goodPriceLabel.Right+DCMargin, _market_priceLabel.Bottom+2, 80, 20);


    _goodTitleLabel.frame =CGRectMake(DCMargin, 45, kMSScreenWith-DCMargin*2, [RegularExpressionsMethod dc_calculateTextSizeWithText:_goodTitle WithTextFont:16 WithMaxW:kMSScreenWith - DCMargin * 2].height);
    _goodTitleLabel.text = _goodTitle;

    if (_endTimeStr) {
        _view_time = [[WJCountdownView alloc]initWithFrame:CGRectMake(kMSScreenWith-185, 0, 180, 44) withContentTime:_endTimeStr];
        _view_time.backgroundColor = [RegularExpressionsMethod ColorWithHexString:@"1A1A1A"];
        [self addSubview:_view_time];
    }

}
@end
