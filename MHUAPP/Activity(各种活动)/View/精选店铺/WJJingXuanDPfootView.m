//
//  WJJingXuanDPfootView.m
//  MHUAPP
//
//  Created by jinri on 2018/4/9.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import "WJJingXuanDPfootView.h"
#import "UIView+UIViewFrame.h"
#define  width_All  kMSScreenWith-40

@implementation WJJingXuanDPfootView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

-(void)setUIScrollView
{
    self.backgroundColor = [RegularExpressionsMethod ColorWithHexString:kMSVCBackgroundColor];
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kMSScreenWith, self.height)];
    self.scrollView.backgroundColor = [UIColor clearColor];
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.pagingEnabled = YES;

    for(int i = 0; i < [self.Menu_titles count]; i++)
    {

        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self action:@selector(menuJingXuanSelected:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = i;
        [button setFrame:CGRectMake(10+(width_All+5)*i, 0, width_All, self.height-10)];
        button.layer.cornerRadius = 3;
        button.layer.masksToBounds = YES;//设置圆角
        if (i%2 == 0)
        {
            [button setBackgroundColor:[RegularExpressionsMethod ColorWithHexString:@"AF5AB7"]];
        }
        else
        {
           [button setBackgroundColor:[RegularExpressionsMethod ColorWithHexString:BASEPINK]];
        }
        [self.scrollView addSubview:button];

        UILabel *lab_title = LabelInit(button.x+10, 15, width_All, 25);
        lab_title.textColor = kMSCellBackColor;
        lab_title.text = @"五折购好货";
        [self.scrollView addSubview:lab_title];

        UILabel *lab_content = LabelInit(button.x+10, 40, width_All, 25);
        lab_content.textColor = kMSCellBackColor;
        lab_content.font = Font(13);
        lab_content.text = @"健康新主张 加送千元优惠卷";
        [self.scrollView addSubview:lab_content];

    }
    [self.scrollView setContentSize:CGSizeMake((width_All+15)*_Menu_titles.count+5, self.height)];
    [self addSubview:self.scrollView];
}
-(void)menuJingXuanSelected:(UIButton *)sender
{
     !_goToHuoDongClassTypeAction ? : _goToHuoDongClassTypeAction(sender.tag);
}
@end
