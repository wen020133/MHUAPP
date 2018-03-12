//
//  WJMainTabBarViewController.m
//  MHUAPP
//
//  Created by wenchengjun on 2017/11/28.
//  Copyright © 2017年 wenchengjun. All rights reserved.
//

#import "WJMainTabBarViewController.h"
#import "WJHomeMainClassViewController.h"
#import "WJCommodityViewController.h"
#import "WJMessageClassViewController.h"
#import "WJPersonalCenterViewController.h"
#import "WJShopCartClassViewController.h"


@interface WJMainTabBarViewController ()<UITabBarControllerDelegate>

@end

@implementation WJMainTabBarViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    
    self.tabBar.translucent = YES;
    [self.tabBar setBackgroundColor:[RegularExpressionsMethod ColorWithHexString:@"FDFDFD"]];
    [[UITabBarItem appearance]setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                      [RegularExpressionsMethod ColorWithHexString:BASEBLACKCOLOR], NSForegroundColorAttributeName,
                                                      [UIFont systemFontOfSize:12],
                                                      NSFontAttributeName,
                                                      nil] forState:UIControlStateNormal];
    [[UITabBarItem appearance]setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                      [RegularExpressionsMethod ColorWithHexString:BASEPINK],
                                                      NSForegroundColorAttributeName,
                                                      [UIFont systemFontOfSize:12],
                                                      NSFontAttributeName,
                                                      nil] forState:UIControlStateSelected];
    
    
    WJHomeMainClassViewController *mainPage = [[WJHomeMainClassViewController alloc]init];
    WJCommodityViewController *departClass = [[WJCommodityViewController alloc]init];
    WJMessageClassViewController *message = [[WJMessageClassViewController alloc]init];
    
    WJShopCartClassViewController *buyCar = [[WJShopCartClassViewController alloc] init];
    buyCar.isHasTabBarController = YES;
    buyCar.isHasNavitationController = NO;
    WJPersonalCenterViewController *me = [[WJPersonalCenterViewController alloc]init];
    
    [self setUpChildController:mainPage title:@"首页" image:@"Tab_icon_Home_normal" selectedImage:@"Tab_icon_Home_selected"];
    
    [self setUpChildController:departClass title:@"分类" image:@"Tab_icon_feilei_normal" selectedImage:@"Tab_icon_feilei_selected"];
    
    [self setUpChildController:message title:@"消息" image:@"Tab_icon_messsge_normal" selectedImage:@"Tab_icon_message_selected"];

    [self setUpChildController:buyCar title:@"购物车" image:@"Tab_icon_Cart_normal" selectedImage:@"Tab_icon_Cart_selected"];
    
    [self setUpChildController:me title:@"我" image:@"Tab_icon_Account_normal" selectedImage:@"Tab_icon_Account_selected"];
    
    self.selectedIndex = 0;
    
   
    // Do any additional setup after loading the view.
}
- (void)setUpChildController:(UIViewController *)childController title:(NSString *)title image:(NSString *)image  selectedImage:(NSString *)selectedImage
{
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:childController];
    [nav.navigationBar setIsMSNavigationBar];
    nav.delegate = (id)self;
    
    UIImage *img =  [UIImage imageNamed:image];
    UIImage *selImg = [UIImage imageNamed:selectedImage];
    
    
    nav.tabBarItem = [[UITabBarItem alloc] initWithTitle:title image:[img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage: [selImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    
    [self addChildViewController:nav];
    
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
