//
//  WJJingXuanMenuView.h
//  MHUAPP
//
//  Created by jinri on 2018/4/9.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WJJingXuanMenuView : UIView

/** 筛选点击回调 */
@property (nonatomic , copy) void(^jingxuanShopClickBlock)(NSInteger selectTag);

- (id)initWithFrame:(CGRect)frame withTitles:(NSArray *)arr;

@property (retain, nonatomic) NSArray       *Menu_titles;
@end
