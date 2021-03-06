//
//  WJGoodsGridViewCell.m
//  MHUAPP
//
//  Created by wenchengjun on 2017/11/28.
//  Copyright © 2017年 wenchengjun. All rights reserved.
//

#import "WJGoodsGridViewCell.h"
#import <UIImageView+WebCache.h>
#import "UIView+UIViewFrame.h"
// 指示器高度
#define kIndicatorH 5
// 指示器宽度
#define kIndicatorW 16
// 指示器背景宽度
#define kIndicatorBackViewW 48

@interface WJGoodsGridViewCell()
/** 个数 */
@property (assign, nonatomic) NSInteger itemCounts;
/** 行数 */
@property (assign, nonatomic) NSInteger lineNumber;
/** 列数 */
@property (assign, nonatomic) NSInteger columnNumber;

/** 指示器背景 */
@property (strong, nonatomic) UIView *indicatorBackView;
/** 指示器 */
@property (strong, nonatomic) UIView *indicatorView;

@end

@implementation WJGoodsGridViewCell



- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        _defaultImgArr = @[@"Home_icon_xianshimiaosha",@"Home_icon_shishipintuan",@"Home_icon_xianshizhekou",@"Home_icon_jingxuandianpu",@"Home_icon_remaishangpin",@"Home_icon_youzhixinpin",@"Home_icon_jifenshangcheng",@"Home_icon_quanbushangpin"];
        _defaultTitleArr = @[@"限时秒杀",@"采购批发",@"限时折扣",@"精选店铺",@"热卖商品",@"优质新品",@"精品推荐",@"全部商品"];
        _itemCounts = _defaultImgArr.count;
        _lineNumber = 2;
        _columnNumber = 4;
        [self setUpUI];
        
    }
    return self;
}
#pragma mark -- 懒加载
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _scrollView.backgroundColor = [UIColor whiteColor];
        _scrollView.pagingEnabled = YES;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.delegate = self;

    }
    return _scrollView;
}
- (UIView *)indicatorBackView {
    if (!_indicatorBackView) {
        _indicatorBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kIndicatorBackViewW, kIndicatorH)];
        _indicatorBackView.backgroundColor = [UIColor whiteColor];
        _indicatorBackView.layer.borderWidth = 1;
        _indicatorBackView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    }
    return _indicatorBackView;
}

- (UIView *)indicatorView {
    if (!_indicatorView) {
        _indicatorView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kIndicatorW, kIndicatorH)];
        _indicatorView.backgroundColor = [UIColor redColor];
    }
    return _indicatorView;
}

- (void)setUpUI
{
    for (UIView *view in self.scrollView.subviews) {
        [view removeFromSuperview];
    }
    [self addSubview:self.scrollView];

//    [self addSubview:self.indicatorBackView];
    self.indicatorBackView.center = CGPointMake(self.center.x, CGRectGetMaxY(self.scrollView.frame) - 9);
    
    [self.indicatorBackView addSubview:self.indicatorView];
    
    CGFloat width = kMSScreenWith/8;
     NSInteger pageCount = ceilf((CGFloat)self.itemCounts / (self.lineNumber * self.columnNumber));
    self.scrollView.contentSize = CGSizeMake(self.frame.size.width * pageCount, self.frame.size.height);

    NSInteger countNumber = 0;
    // 几页
    for (NSInteger page = 0; page < pageCount; page ++) {

        // 几行
        for (NSInteger x = 0; x < self.lineNumber; x ++) {
            // 几列
            for (NSInteger y = 0; y < self.columnNumber; y ++) {

                if (countNumber == self.itemCounts) {
                    return;
                }

                UIImageView *iamgeV = [[UIImageView alloc]initWithFrame:CGRectMake(page * kMSScreenWith + width/2+y*kMSScreenWith/_columnNumber, 13+ (x * (self.height-10)/2), width, width)];
                iamgeV.image = [UIImage imageNamed:_defaultImgArr[countNumber]];

                [self.scrollView addSubview:iamgeV];


                UILabel *titleLabel = LabelInit(page * kMSScreenWith + y*kMSScreenWith/_columnNumber, width+18+ (x * (self.height-10)/2), kMSScreenWith/_columnNumber, 20);
                titleLabel.font = PFR13Font;
                titleLabel.text = _defaultTitleArr[countNumber];
                titleLabel.textColor = [RegularExpressionsMethod ColorWithHexString:@"333333"];
                titleLabel.textAlignment = NSTextAlignmentCenter;
                [self.scrollView addSubview:titleLabel];

                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                btn.frame = CGRectMake(page * kMSScreenWith + y*kMSScreenWith/_columnNumber,  x *self.height/2, kMSScreenWith/_columnNumber, self.height/2);
                btn.tag = countNumber+1000;
                btn.backgroundColor = [UIColor clearColor];
                [btn addTarget:self action:@selector(toJump:) forControlEvents:UIControlEventTouchUpInside];
                [self.scrollView addSubview:btn];

                countNumber ++;

                }

            }
        }
}
#pragma mark -
#pragma mark -- UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGRect frame = self.indicatorView.frame;
    frame.origin.x = scrollView.contentOffset.x * (kIndicatorBackViewW -  kIndicatorW) / (scrollView.contentSize.width - self.frame.size.width);
    self.indicatorView.frame = frame;
    
}
- (void)toJump:(UIButton *)sender
{
    !_goToALLTypeAction ? : _goToALLTypeAction(sender.tag);
}

@end
