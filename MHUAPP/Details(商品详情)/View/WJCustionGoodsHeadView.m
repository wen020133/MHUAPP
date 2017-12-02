//
//  WJCustionGoodsHeadView.m
//  MHUAPP
//
//  Created by jinri on 2017/12/1.
//  Copyright © 2017年 wenchengjun. All rights reserved.
//

#import "WJCustionGoodsHeadView.h"
#import "UIView+UIViewFrame.h"

@interface WJCustionGoodsHeadView ()

/** 记录上一次选中的Button */
@property (nonatomic , weak) UIButton *selectBtn;
/** 记录上一次选中的Button底部View */
@property (nonatomic , strong)UIView *selectBottomRedView;

@end

@implementation WJCustionGoodsHeadView



#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {

    self = [super initWithFrame:frame];
    if (self) {

        [self setUpUI];
    }
    return self;
}

- (void)setUpUI
{
    self.backgroundColor = [UIColor whiteColor];
    NSArray *titles = @[@"推荐",@"价格",@"销量",@"筛选"];
    NSArray *noImage = @[@"icon_Arrow2",@"",@"",@"icon_shaixuan"];
    CGFloat btnW = self.width / titles.count;
    CGFloat btnH = self.height;
    CGFloat btnY = 0;
    for (NSInteger i = 0; i < titles.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [self addSubview:button];
        [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:noImage[i]] forState:UIControlStateNormal];
        button.tag = i + 100;
        CGFloat btnX = i * btnW;
        button.frame = CGRectMake(btnX, btnY, btnW, btnH);
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        if (i == 0) {
            [self buttonClick:button]; //默认选择第一个
        }
    }

    [RegularExpressionsMethod dc_setUpAcrossPartingLineWith:self WithColor:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]];
}

#pragma mark - 按钮点击
- (void)buttonClick:(UIButton *)button
{
    if (button.tag == 3 + 100) { //筛选
        !_filtrateClickBlock ? : _filtrateClickBlock();
    }else{
        _selectBottomRedView.hidden = YES;
        [_selectBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];

        UIView *bottomRedView = [[UIView alloc] init];
        [self addSubview:bottomRedView];
        bottomRedView.backgroundColor = [UIColor redColor];
        bottomRedView.width = button.width;
        bottomRedView.height = 3;
        bottomRedView.y = button.height - bottomRedView.height;
        bottomRedView.x = button.x;
        bottomRedView.hidden = NO;

        _selectBtn = button;
        _selectBottomRedView = bottomRedView;
         !_filtrateClickBlock ? : _filtrateClickBlock();
    }
}

@end
