//
//  WJMessageHeadView.m
//  MHUAPP
//
//  Created by jinri on 2018/3/12.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import "WJMessageHeadView.h"
#import "UIView+UIViewFrame.h"

@implementation WJMessageHeadView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [RegularExpressionsMethod ColorWithHexString:kMSVCBackgroundColor];        _defaultImgArr = @[@"message_wuliu",@"message_tongzhi",@"message_hudong",@"message_youhui"];
        _defaultTitleArr = @[@"物流",@"通知",@"互动",@"优惠"];
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{

    CGFloat width = kMSScreenWith/8;

    UIImageView *backV = ImageViewInit(0, 0, kMSScreenWith, 84);
    backV.backgroundColor = kMSCellBackColor;
    [self addSubview:backV];
    
    for (int page = 0; page < _defaultImgArr.count; page ++) {

                UIImageView *iamgeV = [[UIImageView alloc]initWithFrame:CGRectMake(width/2+page*kMSScreenWith/4, 5, width, width)];
                iamgeV.image = [UIImage imageNamed:_defaultImgArr[page]];

                [self addSubview:iamgeV];


                UILabel *titleLabel = LabelInit(page*kMSScreenWith/4, width+10, kMSScreenWith/4, 20);
                titleLabel.font = PFR13Font;
                titleLabel.text = _defaultTitleArr[page];
                titleLabel.textColor = [RegularExpressionsMethod ColorWithHexString:@"666666"];
                titleLabel.textAlignment = NSTextAlignmentCenter;
                [self addSubview:titleLabel];

                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                btn.frame = CGRectMake(page*kMSScreenWith/4,  0, kMSScreenWith/4, self.height);
                btn.tag = page+1000;
                btn.backgroundColor = [UIColor clearColor];
                [btn addTarget:self action:@selector(toJumpClassView:) forControlEvents:UIControlEventTouchUpInside];
                [self addSubview:btn];


    }
}

- (void)toJumpClassView:(UIButton *)sender
{
    !_goToClassTypeAction ? : _goToClassTypeAction(sender.tag);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
