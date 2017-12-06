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

+(BOOL)validateEmail:(NSString*)email;     //判断是否邮箱地址
+(NSString *)hiddenAccountMiddleRange:(NSString*)accountString;     //影藏中间部分

+(UIColor *)ColorWithHexString: (NSString *) stringToConvert; //16进制

//计算字符串宽度
+(CGFloat)widthOfString:(NSString *)string font:(UIFont *)font height:(CGFloat)height;

//下划线
+ (void)dc_setUpAcrossPartingLineWith:(UIView *)view WithColor:(UIColor *)color;

#pragma mark - 竖线
+ (void)dc_setUpLongLineWith:(UIView *)view WithColor:(UIColor *)color WithHightRatio:(CGFloat)ratio;


#pragma mark - 首行缩进
+ (void)dc_setUpLabel:(UILabel *)label Content:(NSString *)content IndentationFortheFirstLineWith:(CGFloat)emptylen;

#pragma mark -  根据传入字体大小计算字体宽高
+ (CGSize)dc_calculateTextSizeWithText : (NSString *)text WithTextFont: (NSInteger)textFont WithMaxW : (CGFloat)maxW ;
@end
