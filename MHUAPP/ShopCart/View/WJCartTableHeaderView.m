//
//  WJCartTableHeaderView.m
//  MHUAPP
//
//  Created by jinri on 2018/1/25.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import "WJCartTableHeaderView.h"

@interface WJCartTableHeaderView ()

@property (strong,nonatomic)UILabel *titleLabel;
@property (strong,nonatomic)UIButton *button;
@end

@implementation WJCartTableHeaderView


- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {

        [self setupUI];
    }

    return self;
}

- (void)setupUI {

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(5, 15, 50, 30);

    [button setImage:[UIImage imageNamed:@"user_weigouxuan"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"shipcart_seleHigh"] forState:UIControlStateSelected];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:button];
    self.button = button;

    UILabel *label = [[UILabel alloc]init];
    label.frame = CGRectMake(70, 15, kMSScreenWith - 100, 30);
    label.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:label];
    self.titleLabel = label;
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
