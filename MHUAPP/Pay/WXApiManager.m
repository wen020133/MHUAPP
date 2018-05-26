//
//  WXApiManager.m
//  MHUAPP
//
//  Created by wenchengjun on 2018/5/25.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import "WXApiManager.h"


@interface WXApiManager()


@end

@implementation WXApiManager

#pragma mark - LifeCycle
+(instancetype)sharedManager {
    static dispatch_once_t onceToken;
    static WXApiManager *instance;
    dispatch_once(&onceToken, ^{
        instance = [[WXApiManager alloc] init];
        
    });
    return instance;
}



- (void)payWithSuccess:(successBlock)success faild:(faildBlock)faild
{
    
    //调起微信支付
    PayReq* req  = [[PayReq alloc] init];
    // 商家id
    req.partnerId  =  _orderInfo[@"partnerid"] ;
    // 预支付交易会话
    req.prepayId  = [_orderInfo objectForKey:@"prepayid"];
    req.nonceStr  = _orderInfo[@"noncestr"];
    NSTimeInterval timestamp = [[_orderInfo objectForKey:@"timestamp"] doubleValue];
    req.timeStamp = timestamp;
    req.package = _orderInfo[@"package"];
    req.sign  = _orderInfo[@"sign"];
    // 向微信app发送请求
    [WXApi sendReq:req];
    
}


#pragma mark - WXApiDelegate
- (void)onResp:(BaseResp *)resp {
    NSString *strTitle;
    if ([resp isKindOfClass:[SendMessageToWXResp class]]) {
        strTitle = [NSString stringWithFormat:@"发送媒体消息结果"];
    }
    if ([resp isKindOfClass:[PayResp class]]) {
        strTitle = [NSString stringWithFormat:@"支付结果"];
        switch (resp.errCode) {
            case WXSuccess:
            {
                NSLog(@"支付结果: 成功!");
                NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
                [center postNotificationName:@"uploadInfo" object:nil];
                NSLog(@"dic=== %@",_orderInfo);
            }
                break;
            case WXErrCodeCommon:
            { //签名错误、未注册APPID、项目设置APPID不正确、注册的APPID与设置的不匹配、其他异常等
                [SVProgressHUD showInfoWithStatus:@"支付结果: 失败!"];
                
            }
                break;
            case WXErrCodeUserCancel:
            { //用户点击取消并返回
                [SVProgressHUD showInfoWithStatus:@"支付结果:取消支付"];
            }
                break;
            case WXErrCodeSentFail:
            { //发送失败
                [SVProgressHUD showInfoWithStatus:@"发送失败"];
                
            }
                break;
            case WXErrCodeUnsupport:
            { //微信不支持
                [SVProgressHUD showInfoWithStatus:@"微信不支持"];
                
            }
                break;
            case WXErrCodeAuthDeny:
            { //授权失败
                [SVProgressHUD showInfoWithStatus:@"授权失败"];
                
            }
                break;
            default:
                break;
        }
        //------------------------
    }
    
}

@end
