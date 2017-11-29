//
//  RegularExpressionsMethod.h
//  MyMoon
//
//  Created by macbook110 on 14-6-30.
//  Copyright (c) 2014年 kklink. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface RegularExpressionsMethod : NSObject


+ (BOOL)validateMobile:(NSString *)mobileNum;//验证手机号码
+ (NSString *)decodeFromPercentEscapeString: (NSString *) input;

+(BOOL)validateEmail:(NSString*)email;     //判断是否邮箱地址
+(NSString *)hiddenAccountMiddleRange:(NSString*)accountString;     //影藏中间部分

+(UIColor *)ColorWithHexString: (NSString *) stringToConvert; //16进制
@end
