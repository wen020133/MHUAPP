//
//  WJLogisticsModel.m
//  MHUAPP
//
//  Created by jinri on 2018/5/8.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import "WJLogisticsModel.h"

@interface WJLogisticsModel ()

@property (nonatomic, assign) CGFloat tempHeight;

@end

@implementation WJLogisticsModel

-(CGFloat)height
{
    if (_tempHeight == 0) {
        NSDictionary *dict = [NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:12.0] forKey:NSFontAttributeName];
        CGRect rect = [self.dsc boundingRectWithSize:CGSizeMake(kMSScreenWith - 50 - 2 * 10, CGFLOAT_MAX) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
        _tempHeight = rect.size.height + 50;
    }
    return _tempHeight;
}

@end
