//
//  MuluScrollView.m
//  phoneGap
//
//  Created by wenchengjun on 14-12-1.
//
//

#import "MuluScrollView.h"

@implementation MuluScrollView

- (id)initWithFrame:(CGRect)frame withTitles:(NSArray *)arr
{
    self = [super initWithFrame:frame];
    if (self) {
        _titles = [[NSArray alloc]initWithArray:arr];
        [self initScrollView];
    }
    return self;
}

- (void)initScrollView
{
    _scrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
    self.scrollView.backgroundColor = kMSCellBackColor;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.pagingEnabled = YES;

    
    float width = 0;
    if (self.titles.count >= 4)
        width = kMSScreenWith / 4;
    else
        width = kMSScreenWith / 2;
    
    for(int i = 0; i < [self.titles count]; i++)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setFrame:CGRectMake(kMSScreenWith/2 * i, 0, kMSScreenWith/2, 44)];
        [button addTarget:self action:@selector(menuSelected:) forControlEvents:UIControlEventTouchUpInside];
        [button.titleLabel setFont:[UIFont systemFontOfSize:13]];
        [button setTitle:[_titles objectAtIndex:i] forState:UIControlStateNormal];
        button.layer.masksToBounds=YES;
        button.layer.borderColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.4].CGColor;
        button.layer.borderWidth = 1.f;

        if (i == 0)
        {
            [button setTitleColor:kMSNavBarBackColor forState:UIControlStateNormal];
        }
        else
        {
            [button setTitleColor:kMSLabelTextColor forState:UIControlStateNormal];
        }
        button.tag = i;
        [self.scrollView addSubview:button];
    }
    _selectIndex = 0;
    [self addSubview:_scrollView];
}

- (void)menuSelected:(UIButton *)sender
{
    [sender setTitleColor:kMSNavBarBackColor forState:UIControlStateNormal];
    [self changeMunuState:sender.tag];
    
    if ([self.delegate respondsToSelector:@selector(didSelectedMuluBtnWithTag:)])
        [self.delegate didSelectedMuluBtnWithTag:sender.tag];
}



- (void)changeMunuState:(NSInteger)index
{
     _selectIndex = index;
    [UIView animateWithDuration:0.1 animations:^{
        
        // The indicator image moving
        for (int i = 0; i < [self.titles count]; i++)
        {
            NSArray *array = [self.scrollView subviews];
            if ([[array objectAtIndex:i] isKindOfClass:[UIButton class]])
            {
                UIButton *btn = [array objectAtIndex:i];
                
                if (btn.tag != index)
                {
                    [btn setTitleColor:kMSLabelTextColor forState:UIControlStateNormal];

                    
                } else {
                    [btn setTitleColor:kMSNavBarBackColor forState:UIControlStateNormal];
                }
            }
        }
    }];
}


@end
