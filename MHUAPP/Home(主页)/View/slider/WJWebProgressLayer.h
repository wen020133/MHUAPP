//
//  WJWebProgressLayer.h
//  MHUAPP
//
//  Created by wenchengjun on 2018/8/21.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@interface WJWebProgressLayer : CAShapeLayer

- (void)finishedLoad;
- (void)startLoad;

- (void)closeTimer;

@end
