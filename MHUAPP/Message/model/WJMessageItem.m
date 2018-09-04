//
//  WJMessageItem.m
//  MHUAPP
//
//  Created by wenchengjun on 2018/9/4.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import "WJMessageItem.h"

@implementation WJMessageItem

+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"headimg" : @"userInfo.headimg",
             @"supplier_id" : @"userInfo.supplier_id",
             @"user_id" : @"userInfo.user_id",
             @"supplier_name" : @"userInfo.supplier_name",
             @"user_name" : @"userInfo.user_name"
             };
}

@end
