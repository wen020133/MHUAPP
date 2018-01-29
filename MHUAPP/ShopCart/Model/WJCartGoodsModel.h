//
//  WJCartGoodsModel.h
//  MHUAPP
//
//  Created by jinri on 2018/1/25.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WJCartGoodsModel : NSObject

@property (nonatomic,assign) BOOL select;

@property (assign,nonatomic)NSInteger count;
@property (copy,nonatomic)NSString *goodsID;
@property (copy,nonatomic)NSString *goodsName;
@property (copy,nonatomic)NSString *price;
@property (strong,nonatomic)UIImage *image;

@end
