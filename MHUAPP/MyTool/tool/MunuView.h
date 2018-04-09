//
//  MunuView.h
//  phoneGap
//
//  Created by wenchengjun on 14-12-7.
//
//

#import <UIKit/UIKit.h>
@protocol MunuViewDelegate <NSObject>
- (void)didSelectedButtonWithTag:(NSInteger)currTag;
@end


@interface MunuView : UIView<UIScrollViewDelegate>

@property (retain, nonatomic) UIScrollView  *scrollView;
@property (retain, nonatomic) UIView        *indicatorImage;

@property (retain, nonatomic) NSArray       *Menu_titles;

@property (assign, nonatomic) NSInteger     selectIndex;
@property (assign, nonatomic) id<MunuViewDelegate> delegate;

- (id)initWithFrame:(CGRect)frame withTitles:(NSArray *)arr;
- (void)changeMenuState:(NSInteger)index;

@end
