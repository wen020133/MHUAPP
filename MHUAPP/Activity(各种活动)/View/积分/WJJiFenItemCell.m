//
//  WJJiFenItemCell.m
//  MHUAPP
//
//  Created by jinri on 2018/3/31.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import "WJJiFenItemCell.h"
#import "UIView+UIViewFrame.h"

@implementation WJJiFenItemCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [RegularExpressionsMethod ColorWithHexString:kMSVCBackgroundColor];        _defaultImgArr = @[@"jifen_jifen",@"jifen_duihuanjilu",@"jifen_qiandao",@"jifen_ruhezhuan"];
        _defaultTitleArr = @[@"积分25000",@"兑换记录",@"签到",@"如何赚积分"];
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{

    CGFloat width = kMSScreenWith/8;

    UIImageView *backV = ImageViewInit(0, 0, kMSScreenWith, 84);
    backV.backgroundColor = kMSCellBackColor;
    [self.contentView addSubview:backV];

    for (int page = 0; page < _defaultImgArr.count; page ++) {

        UIImageView *iamgeV = [[UIImageView alloc]initWithFrame:CGRectMake(width/2+page*kMSScreenWith/4, 5, width, width)];
        iamgeV.image = [UIImage imageNamed:_defaultImgArr[page]];

        [self.contentView addSubview:iamgeV];


        UILabel *titleLabel = LabelInit(page*kMSScreenWith/4, width+10, kMSScreenWith/4, 20);
        titleLabel.font = PFR13Font;
        titleLabel.text = _defaultTitleArr[page];
        titleLabel.textColor = [RegularExpressionsMethod ColorWithHexString:@"666666"];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:titleLabel];

        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(page*kMSScreenWith/4,  0, kMSScreenWith/4, self.height);
        btn.tag = page+1000;
        btn.backgroundColor = [UIColor clearColor];
        [btn addTarget:self action:@selector(toJumpClassView:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:btn];


    }
}

- (void)toJumpClassView:(UIButton *)sender
{
    !_goToJiFenClassTypeAction ? : _goToJiFenClassTypeAction(sender.tag);
}
@end
