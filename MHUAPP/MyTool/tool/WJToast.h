//
//  WJToast.h
//  MHUAPP
//
//  Created by wenchengjun on 2018/8/29.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WJToast : UIView

#pragma mark - 图文toast提示
/** 图文toast提示 */
+ (void)showToastWithMessage:(NSString *)message checkCouponButtonClickedBlock:(void(^)(void))checkButtonClickedBlock;

@end
