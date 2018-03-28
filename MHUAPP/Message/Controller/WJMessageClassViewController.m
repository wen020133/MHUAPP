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


@interface WJMessageClassViewController ()<RCIMReceiveMessageDelegate,RCIMConnectionStatusDelegate
,UIAlertViewDelegate,UITableViewDataSource,UITableViewDelegate>

@property (strong ,nonatomic) WJMessageHeadView *tab_headView;
@end

@implementation WJMessageClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=self.conversationListTableView.backgroundColor = [RegularExpressionsMethod ColorWithHexString:kMSVCBackgroundColor];
    [self initSendReplyWithTitle:@"消息" andLeftButtonName:nil andRightButtonName:nil andTitleLeftOrRight:YES];
     self.edgesForExtendedLayout = UIRectEdgeNone;
     self.conversationListTableView.tableHeaderView = self.tab_headView ;
  self.conversationListTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
     [self.conversationListTableView registerClass:[RCCustomCell class] forCellReuseIdentifier:@"RCCustomCell"];
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
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setConversationAvatarStyle:RC_USER_AVATAR_CYCLE];
        [self setDisplayConversationTypes:@[@(ConversationType_PRIVATE),@(ConversationType_CUSTOMERSERVICE),@(ConversationType_SYSTEM)]];
        [RCIM sharedRCIM].receiveMessageDelegate = self;
        [RCIM sharedRCIM].connectionStatusDelegate = self;
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(didReceiveMessageNotification:)name:RCKitDispatchMessageNotification object:nil];

    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    self =[super initWithCoder:aDecoder];
    if (self) {
        //设置要显示的会话类型
        [self setDisplayConversationTypes:@[@(ConversationType_PRIVATE),@(ConversationType_CUSTOMERSERVICE),@(ConversationType_SYSTEM)]];
        [self setConversationAvatarStyle:RC_USER_AVATAR_CYCLE];
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[RCDataManager shareManager] refreshBadgeValue];
    [self.conversationListTableView reloadData];

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
                NSDictionary *dic = [NSDictionary dictionary];
                NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                [userDefaults setObject:dic forKey:@"userList"];

                [userDefaults setObject:@"0" forKey:@"loginState"];
                [userDefaults synchronize];
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
        }];
    }
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

                    if ([model.senderUserId isEqualToString:[RCIMClient sharedRCIMClient].currentUserInfo.userId]) {
                        //我自己发的
                        RCUserInfo *myselfInfo = [RCIMClient sharedRCIMClient].currentUserInfo;

                        if ([[NSString stringWithFormat:@"%@",myselfInfo.name] isEqualToString:@""]) {
                            cell.contentLabel.text =[NSString stringWithFormat:@"来自\"%@\"的图片消息，点击查看",myselfInfo.name];
                        }else{
                            cell.contentLabel.text =[NSString stringWithFormat:@"来自\"%@\"的图片消息，点击查看",myselfInfo.name];

                        }
                    }else{

                        cell.contentLabel.text =[NSString stringWithFormat:@"来自\"%@\"的图片消息，点击查看",userInfo.name] ;
                    }

                }else if ([model.lastestMessage isKindOfClass:[RCVoiceMessage class]]){
                    if ([model.senderUserId isEqualToString:[RCIMClient sharedRCIMClient].currentUserInfo.userId]) {
                        //我自己发的
                        RCUserInfo *myselfInfo = [RCIMClient sharedRCIMClient].currentUserInfo;
                        if ([[NSString stringWithFormat:@"%@",myselfInfo.name] isEqualToString:@""]) {
                            cell.contentLabel.text = [NSString stringWithFormat:@"来自\"%@\"的语音消息，点击查看",myselfInfo.name];

                        }else{
                            cell.contentLabel.text = [NSString stringWithFormat:@"来自\"%@\"的语音消息，点击查看",myselfInfo.name];
                        }
                    }else{
                        cell.contentLabel.text = [NSString stringWithFormat:@"来自\"%@\"的语音消息，点击查看",userInfo.name];
                    }
                }
                else if ([model.lastestMessage isKindOfClass:[RCLocationMessage class]]){
                    if ([model.senderUserId isEqualToString:[RCIMClient sharedRCIMClient].currentUserInfo.userId]) {
                        //我自己发的
                        RCUserInfo *myselfInfo = [RCIMClient sharedRCIMClient].currentUserInfo;
                        if ([[NSString stringWithFormat:@"%@",myselfInfo.name] isEqualToString:@""]) {
                            cell.contentLabel.text = [NSString stringWithFormat:@"来自\"%@\"的位置消息，点击查看",myselfInfo.name];
                        }else{
                            cell.contentLabel.text = [NSString stringWithFormat:@"来自\"%@\"的位置消息，点击查看",myselfInfo.name];
                        }
                    }else{
                        cell.contentLabel.text = [NSString stringWithFormat:@"来自\"%@\"的位置消息，点击查看",userInfo.name];
                    }
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

    if (model.conversationType==ConversationType_PRIVATE) {//单聊
        RCConversationViewController *conversationVC = [[RCConversationViewController alloc]init];
        conversationVC.conversationType = model.conversationType;
        conversationVC.targetId = model.targetId;

        RCUserInfo *aUserInfo = [[RCDataManager shareManager] currentUserInfoWithUserId:model.targetId];
        conversationVC.title = aUserInfo.name;
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:conversationVC animated:YES];
        self.hidesBottomBarWhenPushed = NO;

    }else if (model.conversationType==ConversationType_APPSERVICE){//客服

    }


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
    }];
    [self refreshConversationTableViewIfNeeded];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.conversationListDataSource.count;
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
