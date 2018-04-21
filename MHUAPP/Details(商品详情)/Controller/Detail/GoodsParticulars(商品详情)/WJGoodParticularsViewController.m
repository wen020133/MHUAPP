//
//  WJGoodParticularsViewController.m
//  MHUAPP
//
//  Created by jinri on 2017/12/4.
//  Copyright © 2017年 wenchengjun. All rights reserved.
//

#import "WJGoodParticularsViewController.h"
#import "WJGoodParticularsListWebController.h"

@interface WJGoodParticularsViewController ()
{
    NSInteger ph_currentIndex;
}
@property (strong, nonatomic) NSArray *arr_PTType;


@end

@implementation WJGoodParticularsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [RegularExpressionsMethod ColorWithHexString:kMSVCBackgroundColor];
    [self getGoodsDescData];
    [self.view addSubview:self.scrollView];
    self.arr_PTType = [NSArray arrayWithObjects:@"商品介绍",@"规格参数",@"包装售后", nil];
    [self addInformationSegmentedControlView];
    [self addPageVC];
    // Do any additional setup after loading the view.
}
-(void)getGoodsDescData
{
    [self requestGetAPIWithServe:[NSString stringWithFormat:@"%@/%@/%@/%@",kMSBaseMiYoMeiPortURL,kMSappVersionCode,kMSGetGoodsDesc,self.goods_id]];
}
-(void)getProcessData
{
    if([[self.results objectForKey:@"code"] integerValue] == 200)
    {

    }
    else
    {
        return;
    }
}
-(UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
        _scrollView.frame = self.view.bounds;
        _scrollView.contentSize = CGSizeMake(kMSScreenWith, kMSScreenHeight);
        _scrollView.pagingEnabled = YES;
        _scrollView.scrollEnabled = NO;

    }
    return _scrollView;
}
-(void)addInformationSegmentedControlView
{
    _menu_goodInfoScrollView = [[MunuView alloc]initWithFrame:CGRectMake(0, 0, kMSScreenWith, 44) withTitles:self.arr_PTType];
    _menu_goodInfoScrollView.delegate = self;
    [self.scrollView addSubview:_menu_goodInfoScrollView];
}
-(void)addPageVC
{
    _viewControllers = [[NSMutableArray alloc]init];
    for (int i = 0; i < [self.arr_PTType count]; i++)
    {

        WJGoodParticularsListWebController *healthVC = [[WJGoodParticularsListWebController alloc]init];
        [_viewControllers addObject:healthVC];

    }
    _pageViewCtrl=[[UIPageViewController alloc] initWithTransitionStyle:1 navigationOrientation:0 options:nil];
    _pageViewCtrl.view.frame=CGRectMake(0, 44, kMSScreenWith, kMSScreenHeight-44-50-kMSNaviHight);
    _pageViewCtrl.dataSource = self;
    _pageViewCtrl.delegate = self;
    [_pageViewCtrl setViewControllers:@[[_viewControllers objectAtIndex:0]] direction:0 animated:YES completion:nil];
    [self addChildViewController:_pageViewCtrl];
    [self.scrollView addSubview:_pageViewCtrl.view];
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
        [self.menu_goodInfoScrollView changeMenuState:ph_currentIndex];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
