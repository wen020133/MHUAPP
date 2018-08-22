//
//  NSTimer+Addition.h
//  MHUAPP
//
//  Created by wenchengjun on 2018/8/22.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (Addition)

- (void)pause;
- (void)resume;
- (void)resumeWithTimeInterval:(NSTimeInterval)time;

@end
