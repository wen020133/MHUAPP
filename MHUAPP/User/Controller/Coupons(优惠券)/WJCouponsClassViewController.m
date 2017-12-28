//
//  WJCouponsClassViewController.m
//  MHUAPP
//
//  Created by jinri on 2017/12/26.
//  Copyright © 2017年 wenchengjun. All rights reserved.
//

#import "WJCouponsClassViewController.h"

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
- (void)didSelectedButtonWithTag:(NSInteger)currTag
{
    
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
