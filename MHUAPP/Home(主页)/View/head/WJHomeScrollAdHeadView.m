//
//  WJHomeScrollAdHeadView.m
//  MHUAPP
//
//  Created by wenchengjun on 2017/11/28.
//  Copyright © 2017年 wenchengjun. All rights reserved.
//

#import "WJHomeScrollAdHeadView.h"
#import <SDCycleScrollView.h>
#import "UIView+UIViewFrame.h"


@interface WJHomeScrollAdHeadView ()<SDCycleScrollViewDelegate>

@property (strong, nonatomic) SDCycleScrollView *cycleScrollView;

@end

@implementation WJHomeScrollAdHeadView

-(instancetype) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

-(void)setUIInit
{
    self.backgroundColor = [UIColor whiteColor];
    _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kMSScreenWith, self.height) delegate:self placeholderImage:nil];
    _cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
    _cycleScrollView.autoScrollTimeInterval = 5.0;
    _cycleScrollView.backgroundColor = [UIColor whiteColor];
    _cycleScrollView.currentPageDotColor = [UIColor redColor];
    _cycleScrollView.pageDotColor = [UIColor lightGrayColor];
    NSMutableArray *arr = [NSMutableArray array];
    for (int aa=0; aa<self.imageArr.count; aa++) {
        [arr addObject:self.imageArr[aa].ad_code];
    }
    _cycleScrollView.imageURLStringsGroup = arr;
    [self addSubview:_cycleScrollView];
}
#pragma mark - 点击广告跳转
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    NSLog(@"点击了%zd广告图",index);
    !_goToADAction ? : _goToADAction(index);
}

#pragma mark - 布局
- (void)layoutSubviews
{
    [super layoutSubviews];
}

@end
