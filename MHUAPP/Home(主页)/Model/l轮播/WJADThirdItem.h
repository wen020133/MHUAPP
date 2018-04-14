//
//  WJADThirdItem.h
//  MHUAPP
//
//  Created by jinri on 2018/4/14.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WJADThirdItem : NSObject
/** 图片  */
@property (nonatomic, copy ,readonly) NSString *ad_code;
/** 标题  */
@property (nonatomic, copy ,readonly) NSString *ad_name;
/** 链接  */
@property (nonatomic, copy ,readonly) NSString *ad_link;
/** ad_id  */
@property (nonatomic, copy ,readonly) NSString *ad_id;
@end
