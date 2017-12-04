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
    self.backgroundColor = [UIColor whiteColor];
    _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kMSScreenWith, self.height) delegate:self placeholderImage:nil];
    _cycleScrollView.autoScroll = NO; // 不自动滚动
    _cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleNone;

    [self addSubview:_cycleScrollView];

    _lab_count = LabelInit(kMSScreenWith-40, self.height-20, 30, 15);
    _lab_count.backgroundColor = [RegularExpressionsMethod ColorWithHexString:kMSVCBackgroundColor];
    _lab_count.textColor = [UIColor whiteColor];
    [_lab_count sizeToFit];
    [self addSubview:_lab_count];
}

#pragma mark - 点击图片Bannar跳转
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    NSLog(@"点击了%zd轮播图",index);
}

/** 图片滚动回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index
{
     _lab_count.text = [NSString stringWithFormat:@"%ld/%ld",index,_shufflingArray.count];
}
#pragma mark - Setter Getter Methods
- (void)setShufflingArray:(NSArray *)shufflingArray
{
    _shufflingArray = shufflingArray;
    _cycleScrollView.imageURLStringsGroup = shufflingArray;
    _lab_count.text = [NSString stringWithFormat:@"1/%ld",_shufflingArray.count];
}

@end
