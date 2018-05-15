//
//  WJIntegralShufflingHeadView.m
//  MHUAPP
//
//  Created by jinri on 2018/5/14.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import "WJIntegralShufflingHeadView.h"
#import <SDCycleScrollView.h>
#import "UIView+UIViewFrame.h"

@interface WJIntegralShufflingHeadView ()<SDCycleScrollViewDelegate>

/* 轮播图 */
@property (strong , nonatomic)SDCycleScrollView *cycleScrollView;
/* title */
@property (strong , nonatomic) UILabel *lab_title;
@end

@implementation WJIntegralShufflingHeadView

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
    _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kMSScreenWith, kMSScreenWith/2) delegate:self placeholderImage:nil];
    _cycleScrollView.autoScroll = NO; // 不自动滚动
    _cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleNone;

    [self addSubview:_cycleScrollView];

    _lab_title = [[UILabel alloc] init];
    _lab_title.font = PFR16Font;
    _lab_title.textColor = [RegularExpressionsMethod ColorWithHexString:@"2B2B2B"];
    _lab_title.numberOfLines = 0;
    [self addSubview:_lab_title];

}

#pragma mark - 点击图片Bannar跳转
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    NSLog(@"点击了%zd轮播图",index);
}

/** 图片滚动回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index
{
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
}

-(void)setStr_title:(NSString *)str_title
{
    _lab_title.frame =CGRectMake(DCMargin, _cycleScrollView.Bottom+2, kMSScreenWith-DCMargin*2, [RegularExpressionsMethod dc_calculateTextSizeWithText:str_title WithTextFont:16 WithMaxW:kMSScreenWith - DCMargin * 2].height);
    _lab_title.text = str_title;
}
@end
