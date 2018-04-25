//
//  WJCartShopModel.h
//  MHUAPP
//
//  Created by jinri on 2018/1/25.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WJCartShopModel : NSObject

@property (assign,nonatomic)BOOL select;
@property (copy,nonatomic)NSString *supplier_id;
@property (copy,nonatomic)NSString *supplier;
@property (copy,nonatomic)NSString *sID;
@property (strong,nonatomic,readonly)NSMutableArray *goodsArray;

- (void)configGoodsArrayWithArray:(NSArray*)array;

@end
