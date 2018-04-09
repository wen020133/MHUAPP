//
//  WJMyStoreTableCell.m
//  MHUAPP
//
//  Created by jinri on 2018/4/8.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import "WJMyStoreTableCell.h"
#import "UIView+UIViewFrame.h"
#import <UIImageView+WebCache.h>

@implementation WJMyStoreTableCell

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

    _lab_title = [[UILabel alloc] initWithFrame:CGRectMake(_contentImg.Right+5, 10, kMSScreenWith-self.contentView.height-80, 20)];
    _lab_title.backgroundColor = [RegularExpressionsMethod ColorWithHexString:BASEBLACKCOLOR];
    _lab_title.textAlignment = NSTextAlignmentLeft;
    _lab_title.font = Font(16);
    [self.contentView addSubview:_lab_title];

    _lab_type = [[UILabel alloc] initWithFrame:CGRectMake(_contentImg.Right+5, 35, _lab_title.width/2, 20)];
    _lab_type.textColor = [RegularExpressionsMethod ColorWithHexString:BASEBLACKCOLOR];
    _lab_type.font = Font(12);
    [self.contentView addSubview:_lab_type];

    _lab_time = [[UILabel alloc] initWithFrame:CGRectMake(_lab_type.Right+2, 35, _lab_title.width/2-2, 20)];
    _lab_time.textColor = [RegularExpressionsMethod ColorWithHexString:BASELITTLEBLACKCOLOR];
    _lab_time.font = Font(12);
    [self.contentView addSubview:_lab_time];

    _lab_Num = [[UILabel alloc] initWithFrame:CGRectMake(_lab_title.Right+5, 10, 50, self.contentView.height-20)];
    _lab_Num.textAlignment = NSTextAlignmentRight;
    _lab_Num.font = Font(20);
    [self.contentView addSubview:_lab_Num];

}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
