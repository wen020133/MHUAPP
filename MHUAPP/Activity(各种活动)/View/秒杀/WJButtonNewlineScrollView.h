//
//  WJButtonNewlineScrollView.h
//  MHUAPP
//
//  Created by jinri on 2018/1/4.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ButtonNewlineDelegate <NSObject>
- (void)didSelectedButtonWithTag:(NSInteger)currTag;
@end


@interface WJButtonNewlineScrollView : UIView<UIScrollViewDelegate>


@property (retain, nonatomic) UIScrollView  *scrollView;

@property (retain, nonatomic) NSArray       *arr_titles;
@property (assign, nonatomic) NSInteger     selectIndex;
@property (assign, nonatomic) id<ButtonNewlineDelegate> delegate;

- (void)initScrollView;

- (void)changeMenuState:(NSInteger)index;

@end
