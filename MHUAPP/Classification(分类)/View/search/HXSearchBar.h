//
//  HXSearchBar.h
//  黄轩博客 blog.libuqing.com
//  https://github.com/huangxuan518/HXSearchBar  
//  Created by 黄轩 on 2017/1/18.
//  Copyright © 2017年 黄轩 IT小子. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HXSearchBar : UIView<UITextFieldDelegate>

@property (nonatomic,strong) UIColor *cursorColor;//光标颜色
@property (nonatomic,strong) UITextField *searchBarTextField;//搜索框TextField
@property (nonatomic,strong) UIImage *clearButtonImage;//输入框清除按钮图片

@end
