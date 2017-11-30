//
//  WJNavSearchBarView.h
//  MHUAPP
//
//  Created by jinri on 2017/11/30.
//  Copyright © 2017年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WJNavSearchBarView : UIView
/* 占位文字 */
@property (strong , nonatomic)UILabel *placeholdLabel;

/** 搜索 */
@property (nonatomic, copy) dispatch_block_t searchViewBlock;



@end
