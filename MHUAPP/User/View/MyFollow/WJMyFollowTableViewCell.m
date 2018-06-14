//
//  WJMyFollowTableViewCell.m
//  MHUAPP
//
//  Created by jinri on 2018/4/12.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import "WJMyFollowTableViewCell.h"
#import "UIView+UIViewFrame.h"
#import <UIImageView+WebCache.h>
#define Follow_Height 100


@implementation WJMyFollowTableViewCell

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
    
    //选中按钮
    self.selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.selectBtn setImage:[UIImage imageNamed:@"user_weigouxuan"] forState:UIControlStateNormal];
    [self.selectBtn setImage:[UIImage imageNamed:@"shipcart_seleHigh"] forState:UIControlStateSelected];
    [self.selectBtn addTarget:self action:@selector(selectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.selectBtn];

    //显示照片
    self.lzImageView = [[UIImageView alloc]init];
    self.lzImageView.backgroundColor = [RegularExpressionsMethod ColorWithHexString:@"F3F3F3"];
    self.lzImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:self.lzImageView];

    //店铺名
    self.lab_name = [[UILabel alloc]init];
    self.lab_name.font = [UIFont systemFontOfSize:13];
    _lab_name.numberOfLines = 2;
    [self.contentView addSubview:self.lab_name];

    //评分
    self.lab_store = [[UILabel alloc]init];
    self.lab_store.textColor = [UIColor redColor];
    self.lab_store.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:self.lab_store];


    //价格
    self.lab_followNum = [[UILabel alloc]init];
    self.lab_followNum.font = [UIFont boldSystemFontOfSize:12];
    self.lab_followNum.textColor = [RegularExpressionsMethod ColorWithHexString:BASEPINK];
    [self.contentView addSubview:self.lab_followNum];

}
#pragma mark - 按钮点击方法
- (void)selectBtnClick:(UIButton*)button {
    button.selected = !button.selected;
     !_WJCellSelectedBlock ? : _WJCellSelectedBlock(button.selected);
}

- (void)setSelectHidden:(BOOL)selectHidden{

    if (selectHidden) {
        _selectBtn.frame = CGRectMake(0, 0, 0, 0);
    }
    else
    {
        _selectBtn.frame = CGRectMake(10, 35, 30, 30);
    }
    _selectHidden = selectHidden;
    _lzImageView.frame = CGRectMake(_selectBtn.Right+10, 10, 70, 70);
    _lab_name.frame = CGRectMake(_lzImageView.Right+DCMargin, 15, kMSScreenWith-35-_lzImageView.width-_selectBtn.width, 40);
    _lab_followNum.frame = CGRectMake(_lzImageView.Right+DCMargin, 60, kMSScreenWith-30-_lzImageView.width, 20);
    
}


-(void)setListModel:(WJFollowClassItem *)listModel
{
    if (listModel!=_listModel) {
        _listModel = listModel;
    }
    [_lzImageView sd_setImageWithURL:[NSURL URLWithString: _listModel.goods.original_img] placeholderImage:[UIImage imageNamed:@"default_nomore.png"] completed:nil];
    _selectBtn.selected = _listModel.select;
    _lab_name.text = _listModel.goods.goods_name;

    _lab_followNum.text =  [NSString stringWithFormat:@"￥%@",ConvertNullString(_listModel.goods.shop_price)];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
