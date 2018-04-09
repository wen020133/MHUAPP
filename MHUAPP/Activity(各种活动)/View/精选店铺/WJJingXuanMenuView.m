//
//  WJJingXuanMenuView.m
//  MHUAPP
//
//  Created by jinri on 2018/4/9.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import "WJJingXuanMenuView.h"
#import "UIView+UIViewFrame.h"
#import "UIButton+LZCategory.h"

@interface WJJingXuanMenuView ()

/** 记录上一次选中的Button */
@property (nonatomic , weak) UIButton *selectBtn;

@end

@implementation WJJingXuanMenuView

- (id)initWithFrame:(CGRect)frame withTitles:(NSArray *)arr
{
    self = [super initWithFrame:frame];
    if (self) {
        _Menu_titles = [[NSArray alloc]initWithArray:arr];
        [self initScrollView];
    }
    return self;
}
-(void)initScrollView
{
    self.backgroundColor = [RegularExpressionsMethod ColorWithHexString:kMSVCBackgroundColor];

    CGFloat btnW = self.width / _Menu_titles.count;
    CGFloat btnH = self.height;
    CGFloat btnY = 0;
    for (NSInteger i = 0; i < _Menu_titles.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:_Menu_titles[i] forState:UIControlStateNormal];
        [self addSubview:button];
        [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"price_no_down"] forState:UIControlStateNormal];
        button.tag = i + 100;
        CGFloat btnX = i * btnW;
        button.frame = CGRectMake(btnX, btnY, btnW, btnH);
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        if (i == 0) {
            [self buttonClick:button]; //默认选择第一个
        }
        [button setbuttonType:LZCategoryTypeLeft];
    }

    [RegularExpressionsMethod dc_setUpAcrossPartingLineWith:self WithColor:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]];
}

#pragma mark - 按钮点击
- (void)buttonClick:(UIButton *)button
{
        !_jingxuanShopClickBlock ? : _jingxuanShopClickBlock(button.tag);
    
        [_selectBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        _selectBtn = button;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
