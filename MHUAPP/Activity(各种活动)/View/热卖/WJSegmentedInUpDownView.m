//
//  WJSegmentedInUpDownView.m
//  MHUAPP
//
//  Created by jinri on 2018/3/31.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import "WJSegmentedInUpDownView.h"
#import "UIView+UIViewFrame.h"

@interface WJSegmentedInUpDownView ()

/** 记录上一次选中的Button */
@property (nonatomic , weak) UIButton *selectBtn;

@property (nonatomic , strong) UIImageView *img_up;
@property (nonatomic , strong) UIImageView *img_down;

@end


@implementation WJSegmentedInUpDownView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kMSCellBackColor;
         [self setUpUI];
    }
    return self;
}

- (void)setUpUI
{
    NSArray *titles = @[@"新品",@"销量",@"价格"];
    CGFloat btnW = self.width / titles.count;
    CGFloat btnH = self.height;
    CGFloat btnY = 0;
    for (NSInteger i = 0; i < titles.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [self addSubview:button];
        [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        button.tag = i + 1000;
        CGFloat btnX = i * btnW;
        button.frame = CGRectMake(btnX, btnY, btnW, btnH);
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        if (i == 0) {
            [self buttonClick:button]; //默认选择第一个
        }
        else if (i==2)
        {
            _img_up = ImageViewInit(button.dc_centerX+20, 15, 9, 5);
            _img_up.image = [UIImage imageNamed:@"price_no_up"];
            [self addSubview:_img_up];

            _img_down = ImageViewInit(button.dc_centerX+20, self.height-20, 9, 5);
            _img_down.image = [UIImage imageNamed:@"price_no_down"];
            [self addSubview:_img_down];
        }
    }

    [RegularExpressionsMethod dc_setUpAcrossPartingLineWith:self WithColor:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]];
}

#pragma mark - 按钮点击
- (void)buttonClick:(UIButton *)button
{
    if (button.tag == 2 + 1000) { //筛选
          if([_img_up.image isEqual:[UIImage imageNamed:@"price_no_up"]])
          {
            _img_up.image = [UIImage imageNamed:@"price_yes_up"];
            _img_down.image = [UIImage imageNamed:@"price_no_down"];
          }
        else
        {
             _img_up.image = [UIImage imageNamed:@"price_no_up"];
             _img_down.image = [UIImage imageNamed:@"price_yes_down"];
        }
    }else{

        _img_up.image = [UIImage imageNamed:@"price_no_up"];
        _img_down.image = [UIImage imageNamed:@"price_no_down"];
    }
    [_selectBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];



    _selectBtn = button;
     !_selectAction ? : _selectAction(button.tag);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
