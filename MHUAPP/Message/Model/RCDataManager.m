
//
//  RCDataManager.m
//  RCIM
//
//  Created by 郑文明 on 15/12/30.
//  Copyright © 2015年 郑文明. All rights reserved.
//

#import "RCDataManager.h"
#import "RCUserInfo+Addition.h"
#import "AppDelegate.h"
#import "AFNetworking.h"
#import "XYMKeyChain.h"
#import <RongIMKit/RongIMKit.h>

@implementation RCDataManager{
        NSMutableArray *dataSoure;
}

- (instancetype)init{
    if (self = [super init]) {
        [RCIM sharedRCIM].userInfoDataSource = self;
    }
    return self;
}

+ (RCDataManager *)shareManager{
    static RCDataManager* manager = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        manager = [[[self class] alloc] init];
    });
    return manager;
}
/**
 *  从服务器同步好友列表
 */
-(void)syncFriendList:(void (^)(NSMutableArray* friends,BOOL isSuccess))completion
{
    dataSoure = [[NSMutableArray alloc]init];

    for (NSInteger i = 1; i<7; i++) {
        if(i==1){
            RCUserInfo *aUserInfo =[[RCUserInfo alloc]initWithUserId:@"64" name:@"虫虫" portrait:@"http://q.qlogo.cn/qqapp/1104706859/189AA89FAADD207E76D066059F924AE0/100" QQ:@"740747055" sex:@"男"];
            [dataSoure addObject:aUserInfo];
        }else if (i==2) {
          RCUserInfo *aUserInfo =[[RCUserInfo alloc]initWithUserId:@"170" name:@"蛋蛋" portrait:@"http://weixin.ihk.cn/ihkwx_upload/fodder/20151210/1449727755947.jpg" QQ:@"蛋蛋的QQ信息" sex:@"男"];
            [dataSoure addObject:aUserInfo];
        }else if(i==3){
            RCUserInfo *aUserInfo =[[RCUserInfo alloc]initWithUserId:[NSString stringWithFormat:@"%ld",i] name:@"怕瓦落地" portrait:@"http://pic.ihk.cn/head/base/ihk/2014/04/30/213816839.jpg" QQ:@"帕瓦落地的QQ信息" sex:@"男"];
            [dataSoure addObject:aUserInfo];

        }else if(i==4){
            RCUserInfo *aUserInfo =[[RCUserInfo alloc]initWithUserId:[NSString stringWithFormat:@"%ld",i] name:@"凤姐" portrait:@"http://weixin.ihk.cn/ihkwx_upload/fodder/20151218/1450420944608.jpg" QQ:@"凤姐的QQ信息" sex:@"女"];
            [dataSoure addObject:aUserInfo];
            
        }else if(i==5){
            RCUserInfo *aUserInfo =[[RCUserInfo alloc]initWithUserId:[NSString stringWithFormat:@"%ld",i] name:@"猴塞雷" portrait:@"http://pic.ihk.cn/head/80_93/ihk/2015/05/20/104331022.jpg" QQ:@"猴塞雷的QQ信息" sex:@"男"];
            [dataSoure addObject:aUserInfo];
            
        }else if(i==6){
            RCUserInfo *aUserInfo =[[RCUserInfo alloc]initWithUserId:[NSString stringWithFormat:@"%ld",i] name:@"犀利哥" portrait:@"" QQ:@"犀利哥的QQ信息" sex:@"男"];
            [dataSoure addObject:aUserInfo];
            
        }
        
        
    }

    [AppDelegate shareAppDelegate].friendsArray = dataSoure;
    completion(dataSoure,YES);

}
/**
 *  从服务器同步群组列表
 */
-(void) syncGroupList:(void (^)(NSMutableArray * groups,BOOL isSuccess))completion{
    if ([AppDelegate shareAppDelegate].groupsArray.count) {
        [[AppDelegate shareAppDelegate].groupsArray removeAllObjects];
    }
    for (NSInteger i = 1; i<4; i++) {
        if (i==1) {
            RCGroup *aGroup = [[RCGroup alloc]initWithGroupId:[NSString stringWithFormat:@"%ld",i] groupName:@"斧头帮" portraitUri:@"http://farm2.staticflickr.com/1709/24157242566_98d0192315_m.jpg"];
            [[AppDelegate shareAppDelegate].groupsArray addObject:aGroup];
            
        }else if (i==2){
            RCGroup *aGroup = [[RCGroup alloc]initWithGroupId:[NSString stringWithFormat:@"%ld",i] groupName:@"丐帮" portraitUri:@"http://farm2.staticflickr.com/1715/23815656639_ef86cf1498_m.jpg"];
            [[AppDelegate shareAppDelegate].groupsArray addObject:aGroup];
            
        }else if (i==3){
            RCGroup *aGroup = [[RCGroup alloc]initWithGroupId:[NSString stringWithFormat:@"%ld",i] groupName:@"青龙帮" portraitUri:@"http://farm2.staticflickr.com/1455/23888379640_edf9fce919_m.jpg"];
            [[AppDelegate shareAppDelegate].groupsArray addObject:aGroup];
        }
    }
    completion([AppDelegate shareAppDelegate].groupsArray,YES);

}
#pragma mark
#pragma mark 根据userId获取RCUserInfo
-(RCUserInfo *)currentUserInfoWithUserId:(NSString *)userId{
    for (NSInteger i = 0; i<[AppDelegate shareAppDelegate].friendsArray.count; i++) {
        RCUserInfo *aUser = [AppDelegate shareAppDelegate].friendsArray[i];
        if ([userId isEqualToString:aUser.userId]) {
            NSLog(@"current ＝ %@",aUser.name);
            return aUser;
        }
    }
    return nil;
}
#pragma mark
#pragma mark 根据userId获取RCGroup
-(RCGroup *)currentGroupInfoWithGroupId:(NSString *)groupId{
    for (NSInteger i = 0; i<[AppDelegate shareAppDelegate].groupsArray.count; i++) {
        RCGroup *aGroup = [AppDelegate shareAppDelegate].groupsArray[i];
        if ([groupId isEqualToString:aGroup.groupId]) {
            return aGroup;
        }
    }
    return nil;
}
-(NSString *)currentNameWithUserId:(NSString *)userId{
    for (NSInteger i = 0; i<[AppDelegate shareAppDelegate].friendsArray.count; i++) {
        RCUserInfo *aUser = [AppDelegate shareAppDelegate].friendsArray[i];
        if ([userId isEqualToString:aUser.userId]) {
            NSLog(@"current ＝ %@",aUser.name);
            return aUser.name;
        }
    }
    return nil;
}
#pragma mark
#pragma mark - RCIMUserInfoDataSource
- (void)getUserInfoWithUserId:(NSString*)userId completion:(void (^)(RCUserInfo*))completion
{
    NSLog(@"getUserInfoWithUserId ----- %@", userId);
    
    if (userId == nil || [userId length] == 0 )
    {
        [self syncFriendList:^(NSMutableArray *friends, BOOL isSuccess) {
            
        }];
        
        completion(nil);
        return ;
    }
    
    if ([userId isEqualToString:[RCIM sharedRCIM].currentUserInfo.userId]) {
        RCUserInfo *myselfInfo = [[RCUserInfo alloc]initWithUserId:[RCIM sharedRCIM].currentUserInfo.userId name:[RCIM sharedRCIM].currentUserInfo.name portrait:[RCIM sharedRCIM].currentUserInfo.portraitUri QQ:[RCIM sharedRCIM].currentUserInfo.QQ sex:[RCIM sharedRCIM].currentUserInfo.sex];
        completion(myselfInfo);
        
    }
    
    for (NSInteger i = 0; i<[AppDelegate shareAppDelegate].friendsArray.count; i++) {
        RCUserInfo *aUser = [AppDelegate shareAppDelegate].friendsArray[i];
        if ([userId isEqualToString:aUser.userId]) {
            completion(aUser);
            break;
        }
    }
}
#pragma mark
#pragma mark - RCIMGroupInfoDataSource
- (void)getGroupInfoWithGroupId:(NSString *)groupId
                     completion:(void (^)(RCGroup *groupInfo))completion{
    for (NSInteger i = 0; i<[AppDelegate shareAppDelegate].groupsArray.count; i++) {
        RCGroup *aGroup = [AppDelegate shareAppDelegate].groupsArray[i];
        if ([groupId isEqualToString:aGroup.groupId]) {
            completion(aGroup);
            break;
        }
    }
}

-(void)getUserInfoWithMiYouMei
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *loginType = [userDefaults objectForKey:@"loginType"];

    if ([loginType isEqualToString:@"phone"]) {
        if([XYMKeyChain loadKeyChainItemWithKey:KEY_KEYCHAINITEM] != nil ){
            NSMutableDictionary *itemData = (NSMutableDictionary *)[XYMKeyChain loadKeyChainItemWithKey:KEY_KEYCHAINITEM];
            NSString *userName = [itemData objectForKey:KEY_USERNAME];
            NSString *passWord = [itemData objectForKey:KEY_PASSWORD];
            NSMutableDictionary *infos = [NSMutableDictionary dictionary];
            [infos setObject:userName forKey:@"user_name"];
            [infos setObject:[passWord md5] forKey:@"user_password"];
            [self requestPOSTAPIWithServe:[kMSBaseLargeCollectionPortURL stringByAppendingString:kMSLoginURL] andInfos:infos];
        }

    }
    else if ([loginType isEqualToString:@"qq"])
    {
//        NSMutableDictionary *infos = [NSMutableDictionary dictionary];
//        [infos setObject:outUserId forKey:@"usid"];
//        [infos setObject:outNickName forKey:@"user_name"];
//        [infos setObject:outSex forKey:@"sex"];
//        [infos setObject:outHeadUrl forKey:@"user_icon"];
//        [self requestAPIWithServe:[kMSBaseLargeCollectionPortURL stringByAppendingString:kMSLoginqq] andInfos:infos];
    }

}

-(void)requestPOSTAPIWithServe:(NSString *)service andInfos:(NSDictionary *)infos
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 20.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/xml",@"text/html", nil];

    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970];  //  *1000 是精确到毫秒，不乘就是精确到秒
    NSString *timeString = [NSString stringWithFormat:@"%.0f",a ]; //转为字符型

    [infos setValue:[[NSString stringWithFormat:@"mhupro_%@_mhupro",[timeString md5]] md5] forKey:@"token"];
    [infos setValue:timeString forKey:@"time"];

    // post请求
    [manager POST:service parameters:infos constructingBodyWithBlock:^(id<AFMultipartFormData> _Nonnull formData) {

    } progress:^(NSProgress * _Nonnull uploadProgress) {

    } success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) { // 成功，关闭网络指示器
        NSLog(@"responseObject====%@",responseObject);

       if([[responseObject objectForKey:@"code"] integerValue] == 200)
       {
        //融云
        [[RCIM sharedRCIM] initWithAppKey:RONGClOUDAPPKEY];
        //设置用户信息提供者为 [RCDataManager shareManager]
        [RCIM sharedRCIM].userInfoDataSource = [RCDataManager shareManager];
        [RCIM sharedRCIM].enableMessageAttachUserInfo = YES;
        //融云
        [[RCIM sharedRCIM] initWithAppKey:RONGClOUDAPPKEY];
        //设置用户信息提供者为 [RCDataManager shareManager]
        [RCIM sharedRCIM].userInfoDataSource = [RCDataManager shareManager];
        [RCIM sharedRCIM].enableMessageAttachUserInfo = YES;
        [self loginRongCloudWithUserInfo:[[RCUserInfo alloc]initWithUserId:@"60" name:@"mhu158VRQZ1956" portrait:@"http://shop.snryid.top/data/headimg/201803/0c33aa1a90a73e34e4a114d7323e598a.jpg" QQ:@"" sex:@""] withToken:@"iMRZ4b+d0LD/DeL9ae7v9dzYrJ6cohx7SF4nk3KbFSgHOCG2OoxWLl3Yg93x3cguVdTS6q6hPGNDVA8SwD8R4g=="];
    }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) { // 失败，关闭网络指示器
        NSLog(@"ada===%@",[error localizedDescription]);

    }];
}

-(void)loginRongCloudWithUserInfo:(RCUserInfo *)userInfo withToken:(NSString *)token{
                [[RCIM sharedRCIM] connectWithToken:token success:^(NSString *userId) {
                    [RCIM sharedRCIM].globalNavigationBarTintColor = [UIColor redColor];
                    NSLog(@"login success with userId %@",userId);
                    //同步好友列表
                    [self syncFriendList:^(NSMutableArray *friends, BOOL isSuccess) {
                        NSLog(@"%@",friends);
                        if (isSuccess) {
                            [self syncGroupList:^(NSMutableArray *groups, BOOL isSuccess) {
                                if (isSuccess) {
                                    NSLog(@" success 发送通知");
                                    [[NSNotificationCenter defaultCenter] postNotificationName:@"alreadyLogin" object:nil];
                                }
                            }];
                           
                        }
                    }];
                    

                    [RCIMClient sharedRCIMClient].currentUserInfo = userInfo;
                    [[RCDataManager shareManager] refreshBadgeValue];
                } error:^(RCConnectErrorCode status) {
                    NSLog(@"status = %ld",(long)status);
                } tokenIncorrect:^{
                    
                    NSLog(@"token 错误");
                }];
            
            
        
   
}

-(void)refreshBadgeValue{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        NSInteger unreadMsgCount = (NSInteger)[[RCIMClient sharedRCIMClient] getUnreadCount:@[@(ConversationType_PRIVATE),@(ConversationType_DISCUSSION),@(ConversationType_GROUP),@(ConversationType_CHATROOM)]];

        
        UINavigationController  *chatNav = [AppDelegate shareAppDelegate].tabbarVC.viewControllers[2];
        if (unreadMsgCount == 0) {
            chatNav.tabBarItem.badgeValue = nil;
        }else{
            chatNav.tabBarItem.badgeValue = [NSString stringWithFormat:@"%li",(long)unreadMsgCount];
        }
    });
}
-(BOOL)hasTheFriendWithUserId:(NSString *)userId{
    if ([AppDelegate shareAppDelegate].friendsArray.count) {
        NSMutableArray *tempArray = [[NSMutableArray alloc]init];
        
        for (RCUserInfo *aUserInfo in [AppDelegate shareAppDelegate].friendsArray) {
            [tempArray addObject:aUserInfo.userId];
        }
        
        if ([tempArray containsObject:userId]) {
            return YES;
        }
    }
    
    
    return NO;
}
@end

