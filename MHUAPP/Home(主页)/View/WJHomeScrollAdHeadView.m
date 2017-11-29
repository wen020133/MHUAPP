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
        [self setUIInit];
    }
    return self;
}

-(void)setUIInit
{
    self.backgroundColor = [UIColor whiteColor];
    _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kMSScreenWith, self.height) delegate:self placeholderImage:nil];
    _cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
    _cycleScrollView.autoScrollTimeInterval = 5.0;
    
    [self addSubview:_cycleScrollView];
}
#pragma mark - 点击广告跳转
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    NSLog(@"点击了%zd广告图",index);
}

#pragma mark - 布局
- (void)layoutSubviews
{
    [super layoutSubviews];
}
-(void)setModel:(WJHeadScrModel *)model
{
     _cycleScrollView.imageURLStringsGroup = @[@"http://gfs4.gomein.net.cn/T1DZAvBQbg1RCvBVdK.jpg",@"http://gfs9.gomein.net.cn/T1CoJvBXV_1RCvBVdK.jpg",@"http://gfs3.gomein.net.cn/T1C.EvBjJ_1RCvBVdK.jpg",@"http://gfs4.gomein.net.cn/T1DZAvBQbg1RCvBVdK.jpg"];
}
@end
