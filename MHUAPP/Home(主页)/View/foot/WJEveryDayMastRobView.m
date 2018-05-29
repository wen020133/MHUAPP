//
//  WJEveryDayMastRobView.m
//  MHUAPP
//
//  Created by wenchengjun on 2018/2/24.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import "WJEveryDayMastRobView.h"
#import "UIView+UIViewFrame.h"
#import <UIImageView+WebCache.h>


@interface WJEveryDayMastRobView ()

@property (strong , nonatomic) UIImageView *img_left;
@property (strong , nonatomic) UIImageView *img_right1;
@property (strong , nonatomic) UIImageView *img_right2;

@end


@implementation WJEveryDayMastRobView

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
    self.backgroundColor = kMSCellBackColor;
    
    UIImageView *line1 = ImageViewInit(0, kMSScreenWith/2, 1, 200);
    line1.backgroundColor = [RegularExpressionsMethod ColorWithHexString:@"E6E6E6"];
    [self addSubview:line1];

    _img_left = ImageViewInit(0, 0, kMSScreenWith/2, 200);
    _img_left.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_img_left];

    UIImageView *line2 = ImageViewInit(kMSScreenWith/2, 100, kMSScreenWith/2, 1);
    line2.backgroundColor = [RegularExpressionsMethod ColorWithHexString:@"E6E6E6"];
    [self addSubview:line2];

    _img_right1 = ImageViewInit(kMSScreenWith/2, 0, kMSScreenWith/2, 99);
    _img_right1.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_img_right1];

    _img_right2 = ImageViewInit(kMSScreenWith/2, 101, kMSScreenWith/2, 99);
    _img_right2.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_img_right2];
    
}

-(void)setImageArr:(NSArray<WJADThirdItem *> *)imageArr
{
    if (imageArr!=_imageArr) {
        _imageArr = imageArr;
    }
    [_img_left sd_setImageWithURL:[NSURL URLWithString:self.imageArr[0].ad_code] placeholderImage:[UIImage imageNamed:@"home_banner_img.png"]];
    [_img_right1 sd_setImageWithURL:[NSURL URLWithString:self.imageArr[1].ad_code] placeholderImage:[UIImage imageNamed:@"home_banner_img.png"]];
    [_img_right2 sd_setImageWithURL:[NSURL URLWithString:self.imageArr[2].ad_code] placeholderImage:[UIImage imageNamed:@"home_banner_img.png"]];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
