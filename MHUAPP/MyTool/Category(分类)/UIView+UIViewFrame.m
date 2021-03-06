//
//  UIView+UIViewFrame.m
//  LargeCollection
//
//  Created by wenchengjun on 2017/10/14.
//  Copyright © 2017年 jinri. All rights reserved.
//

#import "UIView+UIViewFrame.h"

@implementation UIView (UIViewFrame)

 /** * 获得当前屏幕的宽度 */
+ (CGFloat)screenWidth
{ return [UIScreen mainScreen].bounds.size.width;
}

/** * 获得当前屏幕的高度 */
+ (CGFloat)screenHeight { return [UIScreen mainScreen].bounds.size.height;
}

/** * 设置x坐标 */
- (void)setX:(CGFloat)x {
    CGRect frame = self.frame; frame.origin.x = x; self.frame = frame;
}

/** * 获取x坐标 */
- (CGFloat)x {
    return self.frame.origin.x;
}

/** * 设置y坐标 */
- (void)setY:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

/** * 获取y坐标 */
- (CGFloat)y {
    return self.frame.origin.y;
}

/** * 设置width */
- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

/** * 获取width */
- (CGFloat)width {
    return self.frame.size.width;
}

/** * 设置height */
- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

/** * 获取height */
- (CGFloat)height {
    return self.frame.size.height;
}

/** * 设置size */
- (void)setSize:(CGSize)size {
    [self setWidth:size.width];
    [self setHeight:size.height];
}

/** * 获取size */
- (CGSize)size {
    return self.frame.size;
}

/** * 设置origin */
- (void)setOrigin:(CGPoint)origin {
    [self setX:origin.x];
    [self setY:origin.y];
}

/** * 获取origin */
- (CGPoint)origin {
    return self.frame.origin;
}
- (CGFloat) Bottom
{
    return self.frame.origin.y + self.frame.size.height;
}
- (CGFloat)Right {
    return self.frame.origin.x + self.width;
}

- (void) setBottom: (CGFloat) newbottom
{
    CGRect newframe = self.frame;
    newframe.origin.y = newbottom - self.frame.size.height;
    self.frame = newframe;
}

-(CGFloat)dc_centerX{

    return self.center.x;
}

-(void)setDc_centerX:(CGFloat)dc_centerX{

    CGPoint dcFrmae = self.center;
    dcFrmae.x = dc_centerX;
    self.center = dcFrmae;
}

-(CGFloat)dc_centerY{

    return self.center.y;
}

-(void)setDc_centerY:(CGFloat)dc_centerY{

    CGPoint dcFrmae = self.center;
    dcFrmae.y = dc_centerY;
    self.center = dcFrmae;
}
@end
