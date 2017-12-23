//
//  WJOrderListCell.m
//  MHUAPP
//
//  Created by jinri on 2017/12/22.
//  Copyright © 2017年 wenchengjun. All rights reserved.
//

#import "WJOrderListCell.h"
#import "UIView+UIViewFrame.h"
#import <UIImageView+WebCache.h>

@implementation WJOrderListCell

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
    _contentImg = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, self.contentView.height-10, self.contentView.height-10)];
    [self.contentView addSubview:_contentImg];

    _title = [[UILabel alloc] init];
    _title.backgroundColor = [RegularExpressionsMethod ColorWithHexString:BASEBLACKCOLOR];
    _title.numberOfLines = 2;
    _title.textAlignment = NSTextAlignmentLeft;
    _title.font = Font(16);
    [self.contentView addSubview:_title];

    _price = [[UILabel alloc] init];
    _price.textAlignment = NSTextAlignmentRight;
    _price.textColor = [RegularExpressionsMethod ColorWithHexString:BASEBLACKCOLOR];
    _price.font = Font(15);
    [self.contentView addSubview:_price];

    _oldprice = [[UILabel alloc] init];
    _oldprice.textAlignment = NSTextAlignmentRight;
    _oldprice.textColor = [RegularExpressionsMethod ColorWithHexString:BASELITTLEBLACKCOLOR];
    _oldprice.font = Font(15);
    [self.contentView addSubview:_oldprice];

    _Num = [[UILabel alloc] init];
    _Num.textAlignment = NSTextAlignmentRight;
    _Num.textColor = [RegularExpressionsMethod ColorWithHexString:BASELITTLEBLACKCOLOR];
    _Num.font = Font(15);
    [self.contentView addSubview:_Num];

    _type = [[UILabel alloc] init];
    _type.textColor = [RegularExpressionsMethod ColorWithHexString:BASELITTLEBLACKCOLOR];
    [self.contentView addSubview:_type];
}
-(void)setListModel:(WJOrderListItem *)listModel
{
    if (listModel!=_listModel) {
        _listModel = listModel;
    }
    [_contentImg sd_setImageWithURL:[NSURL URLWithString:_listModel.str_url] placeholderImage:[UIImage imageNamed:@"placeholder.jpg"] completed:nil];

    NSString *price = [NSString stringWithFormat:@"￥%@",_listModel.price];
    CGFloat width = [RegularExpressionsMethod widthOfString:price font:Font(15) height:23];
    _price.frame = CGRectMake(self.contentView.width-width-10, 5, width, 23);
    _price.text = price;

    NSString *oldprice = [NSString stringWithFormat:@"￥%@",_listModel.oldPrice];
    CGFloat oldwidth = [RegularExpressionsMethod widthOfString:oldprice font:Font(15) height:20];
    _oldprice.frame = CGRectMake(self.contentView.width-oldwidth-10, _price.Bottom+10, oldwidth, 20);
    _oldprice.text = oldprice;

    _title.text = _listModel.title;
    CGSize sizeTitle =  [RegularExpressionsMethod dc_calculateTextSizeWithText:_listModel.title WithTextFont:16 WithMaxW:self.contentView.width - DCMargin * 4-self.contentView.height-oldwidth];
    _title.frame = CGRectMake(self.contentView.height+15, 5, sizeTitle.width, sizeTitle.height);

    NSString *saleCount = [NSString stringWithFormat:@"规格%@大号",_listModel.type];
    _type.text  = saleCount;
    _type.frame = CGRectMake(self.contentView.height+15, _title.Bottom+5, _title.width, 20);

    _Num.frame = CGRectMake(self.contentView.width-oldwidth-10, _oldprice.Bottom+5, oldwidth, 20);
    _Num.text =  [NSString stringWithFormat:@"x%@",_listModel.Num];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
