//
//  WJButtonNewlineScrollView.m
//  MHUAPP
//
//  Created by jinri on 2018/1/4.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import "WJButtonNewlineScrollView.h"

@implementation WJButtonNewlineScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
- (void)initScrollView
{
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kMSScreenWith, 50)];
    self.scrollView.backgroundColor = [UIColor clearColor];
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.pagingEnabled = YES;

    float width = kMSScreenWith/3-20;

    for(int i = 0; i < [self.arr_titles count]; i++)
    {

        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self action:@selector(menuSelected:) forControlEvents:UIControlEventTouchUpInside];
        [button.titleLabel setFont:[UIFont systemFontOfSize:15]];
        button.titleLabel.textAlignment= NSTextAlignmentCenter;
        button.titleLabel.numberOfLines = 0;
        button.titleLabel.lineBreakMode = NSLineBreakByCharWrapping;
        [button setTitle:[self.arr_titles objectAtIndex:i] forState:UIControlStateNormal];
        button.tag = i;
        [button setFrame:CGRectMake((width+20)*i+10, 0, width, 50)];

        if (i == 0)
        {
            [button setTitleColor:kMSNavBarBackColor forState:UIControlStateNormal];
        }
        else
        {
            [button setTitleColor:kMSLabelTextColor forState:UIControlStateNormal];
        }
        [self.scrollView addSubview:button];
    }
    [self.scrollView setContentSize:CGSizeMake(kMSScreenWith, 50)];

    _selectIndex = 0;
    [self addSubview:self.scrollView];
}

- (void)menuSelected:(UIButton *)sender
{
    if (_selectIndex == sender.tag) //不变则不作任何操作
    {
        return;
    }
    [self changeMenuState:sender.tag];
    if ([self.delegate respondsToSelector:@selector(didSelectedButtonWithTag:)])
    {
        [self.delegate didSelectedButtonWithTag:sender.tag];
    }
}

- (void)changeMenuState:(NSInteger)index
{
    _selectIndex = index;
    [UIView animateWithDuration:0.1 animations:^{
        NSArray *array = [self.scrollView subviews];
        // The indicator image moving
        for (int i = 0; i < [array count]; i++)
        {
            if ([[array objectAtIndex:i] isKindOfClass:[UIButton class]])
            {
                UIButton *btn = [array objectAtIndex:i];
                if (btn.tag == index)
                {
                    [btn setTitleColor:kMSNavBarBackColor forState:UIControlStateNormal];
                    //标题居中
                    CGFloat offsetX = btn.center.x - kMSScreenWith * 0.5;
                    if (offsetX < 0) { //最小
                        offsetX = 0;
                    }
                    CGFloat offsetMax = self.scrollView.contentSize.width - kMSScreenWith;
                    if (offsetX > offsetMax) { //最大
                        offsetX = offsetMax;
                    }
                    if(self.arr_titles.count>3)
                    {
                        [self.scrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
                    }
                }
                else
                {
                    [btn setTitleColor:kMSLabelTextColor forState:UIControlStateNormal];
                }

            }
        }
    }];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
