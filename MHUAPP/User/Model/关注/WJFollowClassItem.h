//
//  WJFollowClassItem.h
//  MHUAPP
//
//  Created by jinri on 2018/4/13.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WJFollowClassList.h"

@interface WJFollowClassItem : NSObject

@property (nonatomic,assign) BOOL select;

@property (strong,nonatomic) NSString *rec_id;
@property (strong,nonatomic) WJFollowClassList *goods;

@end
