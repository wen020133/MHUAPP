//
//  WJWriteListTableCell.m
//  MHUAPP
//
//  Created by jinri on 2018/4/29.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import "WJWriteListTableCell.h"
#import "UIView+UIViewFrame.h"
#import <UIImageView+WebCache.h>


@implementation WJWriteListTableCell

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
    self.backgroundColor = kMSCellBackColor;
    
    _contentImg = [[UIImageView alloc] initWithFrame:CGRectMake(DCMargin, 5, TAG_Height-10, TAG_Height-10)];
    [self addSubview:_contentImg];

    _title = [[UILabel alloc] init];
    _title.textColor = [RegularExpressionsMethod ColorWithHexString:BASEBLACKCOLOR];
    _title.numberOfLines = 2;
    _title.textAlignment = NSTextAlignmentLeft;
    _title.font = Font(16);
    [self addSubview:_title];

    _price = [[UILabel alloc] init];
    _price.textAlignment = NSTextAlignmentRight;
    _price.textColor = [RegularExpressionsMethod ColorWithHexString:BASEBLACKCOLOR];
    _price.font = Font(15);
    [self addSubview:_price];

    _oldprice = [[UILabel alloc] init];
    _oldprice.textAlignment = NSTextAlignmentRight;
    _oldprice.textColor = [RegularExpressionsMethod ColorWithHexString:BASELITTLEBLACKCOLOR];
    _oldprice.font = Font(13);
    [self addSubview:_oldprice];

    _Num = [[UILabel alloc] init];
    _Num.textAlignment = NSTextAlignmentRight;
    _Num.textColor = [RegularExpressionsMethod ColorWithHexString:BASELITTLEBLACKCOLOR];
    _Num.font = Font(15);
    [self addSubview:_Num];

    _type = [[UILabel alloc] init];
    _type.textColor = [RegularExpressionsMethod ColorWithHexString:BASELITTLEBLACKCOLOR];
    _type.font = Font(12);
    [self addSubview:_type];

    self.imageLine = ImageViewInit(self.contentImg.Right + 5, 0, kMSScreenWith-self.contentImg.Right -15, 1);
    self.imageLine.backgroundColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.4];
    [self addSubview:self.imageLine];
}
-(void)setListModel:(WJCartGoodsModel *)listModel
{
    if (listModel!=_listModel) {
        _listModel = listModel;
    }
    [_contentImg sd_setImageWithURL:[NSURL URLWithString:_listModel.img] placeholderImage:[UIImage imageNamed:@"default_nomore.png"] completed:nil];
    NSString *price = @"";
    if ([_listModel.is_group_buy integerValue]==2) {
        price = [NSString stringWithFormat:@"%@积分",_listModel.count_price];
    }
    else
    {
        price = [NSString stringWithFormat:@"￥%@",_listModel.goods_price];

    }
    CGFloat width = [RegularExpressionsMethod widthOfString:price font:Font(15) height:23];
    _price.frame = CGRectMake(kMSScreenWith-width-10, 5, width, 23);
    _price.text = price;

    NSString *oldprice = [NSString stringWithFormat:@"￥%@",_listModel.market_price];
    _oldprice.frame = CGRectMake(kMSScreenWith-width-15, _price.Bottom+5, width+5, 20);
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:oldprice
                                                                                attributes:@{NSStrikethroughStyleAttributeName : @(NSUnderlineStyleSingle)}];
    _oldprice.attributedText = attrStr;

    _title.text = _listModel.goods_name;
    _title.frame = CGRectMake(TAG_Height+15, 5, kMSScreenWith- DCMargin * 4-TAG_Height-width, 40);

    NSString *saleCount = [NSString stringWithFormat:@"%@",_listModel.goods_attr];
    _type.text  = saleCount;
    _type.frame = CGRectMake(TAG_Height+15, _title.Bottom+5, _title.width, 20);

    _Num.frame =CGRectMake(kMSScreenWith-width-10, _oldprice.Bottom+5, width, 20);
    _Num.text =  [NSString stringWithFormat:@"x%ld",_listModel.goods_number];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
