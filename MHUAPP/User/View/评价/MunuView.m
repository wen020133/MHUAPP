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
    NSMutableDictionary *transformImgDic = [NSMutableDictionary dictionaryWithCapacity:3];
    [transformImgDic setObject:[UIImage imageNamed:@"commit_chaping.png"] forKey:@"Default"];
    [transformImgDic setObject:[UIImage imageNamed:@"commit_chaping_select.png"] forKey:@"Selected"];

    NSMutableDictionary *accountImgDic = [NSMutableDictionary dictionaryWithCapacity:3];
    [accountImgDic setObject:[UIImage imageNamed:@"commit_zhongping.png"] forKey:@"Default"];
    [accountImgDic setObject:[UIImage imageNamed:@"commit_zhongping_select.png"] forKey:@"Selected"];

    NSMutableDictionary *moreImgDic = [NSMutableDictionary dictionaryWithCapacity:3];
    [moreImgDic setObject:[UIImage imageNamed:@"commit_haoping.png"] forKey:@"Default"];
    [moreImgDic setObject:[UIImage imageNamed:@"commit_haoping_select.png"] forKey:@"Selected"];

     NSArray *stateImages = [NSArray arrayWithObjects:transformImgDic, accountImgDic, moreImgDic, nil];
    self.backgroundColor = kMSViewBackColor;
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kMSScreenWith, 44)];
    self.scrollView.backgroundColor = [UIColor clearColor];
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.pagingEnabled = YES;
    NSInteger count = self.Menu_titles.count;
    float width = 0;
    width = kMSScreenWith / count;

    [self.scrollView setContentSize:CGSizeMake([self.Menu_titles count] * width, self.scrollView.frame.size.height)];
    for(int i = 0; i < [stateImages count]; i++)
    {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.titleLabel.font = [UIFont systemFontOfSize:18];
        button.frame = CGRectMake(width * i, 0, width, 44);
        [button addTarget:self action:@selector(menuSelected:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:[self.Menu_titles objectAtIndex:i] forState:UIControlStateNormal];
        [button setImage:[[stateImages objectAtIndex:i] objectForKey:@"Default"] forState:UIControlStateNormal];
        [button setImage:[[stateImages objectAtIndex:i] objectForKey:@"Selected"] forState:UIControlStateSelected];
        button.tag = 3*i;
        [button setTitleColor:[RegularExpressionsMethod ColorWithHexString:kGrayBgColor] forState:UIControlStateNormal];
        [self.scrollView addSubview:button];
        
    }
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
                    btn.selected = YES;
                    [btn setTitleColor:[RegularExpressionsMethod ColorWithHexString:BASEBLACKCOLOR] forState:UIControlStateNormal];
                }
                else
                {
                    btn.selected = NO;
                    [btn setTitleColor:[RegularExpressionsMethod ColorWithHexString:kGrayBgColor] forState:UIControlStateNormal];
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
