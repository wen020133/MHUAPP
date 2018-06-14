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
#import <UIImageView+WebCache.h>
#define  TAG_Height 100


@interface WJCartTableViewCell ()
{
    LZNumberChangedBlock numberAddBlock;
    LZNumberChangedBlock numberCutBlock;
    LZCellSelectedBlock cellSelectedBlock;
}


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

    [self.lzImageView sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:[UIImage imageNamed:@"default_nomore.png"] completed:nil];
    [self refreshUIWithTitle:model.goods_name];
    self.attributeLabel.text = model.goods_attr;
    if (model.youhui.length>0) {
        self.youhuiLabel.text = model.youhui;
    }
    self.numberLabel.text = [NSString stringWithFormat:@"%ld",(long)model.goods_number];
    self.selectBtn.selected = model.select;
    self.priceLabel.text = [NSString stringWithFormat:@"¥%@",model.goods_price];
    self.priceLabel.frame = CGRectMake(self.lzImageView.Right + 10, 65, [RegularExpressionsMethod widthOfString:self.priceLabel.text font:Font(16) height:30], 30);

    if (model.market_price.length>0) {
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:model.market_price
                                                                                    attributes:@{NSStrikethroughStyleAttributeName : @(NSUnderlineStyleSingle)}];
        self.lab_market_price.attributedText = attrStr;

        self.lab_market_price.frame = CGRectMake(self.priceLabel.Right+3, 72, 60, 20);
    }

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
    //选中按钮
    UIButton* selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    selectBtn.center = CGPointMake(20, TAG_Height/2);
    selectBtn.bounds = CGRectMake(0, 0, 30, 30);
    [selectBtn setImage:[UIImage imageNamed:@"user_weigouxuan"] forState:UIControlStateNormal];
    [selectBtn setImage:[UIImage imageNamed:@"shipcart_seleHigh"] forState:UIControlStateSelected];
    [selectBtn addTarget:self action:@selector(selectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:selectBtn];
    self.selectBtn = selectBtn;

    //显示照片
    self.lzImageView = [[UIImageView alloc]init];
    self.lzImageView.backgroundColor = [RegularExpressionsMethod ColorWithHexString:@"F3F3F3"];
    self.lzImageView.frame = CGRectMake(selectBtn.Right + 5, 5, TAG_Height - 10, TAG_Height - 10);
    self.lzImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:self.lzImageView];

    self.imageLine = ImageViewInit(self.lzImageView.Right + 5, 0, kMSScreenWith-self.lzImageView.Right -15, 1);
    self.imageLine.backgroundColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.4];
    [self.contentView addSubview:self.imageLine];
    
    //商品名
    self.nameLabel = [[UILabel alloc]init];
    self.nameLabel.frame = CGRectMake(self.lzImageView.Right + 10, 3, kMSScreenWith-self.lzImageView.Right-30, 40);
    self.nameLabel.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:self.nameLabel];

    //属性
    self.attributeLabel = [[UILabel alloc]init];
    self.attributeLabel.frame = CGRectMake(self.lzImageView.Right + 10, self.nameLabel.Bottom +2, 200, 12);
    self.attributeLabel.textColor = [RegularExpressionsMethod ColorWithHexString:BASELITTLEBLACKCOLOR];
    self.attributeLabel.font = [UIFont systemFontOfSize:10];
    [self.contentView addSubview:self.attributeLabel];

    //优惠
    self.youhuiLabel = [[UILabel alloc]init];
    self.youhuiLabel.frame = CGRectMake(self.lzImageView.Right + 10, self.attributeLabel.Bottom +2, 200, 12);
    self.youhuiLabel.textColor = [UIColor redColor];
    self.youhuiLabel.font = [UIFont systemFontOfSize:10];
    [self.contentView addSubview:self.youhuiLabel];


    //价格
    self.priceLabel = [[UILabel alloc]init];
    self.priceLabel.frame = CGRectMake(self.lzImageView.Right + 10, 65, 200, 30);
    self.priceLabel.font = Font(16);
    self.priceLabel.textColor = [RegularExpressionsMethod ColorWithHexString:BASEPINK];
    [self.contentView addSubview:self.priceLabel];

    //原价
    self.lab_market_price = [[UILabel alloc] init];
    self.lab_market_price.font = PFR12Font;
    self.lab_market_price.contentMode = NSTextAlignmentLeft;
    self.lab_market_price.textColor = [RegularExpressionsMethod ColorWithHexString:kGrayBgColor];
    [self addSubview:self.lab_market_price];

    //数量加按钮
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addBtn.frame = CGRectMake(kMSScreenWith - 35,  65, 25, 25);
    [addBtn setImage:[UIImage imageNamed:@"cart_addBtn_nomal"] forState:UIControlStateNormal];
    [addBtn setImage:[UIImage imageNamed:@"cart_addBtn_highlight"] forState:UIControlStateHighlighted];
    [addBtn addTarget:self action:@selector(addBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:addBtn];

    //数量显示
    UILabel* numberLabel = [[UILabel alloc]init];
    numberLabel.frame = CGRectMake(addBtn.x - 30, addBtn.y, 30, 25);
    numberLabel.textAlignment = NSTextAlignmentCenter;
    numberLabel.text = @"1";
    numberLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:numberLabel];
    self.numberLabel = numberLabel;

    //数量减按钮
    UIButton *cutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cutBtn.frame = CGRectMake(numberLabel.x - 25, addBtn.y, 25, 25);
    [cutBtn setImage:[UIImage imageNamed:@"cart_cutBtn_nomal"] forState:UIControlStateNormal];
    [cutBtn setImage:[UIImage imageNamed:@"cart_cutBtn_highlight"] forState:UIControlStateHighlighted];
    [cutBtn addTarget:self action:@selector(cutBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:cutBtn];
}

-(void)refreshUIWithTitle:(NSString *)title{
    NSString *str =  [title stringByAppendingString:@"\n"];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString: title];

    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:8];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [title length])];
    self.nameLabel.attributedText = attributedString;

    CGFloat heights = [self boundingRectWithString:str];

    if (heights>46) {
        self.nameLabel.numberOfLines = 2;
        self.nameLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    }else{
        self.nameLabel.numberOfLines = 2;
    }

}

- (CGFloat)boundingRectWithString:(NSString *)string
{
    CGRect rect = [string boundingRectWithSize:CGSizeMake(kMSScreenWith-self.lzImageView.Right-30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil];
    return  rect.size.height;
}
@end
