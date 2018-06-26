//
//  WJMessageClassViewController.m
//  MHUAPP
//
//  Created by wenchengjun on 2017/11/28.
//  Copyright © 2017年 wenchengjun. All rights reserved.
//

#import "WJMessageClassViewController.h"
#import "RCDataManager.h"
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

@interface WJMessageClassViewController ()<RCIMReceiveMessageDelegate,RCIMConnectionStatusDelegate
,UIAlertViewDelegate,UITableViewDataSource,UITableViewDelegate>

@property BOOL isFirstInitClass;

@property (strong ,nonatomic) WJMessageHeadView *tab_headView;

@property (strong, nonatomic) WJUnLoginStateTypeView *unLoginView;
@end

@implementation WJMessageClassViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=self.conversationListTableView.backgroundColor = [RegularExpressionsMethod ColorWithHexString:kMSVCBackgroundColor];
    [self initSendReplyWithTitle:@"消息" andLeftButtonName:nil andRightButtonName:nil andTitleLeftOrRight:YES];
     self.edgesForExtendedLayout = UIRectEdgeNone;
//     self.conversationListTableView.tableHeaderView = self.tab_headView ;
  self.conversationListTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
     [self.conversationListTableView registerClass:[RCCustomCell class] forCellReuseIdentifier:@"RCCustomCell"];
     self.conversationListTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRereshingCircle)];
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
-(void)headerRereshingCircle
{
    [self setConversationAvatarStyle:RC_USER_AVATAR_CYCLE];
    [self setDisplayConversationTypes:@[@(ConversationType_PRIVATE),@(ConversationType_SYSTEM)]];
    [RCIM sharedRCIM].receiveMessageDelegate = self;
    [RCIM sharedRCIM].connectionStatusDelegate = self;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didReceiveMessageNotification:)name:RCKitDispatchMessageNotification object:nil];
    [self.conversationListTableView.mj_header endRefreshing];
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setConversationAvatarStyle:RC_USER_AVATAR_CYCLE];
        [self setDisplayConversationTypes:@[@(ConversationType_PRIVATE),@(ConversationType_SYSTEM)]];
        [RCIM sharedRCIM].receiveMessageDelegate = self;
        [RCIM sharedRCIM].connectionStatusDelegate = self;
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(didReceiveMessageNotification:)name:RCKitDispatchMessageNotification object:nil];
        [self.conversationListTableView.mj_header endRefreshing];

    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    self =[super initWithCoder:aDecoder];
    if (self) {
        //设置要显示的会话类型
        [self setDisplayConversationTypes:@[@(ConversationType_PRIVATE),@(ConversationType_SYSTEM)]];
        [self setConversationAvatarStyle:RC_USER_AVATAR_CYCLE];
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
     if([AppDelegate shareAppDelegate].user_id.length<1)
    {
        self.conversationListTableView.hidden = YES;
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
        self.conversationListTableView.hidden = NO;
        [[RCDataManager shareManager] syncFriendList:^(NSMutableArray *friends, BOOL isSuccess) {
        }];
        [[RCDataManager shareManager] refreshBadgeValue];
        [self.conversationListTableView reloadData];
    }

}
/*!
 接收消息的回调方法
 *
 */
-(void)onRCIMReceiveMessage:(RCMessage *)message left:(int)left
{
    NSLog(@" onRCIMReceiveMessage %@",message.content);
    [[RCDataManager shareManager] refreshBadgeValue];
    [self.conversationListTableView reloadData];
}
#pragma mark - RCIMConnectionStatusDelegate

/**
 *  网络状态变化。
 *  @param status 网络状态。
 */
- (void)onRCIMConnectionStatusChanged:(RCConnectionStatus)status {
    NSLog(@"RCConnectionStatus = %ld",(long)status);
    if (status == ConnectionStatus_KICKED_OFFLINE_BY_OTHER_CLIENT) {
        [self jxt_showAlertWithTitle:nil message:@"您的帐号已在别的设备上登录，\n您被迫下线！" appearanceProcess:^(JXTAlertController * _Nonnull alertMaker) {
            alertMaker.
            addActionCancelTitle(@"知道了");
        } actionsBlock:^(NSInteger buttonIndex, UIAlertAction * _Nonnull action, JXTAlertController * _Nonnull alertSelf) {
            if (buttonIndex == 0) {
                [self.navigationController dismissViewControllerAnimated:YES completion:^{
                    [[RCIMClient sharedRCIMClient] disconnect:YES];
                }];
                [self loginoutState];
            }
        }];
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
            [AppDelegate shareAppDelegate].user_id = @"";
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

//插入自定义会话model
-(NSMutableArray *)willReloadTableData:(NSMutableArray *)dataSource{
    for (int i=0; i<dataSource.count; i++) {
        RCConversationModel *model = dataSource[i];
        if(model.conversationType == ConversationType_PRIVATE){
            model.conversationModelType = RC_CONVERSATION_MODEL_TYPE_CUSTOMIZATION;
        }
    }
    return dataSource;
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

-(RCConversationBaseCell *)rcConversationListTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.conversationListDataSource.count&&indexPath.row < self.conversationListDataSource.count) {
        RCConversationModel *model = self.conversationListDataSource[indexPath.row];

        NSInteger unreadCount = model.unreadMessageCount;
        RCCustomCell *cell = (RCCustomCell *)[[RCCustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RCCustomCell"];


        NSDate *date = [NSDate dateWithTimeIntervalSince1970:model.receivedTime/1000];
        NSString *timeString = [[self stringFromDate:date] substringToIndex:10];
        NSString *temp = [self getyyyymmdd];
        NSString *nowDateString = [NSString stringWithFormat:@"%@-%@-%@",[temp substringToIndex:4],[temp substringWithRange:NSMakeRange(4, 2)],[temp substringWithRange:NSMakeRange(6, 2)]];

        if ([timeString isEqualToString:nowDateString]) {
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"HH:mm"];
            NSString *showtimeNew = [formatter stringFromDate:date];
            cell.timeLabel.text = [NSString stringWithFormat:@"%@",showtimeNew];

        }else{
            cell.timeLabel.text = [NSString stringWithFormat:@"%@",timeString];
        }
        cell.ppBadgeView.dragdropCompletion = ^{
            NSLog(@"VC = FFF ，ID ＝ %@",model.targetId);





            [[RCIMClient sharedRCIMClient] clearMessagesUnreadStatus:ConversationType_PRIVATE targetId:model.targetId];
            model.unreadMessageCount = 0;
            NSInteger ToatalunreadMsgCount = (NSInteger)[[RCIMClient sharedRCIMClient] getUnreadCount:@[@(ConversationType_PRIVATE)]];

            long tabBarCount = ToatalunreadMsgCount-model.unreadMessageCount;

            if (tabBarCount > 0) {
                [AppDelegate shareAppDelegate].tabbarVC.selectedViewController.tabBarItem.badgeValue = [NSString stringWithFormat:@"%ld",tabBarCount];
            }
            else {
                [AppDelegate shareAppDelegate].tabbarVC.selectedViewController.tabBarItem.badgeValue = nil;
            }
        };
        if (unreadCount==0) {
            cell.ppBadgeView.text = @"";

        }else{
            if (unreadCount>=100) {
                cell.ppBadgeView.text = @"99+";
            }else{
                cell.ppBadgeView.text = [NSString stringWithFormat:@"%li",(long)unreadCount];

            }
        }



        for (RCUserInfo *userInfo in [AppDelegate shareAppDelegate].friendsArray) {
            if ([model.targetId isEqualToString:userInfo.userId]) {

                cell.nameLabel.text = [NSString stringWithFormat:@"%@",userInfo.name];
                if ([userInfo.portraitUri isEqualToString:@""]||userInfo.portraitUri==nil) {
                    cell.avatarIV.image = [UIImage imageNamed:@"ic_no_heardPic"];
                    [cell.contentView bringSubviewToFront:cell.avatarIV];
                }else{
                    [cell.avatarIV sd_setImageWithURL:[NSURL URLWithString:userInfo.portraitUri] placeholderImage:[UIImage imageNamed:@"ic_no_heardPic"]];
                }

                if ([model.lastestMessage isKindOfClass:[RCTextMessage class]]) {
                    cell.contentLabel.text = [model.lastestMessage valueForKey:@"content"];

                }else if ([model.lastestMessage isKindOfClass:[RCImageMessage class]]){
                    cell.contentLabel.text = @"[图片]";
                }
            }
        }

        return cell;
    }
    else{

        return [[RCConversationBaseCell alloc]init];
    }


}
#pragma mark
#pragma mark 禁止右滑删除
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
//左滑删除
-(void)rcConversationListTableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    //可以从数据库删除数据
    RCConversationModel *model = self.conversationListDataSource[indexPath.row];
    [[RCIMClient sharedRCIMClient] removeConversation:model.conversationType targetId:model.targetId];
    [self.conversationListDataSource removeObjectAtIndex:indexPath.row];
    [self.conversationListTableView reloadData];
    [[RCDataManager shareManager] refreshBadgeValue];
}
//高度
-(CGFloat)rcConversationListTableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

#pragma mark
#pragma mark onSelectedTableRow
- (void)onSelectedTableRow:(RCConversationModelType)conversationModelType
         conversationModel:(RCConversationModel *)model
               atIndexPath:(NSIndexPath *)indexPath{
    //点击cell，拿到cell对应的model，然后从model中拿到对应的RCUserInfo，然后赋值会话属性，进入会话
    NSLog(@"model====%ld",model.conversationType);
    if (model.conversationType==ConversationType_PRIVATE) {//单聊
        WJConversationViewController *conversationVC = [[WJConversationViewController alloc]init];
        conversationVC.conversationType = model.conversationType;
        conversationVC.targetId = model.targetId;

        RCUserInfo *aUserInfo = [[RCDataManager shareManager] currentUserInfoWithUserId:model.targetId];
        conversationVC.strTitle = aUserInfo.name;
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:conversationVC animated:YES];
        self.hidesBottomBarWhenPushed = NO;

    }
//    else if (model.conversationType==ConversationType_CUSTOMERSERVICE){//客服
//        RCDCustomerServiceViewController *chatService = [[RCDCustomerServiceViewController alloc] init];
//        chatService.conversationType = ConversationType_CUSTOMERSERVICE;
//        chatService.targetId = @"KEFU152176453929981";
//        self.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:chatService animated:YES];
//        self.hidesBottomBarWhenPushed = NO;
//    }


}
#pragma mark - 收到消息监听
-(void)didReceiveMessageNotification:(NSNotification *)notification{
    __weak typeof(&*self) blockSelf_ = self;
    //处理好友请求
    RCMessage *message = notification.object;

    if ([message.content isMemberOfClass:[RCMessageContent class]]) {
        if (message.conversationType == ConversationType_PRIVATE) {
            NSLog(@"好友消息要发系统消息！！！");
            @throw  [[NSException alloc] initWithName:@"error" reason:@"好友消息要发系统消息！！！" userInfo:nil];
        }
        RCConversationModel *customModel = [RCConversationModel new];
        //自定义cell的type
        customModel.conversationModelType = RC_CONVERSATION_MODEL_TYPE_CUSTOMIZATION;
        customModel.senderUserId = message.senderUserId;
        customModel.lastestMessage = message.content;
        dispatch_async(dispatch_get_main_queue(), ^{
            //调用父类刷新未读消息数
            [blockSelf_ refreshConversationTableViewWithConversationModel:customModel];
            [super didReceiveMessageNotification:notification];
            [blockSelf_ emptyConversationView];
            [self notifyUpdateUnreadMessageCount];

            //当消息为RCContactNotificationMessage时，没有调用super，如果是最后一条消息，可能需要刷新一下整个列表。
            //原因请查看super didReceiveMessageNotification的注释。

        });

    }else if (message.conversationType == ConversationType_PRIVATE){
        //获取接受到会话
        RCConversation *receivedConversation = [[RCIMClient sharedRCIMClient] getConversation:message.conversationType targetId:message.targetId];

        //转换新会话为新会话模型
        RCConversationModel *customModel = [[RCConversationModel alloc] initWithConversation:receivedConversation extend:nil];

        dispatch_async(dispatch_get_main_queue(), ^{
            //调用父类刷新未读消息数
            [blockSelf_ refreshConversationTableViewWithConversationModel:customModel];
            //[super didReceiveMessageNotification:notification];
            [blockSelf_ emptyConversationView];
            [self notifyUpdateUnreadMessageCount];

            //当消息为RCContactNotificationMessage时，没有调用super，如果是最后一条消息，可能需要刷新一下整个列表。
            //原因请查看super didReceiveMessageNotification的注释。
            NSNumber *left = [notification.userInfo objectForKey:@"left"];
            if (0 == left.integerValue) {
                [super refreshConversationTableViewIfNeeded];
            }
        });
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            //            调用父类刷新未读消息数
            [super didReceiveMessageNotification:notification];
            [blockSelf_ emptyConversationView];
            [self notifyUpdateUnreadMessageCount];

            //        super会调用notifyUpdateUnreadMessageCount
        });
    }
    [[RCDataManager shareManager] getUserInfoWithUserId:message.senderUserId completion:^(RCUserInfo *userInfo) {
        NSLog(@"didReceiveMessageNotification 名字 ＝ %@  ID ＝ %@",userInfo.name,userInfo.userId);
        NSString *kefuUserId = userInfo.userId;

        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];

        NSArray *friendsList = [userDefaults objectForKey:@"RYFriendsList"];
        NSMutableArray *allTimeArr = [NSMutableArray arrayWithArray:friendsList];
        int kk=0;
        for (NSDictionary *goodsDic in friendsList) {
            NSString *user_id = goodsDic[@"userId"];
            if([kefuUserId isEqualToString:user_id]){
                kk++;
            }
        }
        if (kk==0) {
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            [dic setValue:userInfo.userId forKey:@"userId"];
            [dic setValue:userInfo.name forKey:@"name"];
            [dic setValue:userInfo.portraitUri forKey:@"portrait"];
            [allTimeArr addObject:dic];
            [userDefaults setObject:allTimeArr forKey:@"RYFriendsList"];
            [userDefaults synchronize];
        }
    }];

    [self refreshConversationTableViewIfNeeded];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.conversationListDataSource.count;
}
#pragma mark - 本地推送
-(void)notif:(RCMessage *)message body:(NSString *)body{
    if ([UIApplication sharedApplication].applicationState==UIApplicationStateBackground) {
        if (KSystemVersion>=10.0) {
            NSLog(@"IOS10本地推送");


            // 使用 UNUserNotificationCenter 来管理通知
            UNUserNotificationCenter* center = [UNUserNotificationCenter currentNotificationCenter];

            //需创建一个包含待通知内容的 UNMutableNotificationContent 对象，注意不是 UNNotificationContent ,此对象为不可变对象。
            UNMutableNotificationContent* content = [[UNMutableNotificationContent alloc] init];
            content.title = [NSString localizedUserNotificationStringForKey:@"新消息" arguments:nil];
            content.body = [NSString localizedUserNotificationStringForKey:body
                                                                 arguments:nil];
            content.sound = [UNNotificationSound defaultSound];

            // 在 alertTime 后推送本地推送
            UNTimeIntervalNotificationTrigger* trigger = [UNTimeIntervalNotificationTrigger
                                                          triggerWithTimeInterval:0.1 repeats:NO];

            UNNotificationRequest* request = [UNNotificationRequest requestWithIdentifier:[NSString stringWithFormat:@"%ld",message.messageId]
                                                                                  content:content trigger:trigger];

            //添加推送成功后的处理！
            [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {

            }];

        }else{
            [[UIApplication sharedApplication] cancelAllLocalNotifications];

            UILocalNotification *alarm = [[UILocalNotification alloc] init];
            alarm.alertBody = body;
            alarm.soundName = @"alarm.wav";
            alarm.alertAction = @"确定";
            [[UIApplication sharedApplication] presentLocalNotificationNow:alarm];
        }
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
