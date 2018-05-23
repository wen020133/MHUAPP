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
    self.backgroundColor = [RegularExpressionsMethod ColorWithHexString:kMSVCBackgroundColor];
    NSArray *titles = @[@"推荐 ",@"价格",@"销量"];
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
        else if (i==1)
        {
            _img_up = ImageViewInit(button.dc_centerX+20, 13, 9, 5);
            _img_up.image = [UIImage imageNamed:@"price_no_up"];
            [self addSubview:_img_up];

            _img_down = ImageViewInit(button.dc_centerX+20, self.height-18, 9, 5);
            _img_down.image = [UIImage imageNamed:@"price_no_down"];
            [self addSubview:_img_down];
        }
//        else if (i==3)
//        {
//            UIImageView *img_shaixuan = ImageViewInit(button.dc_centerX+20, 15, 10, 11);
//            img_shaixuan.image = [UIImage imageNamed:@"icon_shaixuan"];
//            [self addSubview:img_shaixuan];
//        }
    }


    [RegularExpressionsMethod dc_setUpAcrossPartingLineWith:self WithColor:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4]];
}

#pragma mark - 按钮点击
- (void)buttonClick:(UIButton *)button
{
    NSInteger seder = button.tag;
    if (button.tag == 1 + 1000) { //筛选
        if([_img_up.image isEqual:[UIImage imageNamed:@"price_no_up"]])
        {
            _img_up.image = [UIImage imageNamed:@"price_yes_up"];
            _img_down.image = [UIImage imageNamed:@"price_no_down"];
            seder = 1004;
        }
        else
        {
            _img_up.image = [UIImage imageNamed:@"price_no_up"];
            _img_down.image = [UIImage imageNamed:@"price_yes_down"];
            seder = 1001;
        }
    }else{

        _img_up.image = [UIImage imageNamed:@"price_no_up"];
        _img_down.image = [UIImage imageNamed:@"price_no_down"];
    }
    [_selectBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];

        _selectBtn = button;
         !_filtrateClickBlock ? : _filtrateClickBlock(seder);
}

@end
