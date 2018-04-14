//
//  WJFollowClassItem.h
//  MHUAPP
//
//  Created by jinri on 2018/4/13.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WJFollowClassItem : NSObject

@property (nonatomic,assign) BOOL select;

@property (assign,nonatomic)NSInteger count;
@property (copy,nonatomic)NSString *goodsID;
@property (copy,nonatomic)NSString *goodsName;
@property (copy,nonatomic)NSString *price;
@property (copy,nonatomic)NSString *attribute;
@property (copy,nonatomic)NSString *youhui;
@property (copy,nonatomic) NSString *image;

@end
