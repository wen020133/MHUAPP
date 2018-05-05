//
//  AliPayManagers.m
//  IOS_XW
//
//  Created by add on 15/11/17.
//  Copyright (c) 2015年 lan. All rights reserved.
//

#import "AliPayManagers.h"
#import <AlipaySDK/AlipaySDK.h>
#import "APAuthInfo.h"
#import "APOrderInfo.h"
#import "APRSASigner.h"


static AliPayManagers *sigleton = nil;
UIKIT_EXTERN NSString * const UpLoadNoti;
@implementation AliPayManagers

+(AliPayManagers *)shareInstance
{
    static dispatch_once_t onceToken;
    @synchronized (self)
    {
        dispatch_once(&onceToken, ^{
            sigleton = [[AliPayManagers alloc] init];
        });
    }
    return sigleton;
}


-(void)setInfoStr:(NSString *)infoStr
{
    if (infoStr != _infoStr) {
        _infoStr = infoStr;
    }
}

-(void)payWithSuccess:(SuccessResult)sresult fail:(FailResult)fresult
{


    // NOTE: 如果加签成功，则继续执行支付
    if (_infoStr.length>1) {
        //应用注册scheme,在AliSDKDemo-Info.plist定义URL types
        NSString *appScheme = @"MHUAPPIdentifier";


        // NOTE: 调用支付结果开始支付
        [[AlipaySDK defaultService] payOrder:_infoStr fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            NSLog(@"reslut = %@",resultDic);
        }];
    }

}


@end
