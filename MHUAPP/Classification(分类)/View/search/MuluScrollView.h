//
//  MuluScrollView.h
//  phoneGap
//
//  Created by wenchengjun on 14-12-1.
//
//

#import <UIKit/UIKit.h>

@protocol MuluBtnDelegate <NSObject>

- (void)didSelectedMuluBtnWithTag:(NSInteger)currTag;

@end
@interface MuluScrollView : UIView<UIScrollViewDelegate>

@property (retain, nonatomic) UIScrollView  *scrollView;
@property (retain, nonatomic) NSArray       *titles;
@property (assign, nonatomic) CGPoint       indicatouImageCenter;
@property (assign, nonatomic) id<MuluBtnDelegate>delegate;
@property (assign, nonatomic) NSInteger     selectIndex;

- (id)initWithFrame:(CGRect)frame withTitles:(NSArray *)arr;
- (void)changeMunuState:(NSInteger)index;

@end
