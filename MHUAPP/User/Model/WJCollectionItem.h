//
//  WJCollectionItem.h
//  MHUAPP
//
//  Created by jinri on 2017/12/29.
//  Copyright © 2017年 wenchengjun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WJCollectionItem : NSObject

@property (assign,nonatomic)BOOL select;

@property (copy,nonatomic) NSString *num;
@property (copy,nonatomic) NSString *logo;
@property (copy,nonatomic) NSString *supplier_name;
@property (copy,nonatomic) NSString *supplier_title;
@property (copy,nonatomic) NSString *supplier_id;
@property (copy,nonatomic) NSString *guanzhu_id;
@end
