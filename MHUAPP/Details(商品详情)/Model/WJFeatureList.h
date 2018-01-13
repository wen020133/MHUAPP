//
//  WJFeatureList.h
//  MHUAPP
//
//  Created by jinri on 2018/1/9.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WJFeatureList : NSObject

/** 类型名 */
@property (nonatomic, copy) NSString *infoname;
/** 额外价格 */
@property (nonatomic, copy) NSString *plusprice;

/** 是否点击 */
@property (nonatomic,assign)BOOL isSelect;

@end
