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
/** 地址id */
@property (nonatomic, strong) NSString *site_id;
/** 固定号码 */
@property (nonatomic, strong) NSString *phone;
/** 是否默认 */
@property (nonatomic, strong) NSString *is_default;
/** 收件人 */
@property (nonatomic, strong) NSString *consigner;
/** 省 */
@property (nonatomic, strong) NSString *province;
/** 市 */
@property (nonatomic, strong) NSString *city;
/** 县 */
@property (nonatomic, strong) NSString *district;
/** 邮编 */
@property (nonatomic, strong) NSString *zip_code;
/** 详细地址 */
@property (nonatomic, strong) NSString *address;
@end
