//
//  SLCommentsModel.h
//  SLComments
//
//  Created by 孙磊 on 16/2/23.
//  Copyright © 2016年 孙磊. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SLCommentsModel : NSObject

@property (nonatomic, copy)    NSString *headerIconStr;
@property (nonatomic, copy)    NSString *titleStr;
@property (nonatomic, copy)    NSString *txtContentStr;
@property (nonatomic, strong)  NSArray  *imageArr;
@property (nonatomic, copy)    NSString *dateStr;
@property (strong, nonatomic)  NSString *str_uid;
@property (strong, nonatomic)  NSString *str_userName;
@property (strong, nonatomic)  NSString *str_dianzan;//点赞
@property (strong, nonatomic)  NSString *str_huifu;//回复
@property (strong, nonatomic)  NSString *str_pid;

@end
