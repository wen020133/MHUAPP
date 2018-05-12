//
//  SLCommentsModel.h
//  SLComments
//
//  Created by 孙磊 on 16/2/23.
//  Copyright © 2016年 孙磊. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SLCommentsModel : NSObject

@property (nonatomic, copy)    NSString *logo;
@property (nonatomic, strong)  NSArray  *may_goods;
@property (nonatomic, copy)    NSString *supplier_type;
@property (strong, nonatomic)  NSString *supplier_id;
@property (strong, nonatomic)  NSString *supplier_name;
@property (strong, nonatomic)  NSString *supplier_title;

@end
