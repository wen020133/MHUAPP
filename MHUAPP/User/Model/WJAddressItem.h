//
//  WJAddressItem.h
//  MHUAPP
//
//  Created by jinri on 2017/12/15.
//  Copyright © 2017年 wenchengjun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WJAddressItem : NSObject
/** 详细地址 */
@property (nonatomic, strong) NSString *assemble_site;
/** 手机 */
@property (nonatomic, strong) NSString *mobile;

@property (nonatomic,copy) NSString * region_name;//名称
@property (nonatomic,copy) NSString * region_id;


@property (nonatomic, strong) NSString *site_id; //地址id

/** 固定号码 */
@property (nonatomic, strong) NSString *phone;
/** 是否默认 */
@property (nonatomic, strong) NSString *is_default;
/** 收件人 */
@property (nonatomic, strong) NSString *consignee;


@property (nonatomic,copy) NSString * province;
@property (nonatomic,copy) NSString * city;
@property (nonatomic,copy) NSString * district;
@property (nonatomic,copy) NSString * address;

@property (nonatomic,copy) NSString * zip_code;

@property (nonatomic,assign) BOOL  isSelected;

- (instancetype)initWithDict:(NSDictionary *)dict;

@end
