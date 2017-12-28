//
//  MenuScrollView.m
//  SP2P
//
//  Created by xuym on 13-8-1.
//  Copyright (c) 2013年 sls001. All rights reserved.
//

#import "MenuScrollView.h"

@implementation MenuScrollView

-(id)initWithFrame:(CGRect)frame withTitles:(NSArray *)arr withScrollViewWidth:(float)scrWidth
{
    self = [super initWithFrame:frame];
    if (self) {
        _Menu_titles = [[NSArray alloc]initWithArray:arr];
        [self initScrollView:scrWidth];
    }
    return self;
}


- (void)initScrollView:(float)scrwidth
{
//    self.backgroundColor = [RegularExpressionsMethod ColorWithHexString:kMSVCBackgroundColor];
    self.backgroundColor = kMSViewBackColor;
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, scrwidth, 44)];
    self.scrollView.backgroundColor = [UIColor clearColor];
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.pagingEnabled = YES;
   
    float width = 0;

    for(int i = 0; i < [self.Menu_titles count]; i++)
    {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self action:@selector(menuSelected:) forControlEvents:UIControlEventTouchUpInside];
        [button.titleLabel setFont:[UIFont systemFontOfSize:18]];
        UIFont *font = button.titleLabel.font;
        CGSize size = CGSizeMake(MAXFLOAT, 44.0f);
        CGSize buttonSize = [[self.Menu_titles objectAtIndex:i] boundingRectWithSize:size
                                                  options:NSStringDrawingTruncatesLastVisibleLine  | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                               attributes:@{ NSFontAttributeName:font}
                                                  context:nil].size;
        [button setTitle:[self.Menu_titles objectAtIndex:i] forState:UIControlStateNormal];
        button.tag = i;
        [button setFrame:CGRectMake(width +20, 0, buttonSize.width+30, 44)];

        if (i == 0)
        {
            [button setTitleColor:kMSNavBarBackColor forState:UIControlStateNormal];
        }
        else
        {
            [button setTitleColor:kMSLabelTextColor forState:UIControlStateNormal];
        }
        width = width+buttonSize.width+30;
        [self.scrollView addSubview:button];
//        NSLog(@"button.frame===%@",NSStringFromCGRect(button.frame));
    }
    [self.scrollView setContentSize:CGSizeMake(width+20, 44)];
    // Indicator image
    UIFont *font = [UIFont systemFontOfSize:18];
    CGSize size = CGSizeMake(MAXFLOAT, 44.0f);
    CGSize buttonSize = [[self.Menu_titles objectAtIndex:0] boundingRectWithSize:size
                                                                         options:NSStringDrawingTruncatesLastVisibleLine  | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                                      attributes:@{ NSFontAttributeName:font}
                                                                         context:nil].size;
    _indicatorImage = [[UIView alloc]initWithFrame:CGRectMake(20, 42, buttonSize.width+20, 2)];
    _indicatorImage.backgroundColor = kMSNavBarBackColor;
    [_scrollView addSubview:_indicatorImage];
    _selectIndex = 0;
    [self addSubview:self.scrollView];
}

- (void)menuSelected:(UIButton *)sender
{    
    // Change the current button's title Color,at the same time,change the previous button title color
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
                    UIFont *font = [UIFont systemFontOfSize:18];
                    CGSize size = CGSizeMake(MAXFLOAT, 44.0f);
                    CGSize buttonSize = [[self.Menu_titles objectAtIndex:i] boundingRectWithSize:size
                                                                                         options:NSStringDrawingTruncatesLastVisibleLine  | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                                                      attributes:@{ NSFontAttributeName:font}
                                                                                         context:nil].size;
                    self.indicatorImage.frame =CGRectMake(0, 42, buttonSize.width+20, 2);
                    self.indicatorImage.center = CGPointMake(btn.center.x, self.indicatorImage.center.y);
                    
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
                    if(self.Menu_titles.count>3)
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


@end
