//
//  RigisterProtocolV.h
//  MHUAPP
//
//  Created by jinri on 2017/12/9.
//  Copyright © 2017年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RigisterProtocolV : UIView<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *str_web;

/** 取消 */
@property (nonatomic, copy) dispatch_block_t cancelVieBlock;

/** 确定 */
@property (nonatomic, copy) dispatch_block_t confirmVieBlock;

@end
