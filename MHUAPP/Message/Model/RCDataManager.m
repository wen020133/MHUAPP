
//
//  RCDataManager.m
//  RCIM
//
//  Created by 郑文明 on 15/12/30.
//  Copyright © 2015年 郑文明. All rights reserved.
//

#import "RCDataManager.h"
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

    for (int i = 1; i<2; i++) {
        RCUserInfo *aUserInfo =[[RCUserInfo alloc]initWithUserId:@"233" name:@"虫虫" portrait:@"http://q.qlogo.cn/qqapp/1104706859/189AA89FAADD207E76D066059F924AE0/100" ];
            [dataSoure addObject:aUserInfo];
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
        RCUserInfo *myselfInfo = [[RCUserInfo alloc]initWithUserId:[RCIM sharedRCIM].currentUserInfo.userId name:[RCIM sharedRCIM].currentUserInfo.name portrait:[RCIM sharedRCIM].currentUserInfo.portraitUri];
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
    NSString *loginState = [userDefaults objectForKey:@"loginState"];
    NSString *str_logo_img = [[userDefaults objectForKey:@"userList"] objectForKey:@"user_icon"];
//    NSString *str_uid = [[userDefaults objectForKey:@"userList"] objectForKey:@"uid"];
    NSString *str_otherID = [[userDefaults objectForKey:@"userList"] objectForKey:@"other_uid"];
    NSString *str_username = [[userDefaults objectForKey:@"userList"] objectForKey:@"username"];
    NSString *str_sex = [[userDefaults objectForKey:@"userList"] objectForKey:@"sex"];
    if ([str_sex integerValue]==1) {
        str_sex = @"男";
    }
    else
    {
         str_sex = @"女";
    }

    if([loginState isEqualToString:@"0"])
    {
        return;
    }
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
        NSMutableDictionary *infos = [NSMutableDictionary dictionary];
        [infos setObject:str_otherID forKey:@"usid"];
        [infos setObject:str_username forKey:@"user_name"];
        [infos setObject:str_sex forKey:@"sex"];
        [infos setObject:str_logo_img forKey:@"user_icon"];
        [self requestPOSTAPIWithServe:[kMSBaseLargeCollectionPortURL stringByAppendingString:kMSLoginqq] andInfos:infos];
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
    NSLog(@"infos====%@",infos);

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
        [RCIM sharedRCIM].userInfoDataSource = [RCDataManager shareManager];
        [RCIM sharedRCIM].enableMessageAttachUserInfo = YES;

           NSString *logo_img =ConvertNullString([[responseObject objectForKey:@"data"] objectForKey:@"headimg" ]);
           NSString *user_id =[[responseObject objectForKey:@"data"] objectForKey:@"user_id" ];
           [AppDelegate shareAppDelegate].user_id = user_id;
           NSString *user_name =ConvertNullString([[responseObject objectForKey:@"data"] objectForKey:@"user_name" ]);
           [[RCDataManager shareManager] loginRongCloudWithUserInfo:[[RCUserInfo alloc]initWithUserId:user_id name:user_name portrait:logo_img] withToken:@"OGYiWAUy26RQBcJUU3AUfCHL1WmuRf3UpRNY4aRna/d/1gsjB6McwDKaplPVWF2yGqTncFAoDNA5O2hzB2XuQA=="];
    }
        else
        {
            NSLog(@"msg===%@",[responseObject objectForKey:@"msg"]);
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

