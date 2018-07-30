//
//  WJDistributionMainViewController.m
//  MHUAPP
//
//  Created by wenchengjun on 2018/7/19.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import "WJDistributionMainViewController.h"
#import "WJDistributionHeadTypeView.h"
#import "WJKeFenXiaoListViewController.h"
#import "WJMyFenxiaoViewController.h"
#import "WJZijinManagerViewController.h"
#import "UIView+UIViewFrame.h"


@interface WJDistributionMainViewController ()<UIScrollViewDelegate>
{
    UIPageViewController *_pageViewCtrl;
    NSInteger _currentPage;
    NSMutableArray *_viewControllers;
}
@property (strong, nonatomic) UIScrollView *scrollerView;
@end

@implementation WJDistributionMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [RegularExpressionsMethod ColorWithHexString:kMSVCBackgroundColor];
    [self initSendReplyWithTitle:@"一级分销" andLeftButtonName:@"ic_back.png" andRightButtonName:nil andTitleLeftOrRight:YES];
    self.scrollerView.backgroundColor = self.view.backgroundColor;
    self.scrollerView.contentSize = CGSizeMake(self.view.width * self.childViewControllers.count, 200+kMSScreenHeight);
    [self.view addSubview:self.scrollerView];
    _viewControllers = [[NSMutableArray alloc]init];
    
    
    WJDistributionHeadTypeView *headView = [[WJDistributionHeadTypeView alloc]initWithFrame:CGRectMake(0, 0, kMSScreenWith, 200)];
    headView.goToSelectClassTypeAction = ^(NSInteger typeID) {
        [_pageViewCtrl setViewControllers:@[[_viewControllers objectAtIndex:typeID]] direction:0 animated:YES completion:nil];
    };
    [self.scrollerView addSubview:headView];
    
    
    [self setUpChildViewControllers];
    
    // Do any additional setup after loading the view.
}

#pragma mark - 添加子控制器
-(void)setUpChildViewControllers
{
    WJKeFenXiaoListViewController *goodBaseVc = [[WJKeFenXiaoListViewController alloc] init];
    [_viewControllers addObject:goodBaseVc];
    
    WJMyFenxiaoViewController *goodParticularsVc = [[WJMyFenxiaoViewController alloc] init];
    [_viewControllers addObject:goodParticularsVc];
    
    WJZijinManagerViewController *goodCommentVc = [[WJZijinManagerViewController alloc] init];
    [_viewControllers addObject:goodCommentVc];
    
    _currentPage = 0;
    _pageViewCtrl=[[UIPageViewController alloc] initWithTransitionStyle:1 navigationOrientation:0 options:nil];
    _pageViewCtrl.view.frame=CGRectMake(0, 200, kMSScreenWith, kMSScreenHeight-kMSNaviHight);
    [_pageViewCtrl setViewControllers:@[[_viewControllers objectAtIndex:0]] direction:0 animated:YES completion:nil];
    [self addChildViewController:_pageViewCtrl];
    [self.scrollerView addSubview:_pageViewCtrl.view];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (UIScrollView *)scrollerView
{
    if (!_scrollerView) {
        _scrollerView = [[UIScrollView alloc] initWithFrame:CGRectZero];
        _scrollerView.frame = self.view.bounds;
        _scrollerView.showsVerticalScrollIndicator = NO;
        _scrollerView.showsHorizontalScrollIndicator = NO;
        _scrollerView.pagingEnabled = YES;
        _scrollerView.bounces = NO;
        _scrollerView.delegate = self;
    }
    return _scrollerView;
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
