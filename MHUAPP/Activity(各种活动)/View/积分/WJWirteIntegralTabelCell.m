//
//  WJWirteIntegralTabelCell.m
//  MHUAPP
//
//  Created by wenchengjun on 2018/5/18.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import "WJWirteIntegralTabelCell.h"
#import "UIView+UIViewFrame.h"
#import <UIImageView+WebCache.h>

@implementation WJWirteIntegralTabelCell

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
    _contentImg = [[UIImageView alloc] initWithFrame:CGRectMake(DCMargin, 5, TAG_Height-10, TAG_Height-10)];
    [self.contentView addSubview:_contentImg];
    
    _lab_title = [[UILabel alloc] init];
    _lab_title.textColor = [RegularExpressionsMethod ColorWithHexString:BASEBLACKCOLOR];
    _lab_title.numberOfLines = 2;
    _lab_title.textAlignment = NSTextAlignmentLeft;
    _lab_title.font = Font(16);
    [self.contentView addSubview:_lab_title];
    
    _lab_price = [[UILabel alloc] init];
    _lab_price.textAlignment = NSTextAlignmentRight;
    _lab_price.textColor = [RegularExpressionsMethod ColorWithHexString:BASEPINK];
    _lab_price.font = Font(15);
    [self.contentView addSubview:_lab_price];
        
    _lab_type = [[UILabel alloc] init];
    _lab_type.textColor = [RegularExpressionsMethod ColorWithHexString:BASELITTLEBLACKCOLOR];
    _lab_type.font = Font(12);
    [self.contentView addSubview:_lab_type];
    
}
-(void)setListModel:(WJJRPTItem *)listModel
{
    if (listModel!=_listModel) {
        _listModel = listModel;
    }
    NSString *urlStr = [NSString stringWithFormat:@"%@",_listModel.goods_thumb] ;
    [_contentImg sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:@"default_nomore.png"] completed:nil];
    _lab_title.text = _listModel.goods_name;
    CGSize sizeTitle =  [RegularExpressionsMethod dc_calculateTextSizeWithText:_listModel.goods_name WithTextFont:16 WithMaxW:kMSScreenWith- DCMargin * 4-TAG_Height];
    _lab_title.frame = CGRectMake(TAG_Height+15, 5, sizeTitle.width, sizeTitle.height);
    _lab_price.text = [NSString stringWithFormat:@"%@积分",_listModel.integral];
    _lab_price.frame = CGRectMake(kMSScreenWith-100, _lab_title.Bottom +5, 80, 23);
    _lab_type.frame = CGRectMake(TAG_Height+15, _lab_title.Bottom +5, 80, 23);
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
