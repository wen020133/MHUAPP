
//
//  RCDataManager.m
//  RCIM
//
//  Created by 郑文明 on 15/12/30.
//  Copyright © 2015年 郑文明. All rights reserved.
//

#import "RCDataManager.h"
#import "AFNetworking.h"
#import "XYMKeyChain.h"

@implementation RCDataManager{
        NSMutableArray *dataSoure;
}



+ (RCDataManager *)shareManager{
    static RCDataManager* manager = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        manager = [[[self class] alloc] init];
    });
    return manager;
}

-(void)getUserInfoWithMiYouMei
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *loginState = [userDefaults objectForKey:@"loginState"];
    NSString *str_logo_img = [[userDefaults objectForKey:@"userList"] objectForKey:@"user_icon"];
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
    else if ([loginType isEqualToString:@"qq"]||[loginType isEqualToString:@"weixin"])
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
        
//        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//           NSString *loginType = [userDefaults objectForKey:@"loginType"];
//           if ([loginType isEqualToString:@"phone"]) {
//               NSString *logo_img =ConvertNullString([[responseObject objectForKey:@"data"] objectForKey:@"headimg"]);
//               NSString *user_id =[NSString stringWithFormat:@"guke%@", [[responseObject objectForKey:@"data"] objectForKey:@"user_id" ]];
//               NSString *user_name =ConvertNullString([[responseObject objectForKey:@"data"] objectForKey:@"user_name" ]);
//               NSString *accessToken =  [userDefaults objectForKey:@"accessToken"];
//           }
//           else
//           {
//               NSString *logo_img =ConvertNullString([[[responseObject objectForKey:@"data"] objectForKey:@"info"] objectForKey:@"headimg"]);
//               NSString *user_id =[NSString stringWithFormat:@"guke%@", [[responseObject objectForKey:@"data"] objectForKey:@"user_id" ]];
//               NSString *user_name =ConvertNullString([[[responseObject objectForKey:@"data"] objectForKey:@"info"] objectForKey:@"user_name" ]);
//               NSString *accessToken =  [userDefaults objectForKey:@"accessToken"];
//
//           }



    }
        else
        {
            NSLog(@"msg===%@",[responseObject objectForKey:@"msg"]);
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) { // 失败，关闭网络指示器
        NSLog(@"ada===%@",[error localizedDescription]);

    }];
}

@end

