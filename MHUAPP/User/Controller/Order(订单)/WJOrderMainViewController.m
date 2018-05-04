//
//  WJOrderMainViewController.m
//  MHUAPP
//
//  Created by jinri on 2017/12/18.
//  Copyright © 2017年 wenchengjun. All rights reserved.
//

#import "WJOrderMainViewController.h"
#import "WJOderListClassViewController.h"


@interface WJOrderMainViewController ()
{
    NSInteger ph_currentIndex;
}
@property (strong, nonatomic) NSArray *arr_Type;

@end

@implementation WJOrderMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSendReplyWithTitle:@"我的订单" andLeftButtonName:@"ic_back.png" andRightButtonName:nil andTitleLeftOrRight:YES];
    self.view.backgroundColor = [RegularExpressionsMethod ColorWithHexString:kMSVCBackgroundColor];
    self.arr_Type = [NSArray arrayWithObjects:@"全部",@"待付款",@"待发货",@"待收货",@"待评价", nil];
     [self addInformationSegmentedControlView];
    [self addPageVC];
    // Do any additional setup after loading the view.
}
-(void)addInformationSegmentedControlView
{
    _menuScrollView = [[MenuScrollView alloc]initWithFrame:CGRectMake(0, 0, kMSScreenWith, 44) withTitles:self.arr_Type withScrollViewWidth:kMSScreenWith];
    _menuScrollView.delegate = self;
    [self.view addSubview:_menuScrollView];
}
-(void)addPageVC
{
    _viewControllers = [[NSMutableArray alloc]init];
    for (int i = 0; i < [self.arr_Type count]; i++)
    {
        WJOderListClassViewController *healthVC = [[WJOderListClassViewController alloc]init];
        healthVC.serverType = i;
        [_viewControllers addObject:healthVC];
    }
    _pageViewCtrl=[[UIPageViewController alloc] initWithTransitionStyle:1 navigationOrientation:0 options:nil];
    _pageViewCtrl.view.frame=CGRectMake(0, 44, kMSScreenWith, kMSScreenHeight-44);
    _pageViewCtrl.dataSource = self;
    _pageViewCtrl.delegate = self;
    [_pageViewCtrl setViewControllers:@[[_viewControllers objectAtIndex:0]] direction:0 animated:YES completion:nil];
    [self addChildViewController:_pageViewCtrl];
    [self.view addSubview:_pageViewCtrl.view];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
