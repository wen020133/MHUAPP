//
//  WJDetailPartCommentItem.h
//  MHUAPP
//
//  Created by jinri on 2018/4/19.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WJDetailPartCommentItem : NSObject
@property (nonatomic, copy)    NSString *headerIconStr;
@property (nonatomic, copy)    NSString *titleStr;
@property (nonatomic, copy)    NSString *txtContentStr;
@property (nonatomic, strong)  NSArray  *imageArr;
@property (nonatomic, copy)    NSString *dateStr;
@property (strong, nonatomic)  NSString *str_uid;
@property (strong, nonatomic)  NSString *str_userName;
@end
