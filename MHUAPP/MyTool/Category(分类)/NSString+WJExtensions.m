//
//  NSString+WJExtensions.m
//  MHUAPP
//
//  Created by jinri on 2017/12/8.
//  Copyright © 2017年 wenchengjun. All rights reserved.
//

#import "NSString+WJExtensions.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (WJExtensions)

- (NSString *)md5
{
    const char *concat_str = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(concat_str, (CC_LONG)strlen(concat_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++)
        [hash appendFormat:@"%02X", result[i]];
    return [hash lowercaseString];
}

//- (NSString *) md5
//{
//    const char *cStr = [self UTF8String];
//    unsigned char result[16];
//
//    CC_MD5( cStr, strlen(cStr), result ); // This is the md5 call
//    return [NSString stringWithFormat:
//            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
//            result[0], result[1], result[2], result[3],
//            result[4], result[5], result[6], result[7],
//            result[8], result[9], result[10], result[11],
//            result[12], result[13], result[14], result[15]
//            ];
//}

@end
