//
//  WJPTPriceCollectionCell.m
//  MHUAPP
//
//  Created by jinri on 2018/5/22.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import "WJPTPriceCollectionCell.h"
#import "UIView+UIViewFrame.h"

@interface WJPTPriceCollectionCell()

/* 数量阶段 */
@property (strong , nonatomic)UILabel *lab_NumScope1;
@property (strong , nonatomic)UILabel *lab_NumScope2;
@property (strong , nonatomic)UILabel *lab_NumScope3;

/* 价格阶段 */
@property (strong , nonatomic)UILabel *lab_PriceScope1;
@property (strong , nonatomic)UILabel *lab_PriceScope2;
@property (strong , nonatomic)UILabel *lab_PriceScope3;
@end


@implementation WJPTPriceCollectionCell


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
    self.backgroundColor = [UIColor clearColor];

    UIImageView *back = ImageViewInit(0, 5, kMSScreenWith, 70);
    back.backgroundColor =kMSCellBackColor;
    [self addSubview:back];

    UILabel *labelNum = LabelInit(DCMargin, 12, 60, 20);
    labelNum.textColor = [RegularExpressionsMethod ColorWithHexString:BASELITTLEBLACKCOLOR];
    labelNum.font = Font(14);
    labelNum.text = @"批发数量";
    [self addSubview:labelNum];

    _lab_NumScope1 = LabelInit(labelNum.Right+30, 12, 60, 20);;
    _lab_NumScope1.font = PFR14Font;
    _lab_NumScope1.textColor = [RegularExpressionsMethod ColorWithHexString:BASELITTLEBLACKCOLOR];
    _lab_NumScope1.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_lab_NumScope1];

    _lab_NumScope2 = LabelInit(_lab_NumScope1.Right+30, 12, 60, 20);
    _lab_NumScope2.font = PFR14Font;
    _lab_NumScope2.textColor = [RegularExpressionsMethod ColorWithHexString:BASELITTLEBLACKCOLOR];
    _lab_NumScope2.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_lab_NumScope2];

    _lab_NumScope3 = LabelInit(_lab_NumScope2.Right+30, 12, 60, 20);;
    _lab_NumScope3.font = PFR14Font;
    _lab_NumScope3.textColor = [RegularExpressionsMethod ColorWithHexString:BASELITTLEBLACKCOLOR];
    _lab_NumScope3.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_lab_NumScope3];


    UIImageView *line = ImageViewInit(DCMargin, 40, kMSScreenWith-DCMargin*2, 1);
    line.backgroundColor = [RegularExpressionsMethod ColorWithHexString:@"E6E6E6"];
    [self addSubview:line];

    UILabel *labelPrice = LabelInit(DCMargin, 47, 60, 20);
    labelPrice.textColor = [RegularExpressionsMethod ColorWithHexString:BASELITTLEBLACKCOLOR];
    labelPrice.font = Font(14);
    labelPrice.text = @"批发价格";
    [self addSubview:labelPrice];

    _lab_PriceScope1 = LabelInit(labelNum.Right+30, 47, 60, 20);
    _lab_PriceScope1.font = PFR14Font;
    _lab_PriceScope1.textColor = [RegularExpressionsMethod ColorWithHexString:BASELITTLEBLACKCOLOR];
    _lab_PriceScope1.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_lab_PriceScope1];

    _lab_PriceScope2 = LabelInit(_lab_NumScope1.Right+30, 47, 60, 20);
    _lab_PriceScope2.font = PFR14Font;
    _lab_PriceScope2.textColor = [RegularExpressionsMethod ColorWithHexString:BASELITTLEBLACKCOLOR];
    _lab_PriceScope2.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_lab_PriceScope2];

    _lab_PriceScope3 = LabelInit(_lab_PriceScope2.Right+30, 47, 60, 20);;
    _lab_PriceScope3.font = PFR14Font;
    _lab_PriceScope3.textColor = [RegularExpressionsMethod ColorWithHexString:BASELITTLEBLACKCOLOR];
    _lab_PriceScope3.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_lab_PriceScope3];
}
-(void)setGroup_numb_one:(NSString *)group_numb_one
{
    _group_numb_one = group_numb_one;
}
-(void)setGroup_numb_two:(NSString *)group_numb_two
{
    _group_numb_two = group_numb_two;
}
-(void)setGroup_numb_three:(NSString *)group_numb_three
{
     _group_numb_three = group_numb_three;
}
-(void)setGroup_price_one:(NSString *)group_price_one
{
     _group_price_one = group_price_one;
}
-(void)setGroup_price_two:(NSString *)group_price_two
{
     _group_price_two = group_price_two;
}
-(void)setGroup_price_three:(NSString *)group_price_three
{
    _group_price_three = group_price_three;

}
- (void)reloadDataAllLabel
{
    _lab_NumScope1.text = [NSString stringWithFormat:@"1-%d",[_group_numb_one intValue]];
    _lab_NumScope2.text = [NSString stringWithFormat:@"%d-%@",[_group_numb_one intValue]+1,_group_numb_two];
    _lab_NumScope3.text = [NSString stringWithFormat:@"%d-%@",[_group_numb_two intValue]+1,_group_numb_three];

    _lab_PriceScope1.text = [NSString stringWithFormat:@"￥%@",_group_price_one];
    _lab_PriceScope2.text = [NSString stringWithFormat:@"￥%@",_group_price_two];
    _lab_PriceScope3.text = [NSString stringWithFormat:@"￥%@",_group_price_three];
}
@end
