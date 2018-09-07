//
//  WJMessageClassViewController.h
//  MHUAPP
//
//  Created by wenchengjun on 2017/11/28.
//  Copyright © 2017年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseNetworkViewController.h"
typedef NS_ENUM(NSInteger, KGetMessageClassType) {
    KGetAllChatList = 1 ,//获取未读条数
    KGetChatMsg = 2 ,//好友列表
};

@interface WJMessageClassViewController : BaseNetworkViewController
@property (assign, nonatomic) KGetMessageClassType serverType;
@end
