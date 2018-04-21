//
//  WJFeatureItem.h
//  MHUAPP
//
//  Created by jinri on 2018/1/11.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WJFeatureTitleItem.h"
#import "WJFeatureList.h"

@interface WJFeatureItem : NSObject

/* 名字 */
@property (strong , nonatomic) WJFeatureTitleItem *attr;
/* 数组 */
@property (strong , nonatomic) NSArray<WJFeatureList *> *list;

/** 类型名 */
@property (nonatomic, copy) NSString *attr_value;
/** 额外价格 */
@property (nonatomic, copy) NSString *attr_price;
/** 是否点击 */
@property (nonatomic,assign)BOOL isSelect;
@end
