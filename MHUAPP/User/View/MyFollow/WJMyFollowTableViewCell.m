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
#define Follow_Height 80


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
    self.lab_name.frame = CGRectMake(self.lzImageView.Right + 10, 3, kMSScreenWith-self.lzImageView.Right-30, 40);
    self.lab_name.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:self.lab_name];

    //属性
    self.lab_New = [[UILabel alloc]init];
    self.lab_New.frame = CGRectMake(self.lzImageView.Right + 10, self.lab_name.Bottom +2, 200, 18);
    self.lab_New.text = @"上新";
    self.lab_New.textColor = kMSCellBackColor;
    self.lab_New.backgroundColor = [RegularExpressionsMethod ColorWithHexString:BASEPINK];
    self.lab_New.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:self.lab_New];

    //评分
    self.lab_store = [[UILabel alloc]init];
    self.lab_store.textColor = [UIColor redColor];
    self.lab_store.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:self.lab_store];


    //价格
    self.lab_followNum = [[UILabel alloc]init];
    self.lab_followNum.font = [UIFont boldSystemFontOfSize:12];
    self.lab_followNum.textColor = [RegularExpressionsMethod ColorWithHexString:kGrayBgColor];
    [self.contentView addSubview:self.lab_followNum];

}
#pragma mark - 按钮点击方法
- (void)selectBtnClick:(UIButton*)button {
    button.selected = !button.selected;
     !_WJCellSelectedBlock ? : _WJCellSelectedBlock(button.selected);
}

#pragma mark - public method
- (void)reloadDataWithModel:(WJFollowClassItem*)item {

    if (self.selectHidden) {
        self.selectBtn.hidden=YES;
        self.lzImageView.frame = CGRectMake(20, 5, Follow_Height - 10, Follow_Height - 10);

    }
    else
    {
         self.selectBtn.hidden = NO;
        self.selectBtn.frame = CGRectMake(20, 25, 30, 30);
        self.lzImageView.frame = CGRectMake(self.selectBtn.Right + 5, 5, Follow_Height - 10, Follow_Height - 10);

    }
    self.selectBtn.layer.cornerRadius = Follow_Height/2 - 5;
    self.selectBtn.layer.masksToBounds = YES;//设置圆角
    [self.lzImageView sd_setImageWithURL:[NSURL URLWithString: item.image] placeholderImage:[UIImage imageNamed:@"ic_no_heardPic.png"]];
    self.lab_name.text = item.goodsName;
    self.lab_New.text = item.attribute;
    self.lab_store.text = item.youhui;
    self.lab_followNum.text = [NSString stringWithFormat:@"%ld",(long)item.count];
    self.selectBtn.selected = item.select;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
