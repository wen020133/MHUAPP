//
//  WJMessageClassViewController.m
//  MHUAPP
//
//  Created by wenchengjun on 2017/11/28.
//  Copyright © 2017年 wenchengjun. All rights reserved.
//

#import "WJMessageClassViewController.h"
#import "WJMessageHeadView.h"
#import "RCCustomCell.h"
#import "AppDelegate.h"
#import "UIImageView+WebCache.h"
#import "WJLoginClassViewController.h"
#import "WJConversationViewController.h"
#import <MJRefresh.h>
#import "RCDCustomerServiceViewController.h"
#import <UserNotifications/UserNotifications.h>

#import "WJUnLoginStateTypeView.h"
#import "AESCrypt.h"

@interface WJMessageClassViewController ()

@property BOOL isFirstInitClass;

@property (strong ,nonatomic) WJMessageHeadView *tab_headView;

@property (strong, nonatomic) WJUnLoginStateTypeView *unLoginView;
@end

@implementation WJMessageClassViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor= [RegularExpressionsMethod ColorWithHexString:kMSVCBackgroundColor];
    [self initSendReplyWithTitle:@"消息" andLeftButtonName:nil andRightButtonName:nil andTitleLeftOrRight:YES];
     self.edgesForExtendedLayout = UIRectEdgeNone;
//     self.conversationListTableView.tableHeaderView = self.tab_headView ;
  
    // Do any additional setup after loading the view.
}
-(WJMessageHeadView *)tab_headView
{
    if (!_tab_headView) {
        _tab_headView = [[WJMessageHeadView alloc]initWithFrame:CGRectMake(0, 0, kMSScreenWith, 90)];
        _tab_headView.backgroundColor = [RegularExpressionsMethod ColorWithHexString:kMSVCBackgroundColor];
        _tab_headView.goToClassTypeAction = ^(NSInteger typeID) {

        };
    }
    return _tab_headView;
}



-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    NSString *loginState = [userDefaults objectForKey:@"loginState"];
    if(![loginState isEqualToString:@"1"])
    {
        WEAKSELF
        if (_isFirstInitClass) {
            [self.unLoginView hide];
            self.unLoginView = [[WJUnLoginStateTypeView alloc]initWithFrame:CGRectMake(0, 0, kMSScreenWith, kMSScreenHeight-kMSNaviHight-kTabBarHeight) withContent:@"去登录" withImage:@"noMore_bg.png"];
            self.unLoginView.jumpToLoginPage = ^{
                WJLoginClassViewController *land = [[WJLoginClassViewController alloc]init];
                UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:land];
                [nav.navigationBar setIsMSNavigationBar];
                [weakSelf presentViewController:nav animated:YES completion:^{
                }];
            };
            [self.view addSubview:self.unLoginView];
            return;
        }
        _isFirstInitClass = YES;
        WJLoginClassViewController *land = [[WJLoginClassViewController alloc]init];
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:land];
        [nav.navigationBar setIsMSNavigationBar];
        [self presentViewController:nav animated:YES completion:^{
        }];
    }
    else
    {
        [self.unLoginView hide];
    }

}


- (void)loginoutState {


    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/xml",@"text/html", nil];


    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970];  //  *1000 是精确到毫秒，不乘就是精确到秒
    NSString *timeString = [NSString stringWithFormat:@"%.0f",a ]; //转为字符型
    NSString *token = [[NSString stringWithFormat:@"mhupro_%@_mhupro",[timeString md5]] md5];

    NSString *url  = [NSString stringWithFormat:@"%@/%@/%@?time=%@&token=%@",kMSBaseMiYoMeiPortURL,kMSappVersionCode,kMSOutLogin,timeString,token];
    NSLog(@"url====%@",url);

    [manager DELETE:url parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"responseObject====%@",responseObject);
        if([[responseObject objectForKey:@"code"] integerValue] == 200)
        {
            NSDictionary *dic = [NSDictionary dictionary];
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            [userDefaults setObject:dic forKey:@"userList"];
            [userDefaults setObject:@"0" forKey:@"loginState"];
            [userDefaults synchronize];
            [self.navigationController popViewControllerAnimated:YES];
        }

    }
            failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                // 失败，关闭网络指示器
                NSLog(@"ada===%@",[error localizedDescription]);
            }];
}


-(NSString *)getyyyymmdd{
    NSDate *now = [NSDate date];
    NSDateFormatter *formatDay = [[NSDateFormatter alloc] init];
    formatDay.dateFormat = @"yyyyMMdd";
    NSString *dayStr = [formatDay stringFromDate:now];
    return dayStr;

}
-(NSString *)stringFromDate:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
}


#pragma mark
#pragma mark 禁止右滑删除
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
//左滑删除
-(void)rcConversationListTableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    //可以从数据库删除数据
//    RCConversationModel *model = self.conversationListDataSource[indexPath.row];
//    [[RCIMClient sharedRCIMClient] removeConversation:model.conversationType targetId:model.targetId];
//    [self.conversationListDataSource removeObjectAtIndex:indexPath.row];
//    [self.conversationListTableView reloadData];
//    [[RCDataManager shareManager] refreshBadgeValue];
}
//高度
-(CGFloat)rcConversationListTableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
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
