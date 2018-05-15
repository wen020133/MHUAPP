//
//  WJStoreHeadCollectionView.m
//  MHUAPP
//
//  Created by wenchengjun on 2018/5/13.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import "WJStoreHeadCollectionView.h"
#import "UIView+UIViewFrame.h"
//#import <SDCycleScrollView.h>

@interface WJStoreHeadCollectionView()
//@property (strong, nonatomic) SDCycleScrollView *cycleScrollView;

@property (strong , nonatomic) UIView *view_head;



/* 收藏 */
@property (strong , nonatomic) UIButton *btnSeeAll;


@end

@implementation WJStoreHeadCollectionView
#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUpUI];
    }
    return self;
}

-(void)setUpUI
{
    self.backgroundColor = kMSCellBackColor;
    _view_head = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kMSScreenWith, 220)];
    [self addSubview:_view_head];
    
    UIImageView *backV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"topbg.jpg"]];
    backV.frame = _view_head.frame;
    [_view_head addSubview:backV];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.textColor = kMSViewTitleColor;
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.font = PFR20Font;
    [_view_head addSubview:_titleLabel];
    
    
    _headImageView = [[UIImageView alloc] init];
    _headImageView.contentMode = UIViewContentModeScaleAspectFill;
    _headImageView.layer.masksToBounds = YES;
    _headImageView.layer.cornerRadius = 34;
    [_view_head addSubview:_headImageView];
    
    
    UIImageView *baalpha = ImageViewInit(0, 160, kMSScreenWith, 60);
    baalpha.backgroundColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.5];
    [_view_head addSubview:baalpha];
    
    NSArray *arrTitle = [NSArray arrayWithObjects:@"全部宝贝",@"商品描述",@"服务态度",@"物流速度", nil];
    for (int aa=0; aa<arrTitle.count; aa++) {
        UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(kMSScreenWith/4*(aa+1), 160, 1, 60)];
        line.backgroundColor = [RegularExpressionsMethod ColorWithHexString:@"E6E6E6"];
        [_view_head addSubview:line];
        
        UILabel *labMyOrder = [[UILabel alloc] initWithFrame:CGRectMake(kMSScreenWith/4*aa, 170, kMSScreenWith/4, 20)];
        labMyOrder.font = PFR12Font;
        labMyOrder.textColor = kMSCellBackColor;
        labMyOrder.textAlignment = NSTextAlignmentCenter;
        labMyOrder.text = [arrTitle objectAtIndex:aa];
        [_view_head addSubview:labMyOrder];
        
    }
    
    _btnSeeAll = [UIButton buttonWithType:UIButtonTypeCustom];
    _btnSeeAll.frame = CGRectMake(kMSScreenWith-40, 25, 30, 29);
    [_btnSeeAll setBackgroundImage:[UIImage imageNamed:@"jxdp_shoucang"] forState:UIControlStateNormal];
    [_btnSeeAll addTarget:self action:@selector(jxdp_shoucang) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_btnSeeAll];
    
    _lab_allGood = [[UILabel alloc] initWithFrame:CGRectMake(0, 190, kMSScreenWith/4, 30)];
    _lab_allGood.backgroundColor = [UIColor clearColor];
    _lab_allGood.textColor = kMSViewTitleColor;
    _lab_allGood.textAlignment = NSTextAlignmentCenter;
    _lab_allGood.font = Font(18);
    [_view_head addSubview:_lab_allGood];
    
    _lab_shangjiaMiaosuNum = [[UILabel alloc] initWithFrame:CGRectMake(kMSScreenWith/4, 190, kMSScreenWith/4, 30)];
    _lab_shangjiaMiaosuNum.backgroundColor = [UIColor clearColor];
    _lab_shangjiaMiaosuNum.textColor = kMSViewTitleColor;
    _lab_shangjiaMiaosuNum.textAlignment = NSTextAlignmentCenter;
    _lab_shangjiaMiaosuNum.font = Font(18);
    _lab_shangjiaMiaosuNum.text = @"5.0";
    [_view_head addSubview:_lab_shangjiaMiaosuNum];
    
    _lab_fuwuNum = [[UILabel alloc] initWithFrame:CGRectMake(kMSScreenWith/2, 190, kMSScreenWith/4, 30)];
    _lab_fuwuNum.backgroundColor = [UIColor clearColor];
    _lab_fuwuNum.textColor = kMSViewTitleColor;
    _lab_fuwuNum.textAlignment = NSTextAlignmentCenter;
    _lab_fuwuNum.font = Font(18);
    _lab_fuwuNum.text = @"5.0";
    [_view_head addSubview:_lab_fuwuNum];
    
    _lab_wlSuduNum = [[UILabel alloc] initWithFrame:CGRectMake(kMSScreenWith/4*3, 190, kMSScreenWith/4, 30)];
    _lab_wlSuduNum.backgroundColor = [UIColor clearColor];
    _lab_wlSuduNum.textColor = kMSViewTitleColor;
    _lab_wlSuduNum.textAlignment = NSTextAlignmentCenter;
    _lab_wlSuduNum.text = @"5.0";
    _lab_wlSuduNum.font = Font(18);
    [_view_head addSubview:_lab_wlSuduNum];
    
//    _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 240, kMSScreenWith, kMSScreenWith/2) delegate:self placeholderImage:nil];
//    _cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
//    _cycleScrollView.autoScrollTimeInterval = 5.0;
//    _cycleScrollView.backgroundColor = [UIColor whiteColor];
//    _cycleScrollView.currentPageDotColor = [UIColor redColor];
//    _cycleScrollView.localizationImageNamesGroup = @[@"home_banner_img.png",@"home_banner_img.png",@"home_banner_img.png",@"home_banner_img.png",@"home_banner_img.png",@"home_banner_img.png"];
//    _cycleScrollView.pageDotColor = [UIColor lightGrayColor];
//    [self addSubview:_cycleScrollView];
}
//#pragma mark - 点击广告跳转
//- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
//    NSLog(@"点击了%zd广告图",index);
//}


-(void)jxdp_shoucang
{
    !_goToTuijianGoodBlock ?: _goToTuijianGoodBlock();
}
#pragma mark - 布局
- (void)layoutSubviews
{
    [super layoutSubviews];

    [_headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.top.mas_equalTo(self)setOffset:20];
        make.size.mas_equalTo(CGSizeMake(68, 68));
        make.centerX.mas_equalTo(self.mas_centerX);
    }];

    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.top.mas_equalTo(_headImageView.mas_top)setOffset:20];
        make.centerX.mas_equalTo(_view_head.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(200, 30));
        
    }];

    
    
}

@end
