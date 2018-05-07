//
//  WJPayFristTableViewCell.m
//  MHUAPP
//
//  Created by jinri on 2018/5/7.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import "WJPayFristTableViewCell.h"

@implementation WJPayFristTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
#pragma mark - Intial
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        [self setUpUI];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setUpUI
{

    UILabel *labquerenzhifu = LabelInit(DCMargin, DCMargin, 100, 20);
    labquerenzhifu.font = Font(15);
    labquerenzhifu.text = @"确认支付：";
    labquerenzhifu.textColor = [RegularExpressionsMethod ColorWithHexString:BASEBLACKCOLOR];
    [self.contentView addSubview:labquerenzhifu];

    _lab_price = LabelInit(kMSScreenWith/2-100, 30, 200, 30);
    _lab_price.font = Font(20);
    _lab_price.textAlignment = NSTextAlignmentCenter;
    _lab_price.textColor = [RegularExpressionsMethod ColorWithHexString:BASEBLACKCOLOR];
    [self.contentView addSubview:_lab_price];

    UIButton *saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    saveButton.frame = CGRectMake(kMSScreenWith-35, DCMargin, 25, 25);
    [saveButton setImage:[UIImage imageNamed:@"user_close"] forState:UIControlStateNormal];
    [saveButton addTarget:self action:@selector(closeImage) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:saveButton];

    [RegularExpressionsMethod dc_setUpAcrossPartingLineWith:self WithColor:[[UIColor lightGrayColor]colorWithAlphaComponent:0.3]];
}

-(void)closeImage
{
     !_colsePayView ? : _colsePayView();
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
