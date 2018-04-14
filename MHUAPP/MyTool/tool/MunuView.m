//
//  MunuView.m
//  phoneGap
//
//  Created by wenchengjun on 14-12-7.
//
//

#import "MunuView.h"

@implementation MunuView

-(id)initWithFrame:(CGRect)frame withTitles:(NSArray *)arr
{
    self = [super initWithFrame:frame];
    if (self) {
        _Menu_titles = [[NSArray alloc]initWithArray:arr];
        [self initScrollView];
    }
    return self;
}
- (void)initScrollView
{
    self.backgroundColor = kMSViewBackColor;
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kMSScreenWith, 44)];
    self.scrollView.backgroundColor = [UIColor clearColor];
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.pagingEnabled = YES;
    NSInteger count = self.Menu_titles.count;
    float width = 0;
//    if (count >= 5||count == 3)
//    {
        width = kMSScreenWith / count;
//    }
//    else if (count == 4)
//    {
//        width = kMSScreenWith / 4;
//    }
//    else
//    {
//        width = kMSScreenWith /2;
//    }
    [self.scrollView setContentSize:CGSizeMake([self.Menu_titles count] * width, self.scrollView.frame.size.height)];
    for(int i = 0; i < [self.Menu_titles count]; i++)
    {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setFrame:CGRectMake(width * i, 0, width, 44)];
        [button addTarget:self action:@selector(menuSelected:) forControlEvents:UIControlEventTouchUpInside];
        [button.titleLabel setFont:[UIFont systemFontOfSize:18]];
        [button setTitle:[self.Menu_titles objectAtIndex:i] forState:UIControlStateNormal];
        button.tag = 3*i;
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
    // Indicator image
    _indicatorImage = [[UIView alloc]initWithFrame:CGRectMake(20, 42, width-40, 2)];
    _indicatorImage.backgroundColor = kMSNavBarBackColor;
    [_scrollView addSubview:_indicatorImage];
    _selectIndex = 0;
    [self addSubview:self.scrollView];
}

- (void)menuSelected:(UIButton *)sender
{
    // Change the current button's title Color,at the same time,change the previous button title color
    if (_selectIndex == sender.tag/3) //不变则不作任何操作
    {
        return;
    }
    [self changeMenuState:sender.tag];
    if ([self.delegate respondsToSelector:@selector(didSelectedButtonWithTag:)])
    {
        [self.delegate didSelectedButtonWithTag:sender.tag/3];
    }
}

- (void)changeMenuState:(NSInteger)index
{
    _selectIndex = index/3;
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
                    self.indicatorImage.center = CGPointMake(btn.center.x, self.indicatorImage.center.y);
                    
                    [btn setTitleColor:kMSNavBarBackColor forState:UIControlStateNormal];
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
