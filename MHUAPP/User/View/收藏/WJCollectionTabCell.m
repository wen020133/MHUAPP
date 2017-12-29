//
//  WJCollectionTabCell.m
//  MHUAPP
//
//  Created by jinri on 2017/12/29.
//  Copyright © 2017年 wenchengjun. All rights reserved.
//

#import "WJCollectionTabCell.h"
#import "UIView+UIViewFrame.h"


@implementation WJCollectionTabCell

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
    self.contentView.backgroundColor = [RegularExpressionsMethod ColorWithHexString:kMSVCBackgroundColor];
    UIImageView *imgV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 2, kMSScreenWith, 95)];
    imgV.backgroundColor = kMSViewBackColor;
    [self.contentView addSubview:imgV];

    _img_content = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 80, 80)];
    _img_content.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:_img_content];


    _lab_title = [[UILabel alloc] initWithFrame:CGRectMake(20+_img_content.width, 8, kMSScreenWith-30-_img_content.width, 20)];
    _lab_title.textAlignment = NSTextAlignmentRight;
    _lab_title.textColor = [RegularExpressionsMethod ColorWithHexString:BASELITTLEBLACKCOLOR];
    _lab_title.font = Font(15);
    [self.contentView addSubview:_lab_title];

    _lab_price = [[UILabel alloc] initWithFrame:CGRectMake(20+_img_content.width, 33, kMSScreenWith-30-_img_content.width, 20)];
    _lab_price.textAlignment = NSTextAlignmentRight;
    _lab_price.textColor = [UIColor redColor];
    _lab_price.font = Font(15);
    [self.contentView addSubview:_lab_price];

    _btn_use = [UIButton buttonWithType:UIButtonTypeCustom];
    _btn_use.frame = CGRectMake(kMSScreenWith-100, 63, 90, 30);
    _btn_use.layer.borderColor = [[UIColor redColor] CGColor];
    _btn_use.layer.borderWidth = 1.0f;
    _btn_use.layer.cornerRadius = 14.0f;
    _btn_use.layer.masksToBounds = YES;
    [self.contentView addSubview:_btn_use];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setListModel:(WJCollectionItem *)listModel
{
    _lab_title.text = [NSString stringWithFormat:@"￥%@",@"20"];
    _lab_price.text = [NSString stringWithFormat:@"满%@元可使用",@"300"];
}

@end
