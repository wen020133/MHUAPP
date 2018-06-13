//
//  WJDetailShufflingHeadView.m
//  MHUAPP
//
//  Created by jinri on 2017/12/4.
//  Copyright © 2017年 wenchengjun. All rights reserved.
//

#import "WJDetailShufflingHeadView.h"
#import <SDCycleScrollView.h>
#import "UIView+UIViewFrame.h"

@interface WJDetailShufflingHeadView ()<SDCycleScrollViewDelegate>

/* 轮播图 */
@property (strong , nonatomic)SDCycleScrollView *cycleScrollView;
/* 指示器 */
@property (strong , nonatomic) UILabel *lab_count;
@end

@implementation WJDetailShufflingHeadView

#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {

    self = [super initWithFrame:frame];
    if (self) {

        [self setUpUI];
    }
    return self;
}

- (void)setUpUI
{
    self.backgroundColor = [UIColor clearColor];
    _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kMSScreenWith, self.height) delegate:self placeholderImage:nil];
    _cycleScrollView.autoScroll = NO; // 不自动滚动
    _cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleNone;
    [self addSubview:_cycleScrollView];

    _lab_count = LabelInit(kMSScreenWith-40, self.height-20, 30, 15);
    _lab_count.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5];
    _lab_count.textAlignment = NSTextAlignmentCenter;
    _lab_count.textColor = [UIColor whiteColor];
    //设置边角
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_lab_count.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(7, 7)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = _lab_count.bounds;
    maskLayer.path = maskPath.CGPath;
    _lab_count.layer.mask = maskLayer;


    _lab_count.font = PFR13Font;
    [_cycleScrollView addSubview:_lab_count];
}

#pragma mark - 点击图片Bannar跳转
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    NSLog(@"点击了%zd轮播图",index);
}

/** 图片滚动回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index
{
     _lab_count.text = [NSString stringWithFormat:@"%ld/%ld",index+1,_shufflingArray.count];
}
#pragma mark - Setter Getter Methods
- (void)setShufflingArray:(NSArray *)shufflingArray
{
    NSMutableArray *arr = [NSMutableArray array];
    for (NSDictionary *dic in shufflingArray) {
        [arr addObject:dic[@"img_original"]];
    }
    _shufflingArray = arr;
    _cycleScrollView.imageURLStringsGroup = arr;
    _lab_count.text = [NSString stringWithFormat:@"1/%ld",_shufflingArray.count];
}

@end
