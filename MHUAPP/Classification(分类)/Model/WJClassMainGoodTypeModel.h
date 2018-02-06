//
//  WJClassMainGoodTypeModel.h
//  MHUAPP
//
//  Created by jinri on 2017/11/30.
//  Copyright © 2017年 wenchengjun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WJClassMainGoodTypeModel : NSObject

/** 商品类题  */
@property (nonatomic, copy ,readonly) NSString *cat_name;

/** 商品图片  */
@property (nonatomic, copy ,readonly) NSString *category_pic;
/** 分类ID  */
@property (nonatomic, copy ,readonly) NSString *cat_id;


@end
