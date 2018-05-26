//
//  WXApiManager.h
//  MHUAPP
//
//  Created by wenchengjun on 2018/5/25.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "WXApi.h"
typedef void(^successBlock)(id status);
typedef void (^faildBlock)(id status);

@protocol WXApiManagerDelegate <NSObject>

@optional

- (void)managerDidRecvGetMessageReq:(GetMessageFromWXReq *)request;

- (void)managerDidRecvShowMessageReq:(ShowMessageFromWXReq *)request;

- (void)managerDidRecvLaunchFromWXReq:(LaunchFromWXReq *)request;

- (void)managerDidRecvMessageResponse:(SendMessageToWXResp *)response;

- (void)managerDidRecvAuthResponse:(SendAuthResp *)response;

- (void)managerDidRecvAddCardResponse:(AddCardToWXCardPackageResp *)response;

@end

@interface WXApiManager : NSObject<WXApiDelegate>

@property (nonatomic, assign) id<WXApiManagerDelegate> delegate;

/** 订单信息 */
@property (nonatomic,strong) NSDictionary *orderInfo;


+ (instancetype)sharedManager;


// 调起支付接口
- (void)payWithSuccess:(successBlock)success faild:(faildBlock)faild;




@end
