//
//  AliPayManagers.h
//  IOS_XW
//
//  Created by add on 15/11/17.
//  Copyright (c) 2015年 lan. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^SuccessResult)(void);
typedef void(^FailResult)(void);



@interface AliPayManagers : NSObject
@property (nonatomic, strong) NSString *infoStr;
+(AliPayManagers *)shareInstance;
-(void)payWithSuccess:(SuccessResult)sresult fail:(FailResult)fresult;
@end
