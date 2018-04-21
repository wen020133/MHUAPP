//
//  WJJingXuanShopItem.h
//  MHUAPP
//
//  Created by jinri on 2018/4/19.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WJJingXuanShopItem : NSObject
/** 店铺的ID  */
@property (nonatomic, copy ,readonly) NSString *supplier_id;
/** 店铺的名称  */
@property (nonatomic, copy ,readonly) NSString *supplier_name;
/** 店铺的标题  */
@property (nonatomic, copy ,readonly) NSString *supplier_title;
/** 店铺的logo  */
@property (nonatomic, copy ,readonly) NSString *logo;
@end
