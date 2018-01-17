//
//  WJDatePicker.h
//  MHUAPP
//
//  Created by jinri on 2018/1/13.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WJDatePicker : NSObject

+ (void)showDateDetermineChooseInView:(UIView *)view
                      determineChoose:(void(^)(NSString *dateString))determineChoose;

@end
