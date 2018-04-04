//
//  WJHDZTFatherClassViewCell.m
//  MHUAPP
//
//  Created by jinri on 2018/4/4.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import "WJHDZTFatherClassViewCell.h"
#import "WJHDZTTypeListViewController.h"

@implementation WJHDZTFatherClassViewCell

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.contentView.backgroundColor = [RegularExpressionsMethod ColorWithHexString:kMSVCBackgroundColor];
        self.arr_Type = [NSArray arrayWithObjects:@"电吹风机",@"直卷发器",@"洗发定型",@"染发烫发",@"染发烫发",@"染发烫发", nil];
        [self addhotsellControlView];

        [self addPageVC];
    }
    return self;
}

-(void)addhotsellControlView
{
    _menu_ScrollView = [[MenuScrollView alloc]initWithFrame:CGRectMake(0, 0, kMSScreenWith, 44) withTitles:self.arr_Type withScrollViewWidth:kMSScreenWith];
    _menu_ScrollView.delegate = self;
    [self.contentView addSubview:_menu_ScrollView];
}
-(void)addPageVC
{
    _viewControllers = [[NSMutableArray alloc]init];
    for (int i = 0; i < [self.arr_Type count]; i++)
    {
        WJHDZTTypeListViewController *healthVC = [[WJHDZTTypeListViewController alloc]init];
        [_viewControllers addObject:healthVC];
    }
    _pageViewCtrl=[[UIPageViewController alloc] initWithTransitionStyle:1 navigationOrientation:0 options:nil];
    _pageViewCtrl.view.frame=CGRectMake(0, 44, kMSScreenWith, kMSScreenHeight-44-kMSNaviHight);
    _pageViewCtrl.dataSource = self;
    _pageViewCtrl.delegate = self;
    [_pageViewCtrl setViewControllers:@[[_viewControllers objectAtIndex:0]] direction:0 animated:YES completion:nil];
//    [self addChildViewController:_pageViewCtrl];
    [self.contentView addSubview:_pageViewCtrl.view];
}
- (void)didSelectedButtonWithTag:(NSInteger)currTag
{
    [_pageViewCtrl setViewControllers:@[[_viewControllers objectAtIndex:currTag]] direction:0 animated:YES completion:nil];
}

-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = [_viewControllers indexOfObject:viewController];
    if (index == NSNotFound)
    {
        return nil;
    }
    index++;
    if (index == _viewControllers.count)
    {
        return nil;
    }
    else
    {
        return [_viewControllers objectAtIndex:index];
    }

}

-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = [_viewControllers indexOfObject:viewController];
    if ((index == 0) || (index == NSNotFound))
    {
        return nil;
    }
    index--;
    return [_viewControllers objectAtIndex:index];
}
- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers {

    UIViewController *nextVC = [pendingViewControllers firstObject];

    NSInteger index = [_viewControllers indexOfObject:nextVC];

    ph_currentIndex = index;
}

// Sent when a gesture-initiated transition ends. The 'finished' parameter indicates whether the animation finished, while the 'completed' parameter indicates whether the transition completed or bailed out (if the user let go early).
- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {

    if (completed) {
        [self.menu_ScrollView changeMenuState:ph_currentIndex];
    }
}


@end
