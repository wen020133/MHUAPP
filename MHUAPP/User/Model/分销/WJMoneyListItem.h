//
//  WJMoneyListItem.h
//  MHUAPP
//
//  Created by wenchengjun on 2018/8/24.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WJMoneyListItem : NSObject

@property (copy,nonatomic) NSString *ewm_type;
@property (copy,nonatomic) NSString *ewmUrl;
@property (copy,nonatomic) NSString *pay_status;
@property (copy,nonatomic) NSString *add_time;
@property (copy,nonatomic) NSString *real_name;
@property (copy,nonatomic) NSString *type;
@property (copy,nonatomic) NSString *paid_time;
@property (copy,nonatomic) NSString *is_paid;
@property (copy,nonatomic) NSString *amount;
@property (copy,nonatomic) NSString *log_id;
@property (copy,nonatomic) NSString *account_name;
@property (copy,nonatomic) NSString *phone;
@property (copy,nonatomic) NSString *admin_note;
@property (copy,nonatomic) NSString *admin_user;
@property (copy,nonatomic) NSString *user_note;
@end
