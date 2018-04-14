//
//  WJMainZhuanTiHDItem.h
//  MHUAPP
//
//  Created by jinri on 2018/4/14.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WJMainZhuanTiHDItem : NSObject
/** 图片  */
@property (nonatomic, copy ,readonly) NSString *topic_img;
/** 标题  */
@property (nonatomic, copy ,readonly) NSString *title;
/** 简介  */
@property (nonatomic, copy ,readonly) NSString *intro;
/** ad_id  */
@property (nonatomic, copy ,readonly) NSString *topic_id;

@end
