//
//  WJCartTableViewCell.m
//  MHUAPP
//
//  Created by jinri on 2018/1/25.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import "WJCartTableViewCell.h"
#import "WJCartGoodsModel.h"
#import "UIView+UIViewFrame.h"

@interface WJCartTableViewCell ()
{
    LZNumberChangedBlock numberAddBlock;
    LZNumberChangedBlock numberCutBlock;
    LZCellSelectedBlock cellSelectedBlock;
}
//选中按钮
@property (nonatomic,retain) UIButton *selectBtn;
//显示照片
@property (nonatomic,retain) UIImageView *lzImageView;
//商品名
@property (nonatomic,retain) UILabel *nameLabel;
//尺寸
@property (nonatomic,retain) UILabel *sizeLabel;
//时间
@property (nonatomic,retain) UILabel *dateLabel;
//价格
@property (nonatomic,retain) UILabel *priceLabel;
//数量
@property (nonatomic,retain)UILabel *numberLabel;

@end


@implementation WJCartTableViewCell




- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = kMSCellBackColor;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupMainView];
    }
    return self;
}
#pragma mark - public method
- (void)reloadDataWithModel:(WJCartGoodsModel*)model {

    self.lzImageView.image = model.image;
    self.nameLabel.text = model.goodsName;
    self.priceLabel.text = model.price;
    self.dateLabel.text = model.price;
    self.numberLabel.text = [NSString stringWithFormat:@"%ld",(long)model.count];
    self.selectBtn.selected = model.select;
}

- (void)numberAddWithBlock:(LZNumberChangedBlock)block {
    numberAddBlock = block;
}

- (void)numberCutWithBlock:(LZNumberChangedBlock)block {
    numberCutBlock = block;
}

- (void)cellSelectedWithBlock:(LZCellSelectedBlock)block {
    cellSelectedBlock = block;
}
#pragma mark - 重写setter方法
- (void)setLzNumber:(NSInteger)lzNumber {
    _lzNumber = lzNumber;

    self.numberLabel.text = [NSString stringWithFormat:@"%ld",(long)lzNumber];
}

- (void)setLzSelected:(BOOL)lzSelected {
    _lzSelected = lzSelected;
    self.selectBtn.selected = lzSelected;
}
#pragma mark - 按钮点击方法
- (void)selectBtnClick:(UIButton*)button {
    button.selected = !button.selected;

    if (cellSelectedBlock) {
        cellSelectedBlock(button.selected);
    }
}

- (void)addBtnClick:(UIButton*)button {

    NSInteger count = [self.numberLabel.text integerValue];
    count++;

    if (numberAddBlock) {
        numberAddBlock(count);
    }
}

- (void)cutBtnClick:(UIButton*)button {
    NSInteger count = [self.numberLabel.text integerValue];
    count--;
    if(count <= 0){
        return ;
    }

    if (numberCutBlock) {
        numberCutBlock(count);
    }
}
#pragma mark - 布局主视图
-(void)setupMainView {
    //白色背景
    UIView *bgView = [[UIView alloc]init];
    bgView.frame = CGRectMake(10, 10, kMSScreenWith - 20, 100 - 10);
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.layer.borderColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.4].CGColor;
    bgView.layer.borderWidth = 1;
    [self addSubview:bgView];

    //选中按钮
    UIButton* selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    selectBtn.center = CGPointMake(20, bgView.height/2.0);
    selectBtn.bounds = CGRectMake(0, 0, 30, 30);
    [selectBtn setImage:[UIImage imageNamed:@"user_weigouxuan"] forState:UIControlStateNormal];
    [selectBtn setImage:[UIImage imageNamed:@"shipcart_seleHigh"] forState:UIControlStateSelected];
    [selectBtn addTarget:self action:@selector(selectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:selectBtn];
    self.selectBtn = selectBtn;

    //照片背景
    UIView *imageBgView = [[UIView alloc]init];
    imageBgView.frame = CGRectMake(selectBtn.Right + 5, 5, bgView.height - 10, bgView.height - 10);
    imageBgView.backgroundColor = [RegularExpressionsMethod ColorWithHexString:@"F3F3F3"];
    [bgView addSubview:imageBgView];

    //显示照片
    UIImageView* imageView = [[UIImageView alloc]init];
    imageView.image = [UIImage imageNamed:@"default_pic_1"];
    imageView.frame = CGRectMake(imageBgView.x + 5, imageBgView.y + 5, imageBgView.width - 10, imageBgView.height - 10);
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [bgView addSubview:imageView];
    self.lzImageView = imageView;

    CGFloat width = (bgView.width - imageBgView.Right - 30)/2.0;
    //价格
    UILabel* priceLabel = [[UILabel alloc]init];
    priceLabel.frame = CGRectMake(bgView.width - width - 10, 10, width, 30);
    priceLabel.font = [UIFont boldSystemFontOfSize:16];
    priceLabel.textColor = [RegularExpressionsMethod ColorWithHexString:BASEPINK];
    priceLabel.textAlignment = NSTextAlignmentRight;
    [bgView addSubview:priceLabel];
    self.priceLabel = priceLabel;

    //商品名
    UILabel* nameLabel = [[UILabel alloc]init];
    nameLabel.frame = CGRectMake(imageBgView.Right + 10, 10, width, 25);
    nameLabel.font = [UIFont systemFontOfSize:15];
    [bgView addSubview:nameLabel];
    self.nameLabel = nameLabel;

    //尺寸
    UILabel* sizeLabel = [[UILabel alloc]init];
    sizeLabel.frame = CGRectMake(nameLabel.x, nameLabel.Bottom + 5, width, 20);
    sizeLabel.textColor = [RegularExpressionsMethod ColorWithHexString:BASELITTLEBLACKCOLOR];
    sizeLabel.font = [UIFont systemFontOfSize:12];
    [bgView addSubview:sizeLabel];
    self.sizeLabel = sizeLabel;

    //时间
    UILabel* dateLabel = [[UILabel alloc]init];
    dateLabel.frame = CGRectMake(nameLabel.x, sizeLabel.Bottom , width, 20);
    dateLabel.font = [UIFont systemFontOfSize:10];
    dateLabel.textColor = [RegularExpressionsMethod ColorWithHexString:BASELITTLEBLACKCOLOR];
    [bgView addSubview:dateLabel];
    self.dateLabel = dateLabel;

    //数量加按钮
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addBtn.frame = CGRectMake(bgView.width - 35, bgView.height - 35, 25, 25);
    [addBtn setImage:[UIImage imageNamed:@"cart_addBtn_nomal"] forState:UIControlStateNormal];
    [addBtn setImage:[UIImage imageNamed:@"cart_addBtn_highlight"] forState:UIControlStateHighlighted];
    [addBtn addTarget:self action:@selector(addBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:addBtn];

    //数量显示
    UILabel* numberLabel = [[UILabel alloc]init];
    numberLabel.frame = CGRectMake(addBtn.x - 30, addBtn.y, 30, 25);
    numberLabel.textAlignment = NSTextAlignmentCenter;
    numberLabel.text = @"1";
    numberLabel.font = [UIFont systemFontOfSize:15];
    [bgView addSubview:numberLabel];
    self.numberLabel = numberLabel;

    //数量减按钮
    UIButton *cutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cutBtn.frame = CGRectMake(numberLabel.x - 25, addBtn.y, 25, 25);
    [cutBtn setImage:[UIImage imageNamed:@"cart_cutBtn_nomal"] forState:UIControlStateNormal];
    [cutBtn setImage:[UIImage imageNamed:@"cart_cutBtn_highlight"] forState:UIControlStateHighlighted];
    [cutBtn addTarget:self action:@selector(cutBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:cutBtn];
}

@end
