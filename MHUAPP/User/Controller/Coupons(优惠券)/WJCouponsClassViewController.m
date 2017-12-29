//
//  WJCouponsClassViewController.m
//  MHUAPP
//
//  Created by jinri on 2017/12/26.
//  Copyright © 2017年 wenchengjun. All rights reserved.
//

#import "WJCouponsClassViewController.h"
#import "WJCouponsListViewController.h"

@interface WJCouponsClassViewController ()
{
    NSInteger ph_currentIndex;
}
@property (strong, nonatomic) NSArray *arr_Type;

@end

@implementation WJCouponsClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSendReplyWithTitle:@"优惠券" andLeftButtonName:@"ic_back.png" andRightButtonName:nil andTitleLeftOrRight:YES];
    self.view.backgroundColor = [RegularExpressionsMethod ColorWithHexString:kMSVCBackgroundColor];
    self.arr_Type = [NSArray arrayWithObjects:@"未使用",@"已使用",@"已过期", nil];
    [self.view addSubview:self.menuScrollView];
    [self addPageCouponsVC];
    // Do any additional setup after loading the view.
}

-(WJCouponsMunuScrollView *)menuScrollView
{
    if (!_menuScrollView) {
        _menuScrollView = [[WJCouponsMunuScrollView alloc]initWithFrame:CGRectMake(0, 0, kMSScreenWith, 44)];
        _menuScrollView.delegate = self;
        _menuScrollView.arr_titles = self.arr_Type;
        [_menuScrollView initScrollView];
    }
    return _menuScrollView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)addPageCouponsVC
{
    _viewControllers = [[NSMutableArray alloc]init];
    for (int i = 0; i < [self.arr_Type count]; i++)
    {
        WJCouponsListViewController *healthVC = [[WJCouponsListViewController alloc]init];
        [_viewControllers addObject:healthVC];
    }
    _pageCouponsViewCtrl=[[UIPageViewController alloc] initWithTransitionStyle:1 navigationOrientation:0 options:nil];
    _pageCouponsViewCtrl.view.frame=CGRectMake(0, 44, kMSScreenWith, kMSScreenHeight-44);
    _pageCouponsViewCtrl.dataSource = self;
    _pageCouponsViewCtrl.delegate = self;
    [_pageCouponsViewCtrl setViewControllers:@[[_viewControllers objectAtIndex:0]] direction:0 animated:YES completion:nil];
    [self addChildViewController:_pageCouponsViewCtrl];
    [self.view addSubview:_pageCouponsViewCtrl.view];
}

- (void)didSelectedButtonWithTag:(NSInteger)currTag
{
    [_pageCouponsViewCtrl setViewControllers:@[[_viewControllers objectAtIndex:currTag]] direction:0 animated:YES completion:nil];
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
        [self.menuScrollView changeMenuState:ph_currentIndex];
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
