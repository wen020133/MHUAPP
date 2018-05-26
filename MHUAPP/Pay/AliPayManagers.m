//
//  AliPayManagers.m
//  IOS_XW
//
//  Created by add on 15/11/17.
//  Copyright (c) 2015年 lan. All rights reserved.
//

#import "AliPayManagers.h"
#import <AlipaySDK/AlipaySDK.h>


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
    
    NSString *appScheme = @"MHUAPPIdentifier";
    [[AlipaySDK defaultService] payOrder:_infoStr fromScheme:appScheme callback:^(NSDictionary *resultDic) {
        NSLog(@"reslut = %@",resultDic);
        if ([[resultDic objectForKey:@"resultStatus"]integerValue]==9000)
        {

            if (sresult) {
                sresult();
            }
        }
        else
        {
            if (fresult) {
                fresult();
            }
        }
    }];

}


@end
