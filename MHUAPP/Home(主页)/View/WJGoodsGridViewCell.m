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


@interface WJGoodsGridViewCell()
/** 个数 */
@property (assign, nonatomic) NSInteger itemCounts;
/** 行数 */
@property (assign, nonatomic) NSInteger lineNumber;
/** 列数 */
@property (assign, nonatomic) NSInteger columnNumber;


@end

@implementation WJGoodsGridViewCell



- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        _defaultImgArr = @[@"img_btn_wuliu",@"img_btn_jipiao",@"img_btn_chongzhi",@"img_btn_zhuanti",@"img_btn_shiping",@"img_btn_jipiao",@"img_btn_wuliu",@"img_btn_lingquan",@"img_btn_chongzhi",@"img_btn_zhuanti",@"img_btn_shiping",@"img_btn_jipiao",@"img_btn_wuliu",@"img_btn_lingquan",@"img_btn_chongzhi",@"img_btn_zhuanti",@"img_btn_shiping"];
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
        _scrollView.pagingEnabled = YES;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.delegate = self;

    }
    return _scrollView;
}
- (void)setUpUI
{
    for (UIView *view in self.scrollView.subviews) {
        [view removeFromSuperview];
    }
    [self addSubview:self.scrollView];

    CGFloat width = 40;
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

                UIImageView *iamgeV = [[UIImageView alloc]initWithFrame:CGRectMake(page * kMSScreenWith + kMSScreenWith/8-20+y*kMSScreenWith/_columnNumber, 5+ (x * self.height/2), width, width)];
                iamgeV.image = [UIImage imageNamed:_defaultImgArr[countNumber]];

                [self.scrollView addSubview:iamgeV];


                UILabel *titleLabel = LabelInit(page * kMSScreenWith + y*kMSScreenWith/_columnNumber, width+10+ (x * self.height/2), kMSScreenWith/_columnNumber, 20);
                titleLabel.font = PFR13Font;
                titleLabel.text = [NSString stringWithFormat: @"标题%ld",countNumber];
                titleLabel.textColor = [RegularExpressionsMethod ColorWithHexString:@"747474"];
                titleLabel.textAlignment = NSTextAlignmentCenter;
                [self.scrollView addSubview:titleLabel];

                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                btn.frame = CGRectMake(page * kMSScreenWith + y*kMSScreenWith/_columnNumber,  self.height/2, kMSScreenWith/_columnNumber, self.height/2);
                btn.tag = countNumber+1000;
                btn.backgroundColor = [UIColor clearColor];
                [btn addTarget:self action:@selector(toJump:) forControlEvents:UIControlEventTouchUpInside];
                [self.scrollView addSubview:btn];

                    countNumber ++;

                }

            }
        }
}

- (void)toJump:(UIButton *)sender
{

}

@end
