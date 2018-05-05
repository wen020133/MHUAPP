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


-(void)setInfoDic:(NSDictionary *)infoDic
{
    if (infoDic != _infoDic) {
        _infoDic = infoDic;
    }
}

-(void)payWithSuccess:(SuccessResult)sresult fail:(FailResult)fresult
{
    /*
     *点击获取prodcut实例并初始化订单信息
     */
    //Product *product = [self.productList objectAtIndex:indexPath.row];
    
    /*
     *商户的唯一的parnter和seller。
     *签约后，支付宝会为每个商户分配一个唯一的 parnter 和 seller。
     */
    
    /*============================================================================*/
    /*=======================需要填写商户app申请的===================================*/
    /*============================================================================*/
//    NSString *partner = @"2088021525119602";
//    NSString *seller = @"969557665@qq.com";
//    NSString *privateKey = @"MIICdQIBADANBgkqhkiG9w0BAQEFAASCAl8wggJbAgEAAoGBAM4vUO6ViZOOOVK0OVLILWoiuI9hPPnyD6qwgIh9RtUCzw9nXtdg322f+8+7E6u2dKb7SlPmCrzqvZ9LOUjPgyOp3kJdZ71w+jplY5uM9wgMT5tHTJQGH7rz6jk9Keo7YHb8Mr2TyIZa99zYPKjsTujrfCEnQzo4bVsh8T8J+o+1AgMBAAECgYBRqbHvXTDpTWps1E7j977tC6V3vHavNG16GIBADwZP9dXW7wVEXuz/eV797sWivBhFzr+orTNRkdPa1KtyqCXy8jzvwXBOm4dGrlSv2p3neJaosVeWtQM9qwLpGErjKO5H8pjVy7wn5bACQRPuTaLFrsf+Aj7+2Uy3ytjAZNFJnQJBAP3j9o/ZelJVYPeL30DpIQ1uqDI1UD1vOoDID7sf6caTQYkssSBFWzGAIym16Ut9mPO+KS2jq9DWQvVzr4AI0f8CQQDP5eGAaTBQSGqPIoBFaM3FvoHNVrMdiWj8BMzv1ot6tvhaQFJzChnBm2N5HANgs3Se/jHxvjzKMwx2I1OeZvZLAkAFzKRAKu6RXOPnI6nI2MppfSKYawFXNeg3MtqxIox7fbecg4nUO+FWYx/qfv5CPC83OhvEsB1nms1Sv/69RPZPAkBhtseFhms54L+M5QdrGDZXMhJqQ8zOHi6k/VChjbJjDCqwqLjX7zBp6jIX003XHqG6tPkeiW6jDtlVkYcU1Yn/AkByt19AH8YVVEKzFR3xG7cfZITe9/dyoHktJOiT/cZD64w1kOaggaZYVv/4fXdX7x8r8WWxm5XTJZICsOAMnjTZ";
    
    NSString *appID = @"2017042006835245";
    NSString *privateKey = @"MIICdgIBADANBgkqhkiG9w0BAQEFAASCAmAwggJcAgEAAoGBAL4gA3FUbNN6OueotKjXdXBLaQmA5RMstrZnf5wsPalCRR9lTS5SEOG65jDmhcjPDoAwuR3KTcOBb+RU82dEaQSMoSwGGV9XzU0OAXcRxJZhlVK4+j2N/Vte13mB7JvP6ZAuW9Te9ZZb0fCrc0Uz+kJ6tXUCTF55W5KYPPNbSyqhAgMBAAECgYBs7BZM1RtLxNj+Yw6tNFLZtLpGcYvLgnBi68SWClqBH7BOHlErWmTFjbfXCBpZQxaBpmhHguEuQneCDpEr9mta64mvqYzPOm+JRFhrXXIPG+H00kpuZVveSnIHnd8fEyr3Lo7wS28hsxi1Q/2CjSj41PkDtrd1ac+7mGt2uZE/gQJBAPZkNxowWX0hX2ieE5IJjwtXQlQ1xiX9Dej+GL101b0ROPUlG2/HpPRfnaLFb5hnbf/wI4WH+gT3N2s/Mi83MPkCQQDFihPCVDqCoOJ6fVdSh3cB6AoefU5SElweGGtrFqk3cglZG+U0i8TMFPq0cMCaTwBnSP0bG4CNEQNlWBbbiljpAkADrj2Qe5Zqoxv8wRfDv7bOUZBhF6iNGrmheGJAOkWTHHXAW7yML+xL5j3Bl7dyDGF9SEYPkZdviY3fYUNLp0RpAkEAp/bhGDKgUaRVDov3LQBsa52OxSAM8XIVC6394F+zYKbBVhiHCufxXQpVpgndaxfTov8H3/3Bj7EwrwJ45RG8yQJARmz5fGM6SaX1VNFCOqMaaeWa08LQK3SSrYBx31pU76Bgj8zZh++IB8/7V28Dl4IfzbuoiXiXBbboJ/+V7t7rzA==";
    /*============================================================================*/
    /*============================================================================*/
    /*============================================================================*/

    //partner和seller获取失败,提示
    if ([appID length] == 0 ||
        [privateKey length] == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"缺少partner或者seller或者私钥。"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    /*
     *生成订单信息及签名
     */
    //将商品信息赋予AlixPayOrder的成员变量
    APOrderInfo* order = [APOrderInfo new];

    // NOTE: app_id设置
    order.app_id = appID;

    // NOTE: 支付接口名称
    order.method = @"alipay.trade.app.pay";

    // NOTE: 参数编码格式
    order.charset = @"utf-8";
    order.notify_url =  @""; //回调URL
    // NOTE: 当前时间点
    NSDateFormatter* formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    order.timestamp = [formatter stringFromDate:[NSDate date]];

    // NOTE: 支付版本
    order.version = @"1.0";

    // NOTE: sign_type 根据商户设置的私钥来决定
    order.sign_type = privateKey;

    // NOTE: 商品数据
    order.biz_content = [APBizContent new];
    order.biz_content.body = @"米优美商城";
    order.biz_content.subject = @"1";
    order.biz_content.out_trade_no = [NSString stringWithFormat:@"%@",_infoDic[@"orderno"]];  //订单ID
    order.biz_content.timeout_express = @"30m"; //超时时间设置
//    order.biz_content.total_amount= _infoDic[@"realprice"];//商品价格
    order.biz_content.total_amount = [NSString stringWithFormat:@"%.2f", 0.01]; //商品价格

    //将商品信息拼接成字符串
    NSString *orderInfo = [order orderInfoEncoded:NO];
    NSString *orderInfoEncoded = [order orderInfoEncoded:YES];
    NSLog(@"orderSpec = %@",orderInfo);



    NSString *signedString = nil;
    APRSASigner* signer = [[APRSASigner alloc] initWithPrivateKey:privateKey];

    signedString = [signer signString:orderInfo withRSA2:NO];


    // NOTE: 如果加签成功，则继续执行支付
    if (signedString != nil) {
        //应用注册scheme,在AliSDKDemo-Info.plist定义URL types
        NSString *appScheme = @"MHUAPPIdentifier";

        // NOTE: 将签名成功字符串格式化为订单字符串,请严格按照该格式
        NSString *orderString = [NSString stringWithFormat:@"%@&sign=%@",
                                 orderInfoEncoded, signedString];

        // NOTE: 调用支付结果开始支付
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            NSLog(@"reslut = %@",resultDic);
        }];
    }

}


@end
