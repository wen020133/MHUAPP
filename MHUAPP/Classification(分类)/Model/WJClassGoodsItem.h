//
//  WJClassGoodsItem.h
//  MHUAPP
//
//  Created by jinri on 2017/11/30.
//  Copyright © 2017年 wenchengjun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WJClassGoodsItem : NSObject

/** 分类标题  */
@property (nonatomic, copy ,readonly) NSString *category_name;
/** 分类ID  */
@property (nonatomic, copy ,readonly) NSString *category_id;
/** 分类图片  */
@property (nonatomic, copy ,readonly) NSString *category_pic;

@end
