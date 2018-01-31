//
//  WJAddressItem.m
//  MHUAPP
//
//  Created by jinri on 2017/12/15.
//  Copyright © 2017年 wenchengjun. All rights reserved.
//

#import "WJAddressItem.h"

@implementation WJAddressItem
- (instancetype)initWithDict:(NSDictionary *)dict{

    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{

}
@end
