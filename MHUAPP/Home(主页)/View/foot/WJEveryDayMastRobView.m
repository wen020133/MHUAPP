//
//  WJEveryDayMastRobView.m
//  MHUAPP
//
//  Created by wenchengjun on 2018/2/24.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import "WJEveryDayMastRobView.h"
#import "UIView+UIViewFrame.h"
#import <UIButton+AFNetworking.h>


@interface WJEveryDayMastRobView ()

@property (strong , nonatomic) UIButton *img_left;
@property (strong , nonatomic) UIButton *img_right1;
@property (strong , nonatomic) UIButton *img_right2;

@end


@implementation WJEveryDayMastRobView

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
    self.backgroundColor = kMSCellBackColor;
    
    UIImageView *line1 = ImageViewInit(0, kMSScreenWith/2, 1, 200);
    line1.backgroundColor = [RegularExpressionsMethod ColorWithHexString:@"E6E6E6"];
    [self addSubview:line1];

    _img_left = [UIButton buttonWithType:UIButtonTypeCustom];
    _img_left.frame = CGRectMake (0, 0, kMSScreenWith/2, 200);
    _img_left.contentMode = UIViewContentModeScaleAspectFill;
    _img_left.tag = 0;
    [_img_left addTarget:self action:@selector(didselectAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_img_left];

    UIImageView *line2 = ImageViewInit(kMSScreenWith/2, 100, kMSScreenWith/2, 1);
    line2.backgroundColor = [RegularExpressionsMethod ColorWithHexString:@"E6E6E6"];
    [self addSubview:line2];

     _img_right1 = [UIButton buttonWithType:UIButtonTypeCustom];
    _img_right1.frame = CGRectMake(kMSScreenWith/2, 0, kMSScreenWith/2, 99);
    _img_right1.contentMode = UIViewContentModeScaleAspectFill;
    _img_right1.tag = 1;
    [_img_right1 addTarget:self action:@selector(didselectAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_img_right1];

    _img_right2 = [UIButton buttonWithType:UIButtonTypeCustom];
    _img_right2.frame = CGRectMake(kMSScreenWith/2, 101, kMSScreenWith/2, 99);
    _img_right2.contentMode = UIViewContentModeScaleAspectFill;
    _img_right2.tag = 2;
    [_img_right2 addTarget:self action:@selector(didselectAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_img_right2];
    
}

-(void)setImageArr:(NSArray<WJADThirdItem *> *)imageArr
{
    if (imageArr!=_imageArr) {
        _imageArr = imageArr;
    }
    [_img_left setBackgroundImageForState:UIControlStateNormal withURL:[NSURL URLWithString:@"https://www.miyomei.com/mobile/data/afficheimg/1442452784680942491.jpg"] placeholderImage:[UIImage imageNamed:@"default_nomore.png"]];
    [_img_right1 setBackgroundImageForState:UIControlStateNormal withURL:[NSURL URLWithString:@"https://www.miyomei.com/mobile/data/afficheimg/1528043747133353224.png"] placeholderImage:[UIImage imageNamed:@"default_nomore.png"]];
    [_img_right2 setBackgroundImageForState:UIControlStateNormal withURL:[NSURL URLWithString:@"https://www.miyomei.com/mobile/data/afficheimg/1442452805449188441.jpg"] placeholderImage:[UIImage imageNamed:@"default_nomore.png"]];
}

-(void)didselectAction:(UIButton *)sender
{
     !_goToADAction ? : _goToADAction(sender.tag);
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
