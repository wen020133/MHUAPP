//
//  WJCouponsMunuScrollView.h
//  MHUAPP
//
//  Created by jinri on 2017/12/27.
//  Copyright © 2017年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CouponDelegate <NSObject>
- (void)didSelectedButtonWithTag:(NSInteger)currTag;
@end

@interface WJCouponsMunuScrollView : UIView<UIScrollViewDelegate>


@property (retain, nonatomic) UIScrollView  *scrollView;
@property (retain, nonatomic) UIView        *indicatorImage;

@property (retain, nonatomic) NSArray       *arr_titles;
@property (assign, nonatomic) NSInteger     selectIndex;
@property (assign, nonatomic) id<CouponDelegate> delegate;

- (void)initScrollView;

- (void)changeMenuState:(NSInteger)index;
@end
