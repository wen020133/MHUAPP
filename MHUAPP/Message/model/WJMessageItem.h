//
//  WJMessageItem.h
//  MHUAPP
//
//  Created by wenchengjun on 2018/9/4.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WJMessageList.h"


@interface WJMessageItem : NSObject

/* 内容 */
@property (strong , nonatomic) NSString *content;
/* 时间 */
@property (strong , nonatomic) NSString *sendtime;
/* 条数 */
@property (strong , nonatomic) NSString *unread;

@property (strong , nonatomic) NSString *supplier_id;
@property (strong , nonatomic) NSString *user_id;
@property (strong , nonatomic) NSString *supplier_name;
@property (strong , nonatomic) NSString *user_name;
@property (strong , nonatomic) NSString *headimg;

@end
