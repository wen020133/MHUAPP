//
//  WJCollectionTabCell.m
//  MHUAPP
//
//  Created by jinri on 2017/12/29.
//  Copyright © 2017年 wenchengjun. All rights reserved.
//

#import "WJCollectionTabCell.h"
#import "UIView+UIViewFrame.h"
#import <UIImageView+WebCache.h>

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


    _selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_selectBtn setImage:[UIImage imageNamed:@"user_weigouxuan"] forState:UIControlStateNormal];
    [_selectBtn setImage:[UIImage imageNamed:@"shipcart_seleHigh"] forState:UIControlStateSelected];
    [_selectBtn addTarget:self action:@selector(showAlertViewClass:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_selectBtn];

    _img_content = [[UIImageView alloc] init];
//    _img_content.layer.cornerRadius = 35;
    _img_content.contentMode = UIViewContentModeScaleToFill;
    _img_content.layer.masksToBounds = YES;//设置圆角
    _img_content.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:_img_content];


    _lab_title = [[UILabel alloc] init];
    _lab_title.textColor = [RegularExpressionsMethod ColorWithHexString:BASEBLACKCOLOR];
    _lab_title.font = Font(15);
    [self.contentView addSubview:_lab_title];

    _lab_num = [[UILabel alloc] init];
    _lab_num.textColor = [RegularExpressionsMethod ColorWithHexString:BASELITTLEBLACKCOLOR];
    _lab_num.font = Font(15);
    [self.contentView addSubview:_lab_num];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setSelectIsHidden:(BOOL)selectIsHidden {

    if (selectIsHidden) {
        _selectBtn.frame = CGRectMake(0, 0, 0, 0);
    }
    else
    {
        _selectBtn.frame = CGRectMake(10, 35, 30, 30);
    }
    _selectIsHidden = selectIsHidden;
    _img_content.frame = CGRectMake(_selectBtn.Right+10, 10, 70, 70);
    _lab_title.frame = CGRectMake(_img_content.Right+DCMargin, 15, kMSScreenWith-35-_img_content.width-_selectBtn.width, 20);
    _lab_num.frame = CGRectMake(_img_content.Right+DCMargin, 60, kMSScreenWith-30-_img_content.width, 20);
}

#pragma mark - 按钮点击方法
- (void)showAlertViewClass:(UIButton*)button {
    button.selected = !button.selected;

    if (_moreShareCanceBlock) {
        _moreShareCanceBlock(button.selected);
    }
}

-(void)setListModel:(WJCollectionItem *)listModel
{
    if (listModel!=_listModel) {
        _listModel = listModel;
    }
    [_img_content sd_setImageWithURL:[NSURL URLWithString:_listModel.logo] placeholderImage:[UIImage imageNamed:@"default_nomore.png"] completed:nil];
    _selectBtn.selected = _listModel.select;
    _lab_title.text = _listModel.supplier_name;

    _lab_num.text =  [NSString stringWithFormat:@"%@人已关注",_listModel.num];
}

@end
