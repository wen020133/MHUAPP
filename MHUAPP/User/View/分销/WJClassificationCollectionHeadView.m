//
//  WJClassificationCollectionHeadView.m
//  MHUAPP
//
//  Created by wenchengjun on 2018/7/27.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import "WJClassificationCollectionHeadView.h"
#import "UIView+UIViewFrame.h"

@interface WJClassificationCollectionHeadView ()
/** 记录上一次选中的Button */
@property (nonatomic , weak) UIButton *selectBtn;

@end

@implementation WJClassificationCollectionHeadView

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
    self.backgroundColor = [RegularExpressionsMethod ColorWithHexString:kMSVCBackgroundColor];
    
    UIImageView *imageBV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 5, kMSScreenWith, 40  )];
    imageBV.backgroundColor = kMSCellBackColor;
    [self addSubview:imageBV];
    
    NSArray *titles = @[@"新品",@"销量", @"价格 ",@"佣金 "];
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
            _img_upPrice = ImageViewInit(button.dc_centerX+20, 13, 9, 5);
            _img_upPrice.image = [UIImage imageNamed:@"price_no_up"];
            [self addSubview:_img_upPrice];
            
            _img_downPrice = ImageViewInit(button.dc_centerX+20, self.height-18, 9, 5);
            _img_downPrice.image = [UIImage imageNamed:@"price_no_down"];
            [self addSubview:_img_downPrice];
        }
        else if (i==3)
        {
            _img_upCom = ImageViewInit(button.dc_centerX+20, 13, 9, 5);
            _img_upCom.image = [UIImage imageNamed:@"price_no_up"];
            [self addSubview:_img_upCom];
            
            _img_downCom = ImageViewInit(button.dc_centerX+20, self.height-18, 9, 5);
            _img_downCom.image = [UIImage imageNamed:@"price_no_down"];
            [self addSubview:_img_downCom];
        }
    }
}

#pragma mark - 按钮点击
- (void)buttonClick:(UIButton *)button
{
    NSInteger seder = button.tag;
    if (button.tag == 2 + 1000) { //筛选
        if([_img_upPrice.image isEqual:[UIImage imageNamed:@"price_no_up"]])
        {
            _img_upPrice.image = [UIImage imageNamed:@"price_yes_up"];
            _img_downPrice.image = [UIImage imageNamed:@"price_no_down"];
            seder = 1004;
        }
        else
        {
            _img_upPrice.image = [UIImage imageNamed:@"price_no_up"];
            _img_downPrice.image = [UIImage imageNamed:@"price_yes_down"];
            seder = 1002;
        }
        _img_upCom.image = [UIImage imageNamed:@"price_no_up"];
        _img_downCom.image = [UIImage imageNamed:@"price_no_down"];
    }
    else if (button.tag == 3 + 1000) { //筛选
        if([_img_upCom.image isEqual:[UIImage imageNamed:@"price_no_up"]])
        {
            _img_upCom.image = [UIImage imageNamed:@"price_yes_up"];
            _img_downCom.image = [UIImage imageNamed:@"price_no_down"];
            seder = 1005;
        }
        else
        {
            _img_upCom.image = [UIImage imageNamed:@"price_no_up"];
            _img_downCom.image = [UIImage imageNamed:@"price_yes_down"];
            seder = 1003;
        }
        _img_upPrice.image = [UIImage imageNamed:@"price_no_up"];
        _img_downPrice.image = [UIImage imageNamed:@"price_no_down"];
    }
    else{
        
        _img_upPrice.image = [UIImage imageNamed:@"price_no_up"];
        _img_downPrice.image = [UIImage imageNamed:@"price_no_down"];
        _img_upCom.image = [UIImage imageNamed:@"price_no_up"];
        _img_downCom.image = [UIImage imageNamed:@"price_no_down"];
    }
    [_selectBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    _selectBtn = button;
    !_filtrateClickBlock ? : _filtrateClickBlock(seder);
}

@end
