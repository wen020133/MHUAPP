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
@property (nonatomic, copy)    NSString *content;
@property (nonatomic, copy)    NSString *add_time;
@property (strong, nonatomic)  NSString *comment_rank;
@property (strong, nonatomic)  NSString *user_name;
@property (nonatomic, strong)  NSArray  *imageArr;
@property (nonatomic, strong)  NSString  *hide_username;
@end
