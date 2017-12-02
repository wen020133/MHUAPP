//
//  WJSildeBarView.h
//  MHUAPP
//
//  Created by jinri on 2017/12/1.
//  Copyright © 2017年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WJFiltrateViewController.h"

@interface WJSildeBarView : UIView<UIGestureRecognizerDelegate>
/* show */
+(void)dc_showSildBarViewController;

@property (nonatomic,strong) UIView *coverView;//遮罩
@property (nonatomic,strong) WJFiltrateViewController *filterView;//筛选视图


@end
