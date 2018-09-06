//
//  RCDataManager.h
//  RCIM
//
//  Created by 郑文明 on 15/12/30.
//  Copyright © 2015年 郑文明. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RCDataManager : NSObject
/**
 *  RCDataManager单例对象
 *
 *  @return RCDataManager单例
 */
+(RCDataManager *) shareManager;

- (void)getUserInfoWithMiYouMei;

@end
