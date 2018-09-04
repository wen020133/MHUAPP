//
//  WJMessageClassViewController.m
//  MHUAPP
//
//  Created by wenchengjun on 2017/11/28.
//  Copyright © 2017年 wenchengjun. All rights reserved.
//

#import "WJMessageClassViewController.h"
//#import "WJMessageHeadView.h"
#import "RCCustomCell.h"
#import "UIImageView+WebCache.h"
#import "WJLoginClassViewController.h"
#import "WJConversationViewController.h"
#import <MJRefresh.h>
#import "RCDCustomerServiceViewController.h"
#import "WJHomeRefreshGifHeader.h"
#import "WJUnLoginStateTypeView.h"
#import "AESCrypt.h"
#import "WJMessageItem.h"
#import <UIImageView+WebCache.h>
#import "WJMainWebClassViewController.h"
#import "NOMoreDataView.h"

@interface WJMessageClassViewController ()<UITableViewDelegate,UITableViewDataSource>

@property BOOL isFirstInitClass;

//@property (strong ,nonatomic) WJMessageHeadView *tab_headView;
@property (strong, nonatomic) UITableView *myTableView;
@property (strong, nonatomic) WJUnLoginStateTypeView *unLoginView;
@property (strong , nonatomic) NSMutableArray <WJMessageItem *>  *dataArray;
@property (retain, nonatomic) NOMoreDataView *noMoreView;

@end

@implementation WJMessageClassViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor= [RegularExpressionsMethod ColorWithHexString:kMSVCBackgroundColor];
    [self initSendReplyWithTitle:@"消息" andLeftButtonName:nil andRightButtonName:nil andTitleLeftOrRight:YES];
     self.edgesForExtendedLayout = UIRectEdgeNone;
  
  
    // Do any additional setup after loading the view.
}


-(void)getChatMsgData
{
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(1);
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_t group = dispatch_group_create();
    WEAKSELF
    dispatch_group_async(group, queue, ^{
        NSLog(@"处理事件1");
        [weakSelf getMSGServiceData:kMSGetAllChatList];
        dispatch_semaphore_signal(semaphore);
    });
    dispatch_group_async(group, queue, ^{
        NSLog(@"处理事件2");
        [weakSelf getMSGServiceData:kMSGetChatMsg];
        dispatch_semaphore_signal(semaphore);
    });
    
    dispatch_group_notify(group, queue, ^{
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        dispatch_group_notify(group, dispatch_get_main_queue(), ^{
            
        });
    });
    
}
-(void)getMSGServiceData:(NSString *)urlString
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *uid = [[userDefaults objectForKey:@"userList"] objectForKey:@"uid" ];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/xml",@"text/html", nil];
    
    
    NSString *url  = [NSString stringWithFormat:@"%@/%@/%@?user_id=%@",kMSBaseMiYoMeiPortURL,kMSappVersionCode,urlString,uid];
    NSLog(@"url====%@",url);
    
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD dismiss];
        if([[responseObject objectForKey:@"code"] integerValue] == 200)
        {
            NSLog(@"%@====%@",urlString,responseObject);
            if ([urlString isEqualToString:kMSGetChatMsg]) {
                id arr_data = [self.results objectForKey:@"data"];
                if ([arr_data isKindOfClass:[NSArray class]]) {
                    NSArray *dataArr = arr_data;
                    if ([dataArr  count]>1 ) {
                    _dataArray =   [WJMessageItem mj_objectArrayWithKeyValuesArray:arr_data];
                    [self.myTableView reloadData];
                    [self.noMoreView hide];
                }
                else
                {
                    [_dataArray removeAllObjects];
                    [self.noMoreView hide];
                    self.noMoreView = [[NOMoreDataView alloc]initWithFrame:CGRectMake(0, 44, kMSScreenWith, 80) withContent:@"暂无数据." withNODataImage:@"noMore_bg.png"];
                    [self.myTableView addSubview:self.noMoreView];
                }
                }
                else
                {
                    [_dataArray removeAllObjects];
                    [self.noMoreView hide];
                    self.noMoreView = [[NOMoreDataView alloc]initWithFrame:CGRectMake(0, 44, kMSScreenWith, 80) withContent:@"暂无数据." withNODataImage:@"noMore_bg.png"];
                    [self.myTableView addSubview:self.noMoreView];
                }
                
            }
            else {
                if([[responseObject objectForKey:@"data"] integerValue]==0)
               {
                   self.tabBarItem.badgeValue = nil;
               }
                else
                {
                UITabBarItem * item=[self.tabBarController.tabBar.items objectAtIndex:2];
                item.badgeValue=[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"data"]];
                }
            }
        }
        else
        {
            [SVProgressHUD showErrorWithStatus:[responseObject objectForKey:@"msg"]];
            return;
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 失败，关闭网络指示器
        NSLog(@"ada===%@",[error localizedDescription]);
        NSString *str_error = [error localizedDescription];
        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:str_error];
        return;
    }];
    [self.myTableView.mj_header endRefreshing];
}

-(UITableView *)myTableView
{
    if (!_myTableView) {
        _myTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
        
        _myTableView.rowHeight = 100;
        _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _myTableView.backgroundColor = kMSColorFromRGB(245, 246, 248);
        
        self.myTableView.frame = CGRectMake(0, 0, kMSScreenWith, kMSScreenHeight - kMSNaviHight -kTabBarHeight -49);
       self.myTableView.mj_header = [WJHomeRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(getChatMsgData)];
        [self.view addSubview:self.myTableView];
    }
    return _myTableView;
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
        [self getChatMsgData];
    }

}

#pragma mark TableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   return  self.dataArray.count;
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    RCCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RCCustomCell"];
        if (cell == nil) {
            cell = [[RCCustomCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"RCCustomCell"];
        }
    [cell.avatarIV  sd_setImageWithURL:[NSURL URLWithString:_dataArray[indexPath.row].headimg] placeholderImage:[UIImage imageNamed:@"default_nomore.png"] completed:nil];
    cell.timeLabel.text = [NSString stringWithFormat:@"%@",_dataArray[indexPath.row].sendtime] ;
    cell.contentLabel.text = [NSString stringWithFormat:@"%@",_dataArray[indexPath.row].content] ;
    cell.nameLabel.text =  [NSString stringWithFormat:@"%@",_dataArray[indexPath.row].user_name];
    if ([_dataArray[indexPath.row].unread integerValue]==0) {
        cell.ppBadgeView.text = nil;
    }
    else
    {
        cell.ppBadgeView.text = [NSString stringWithFormat:@"%@",_dataArray[indexPath.row].unread];
    }
        return cell;
   
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *uid = [[userDefaults objectForKey:@"userList"] objectForKey:@"uid" ];
    WJMainWebClassViewController *conversationVC = [[WJMainWebClassViewController alloc]init];
    NSString *encryptedData = [AESCrypt encrypt:[NSString stringWithFormat:@"uid=%@@sid=%@",uid,_dataArray[indexPath.row].user_id] password:@"miyomei2018"];
    
    NSString *encodedString =[RegularExpressionsMethod encodeString:encryptedData];
    
    
    NSString *str_url = [NSString stringWithFormat:@"https://www.miyomei.com/mobile/mobile_chat_online.php?suppId=%@&appToken=%@",_dataArray[indexPath.row].supplier_id,encodedString];
    conversationVC.str_urlHttp =str_url;
    
    NSString *message = [AESCrypt decrypt:@"piaJVqHq3yBxT0H3QORtQ==" password:@"miyomei2018"];
    NSLog(@"message==%@    %@",message,str_url);
    conversationVC.str_title = _dataArray[indexPath.row].supplier_name;
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:conversationVC animated:YES];
   
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


//#pragma mark
//#pragma mark 禁止右滑删除
//-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
//    return YES;
//}
//左滑删除
//-(void)rcConversationListTableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    //可以从数据库删除数据
//    RCConversationModel *model = self.conversationListDataSource[indexPath.row];
//    [[RCIMClient sharedRCIMClient] removeConversation:model.conversationType targetId:model.targetId];
//    [self.conversationListDataSource removeObjectAtIndex:indexPath.row];
//    [self.conversationListTableView reloadData];
//    [[RCDataManager shareManager] refreshBadgeValue];
//}
////高度
//-(CGFloat)rcConversationListTableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 80;
//}


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
