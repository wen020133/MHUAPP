//
//  WJCartTableHeaderView.m
//  MHUAPP
//
//  Created by jinri on 2018/1/25.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import "WJCartTableHeaderView.h"
#import "UIView+UIViewFrame.h"


@interface WJCartTableHeaderView ()

@property (strong,nonatomic) UILabel *titleLabel;
@property (strong,nonatomic) UIButton *button;
@property (strong,nonatomic) UIImageView *img_shopIcon;
/* 更多 */
@property (strong , nonatomic) UIButton *quickButton;

@end

@implementation WJCartTableHeaderView


- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = kMSCellBackColor;
        [self setupUI];
    }

    return self;
}

- (void)setupUI {

    UIImageView *line = ImageViewInit(0, 39, kMSScreenWith, 1);
    line.backgroundColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.4];
    [self.contentView addSubview:line];

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(10, 5, 30, 30);

    [button setImage:[UIImage imageNamed:@"user_weigouxuan"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"shipcart_seleHigh"] forState:UIControlStateSelected];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:button];
    self.button = button;

    self.img_shopIcon = ImageViewInit(45, 10, 20, 20);
    self.img_shopIcon.contentMode = UIViewContentModeScaleAspectFit;
    self.img_shopIcon.image = [UIImage imageNamed:@"shop_default"];
    [self addSubview:self.img_shopIcon];

    UILabel *label = [[UILabel alloc]init];
    label.frame = CGRectMake(75, 5, kMSScreenWith - 100, 30);
    label.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:label];
    self.titleLabel = label;

    _quickButton = [UIButton buttonWithType:UIButtonTypeCustom];
     _quickButton.frame = CGRectMake(kMSScreenWith-20, 15, 6, 10);
     [_quickButton setBackgroundImage:[UIImage imageNamed:@"home_more"] forState:UIControlStateNormal];
    [_quickButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [self addSubview:_quickButton];
}
- (void)buttonClick:(UIButton*)button {
    button.selected = !button.selected;

    if (self.WJClickBlock) {
        self.WJClickBlock(button.selected);
    }
}

- (void)setSelect:(BOOL)select {

    self.button.selected = select;
    _select = select;
}

- (void)setTitle:(NSString *)title {
    self.titleLabel.text = title;
    _title = title;
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
