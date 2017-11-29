//
//  WJGoodsDataModel.h
//  MHUAPP
//
//  Created by jinri on 2017/11/29.
//  Copyright © 2017年 wenchengjun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WJGoodsDataModel : NSObject
/** 图片  */
@property (nonatomic, copy ,readonly) NSString *goodsIconImage;
/** 标题  */
@property (nonatomic, copy ,readonly) NSString *goodsTitle;
/** 价格  */
@property (nonatomic, copy ,readonly) NSString *goodPrice;
/** 销量  */
@property (nonatomic, copy ,readonly) NSString *goodSaveAmount;
/** ID  */
@property (nonatomic, copy ,readonly) NSString *goodID;

@end
