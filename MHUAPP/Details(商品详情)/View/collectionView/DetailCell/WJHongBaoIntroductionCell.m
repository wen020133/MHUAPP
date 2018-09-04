//
//  WJHongBaoIntroductionCell.m
//  MHUAPP
//
//  Created by wenchengjun on 2018/8/31.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import "WJHongBaoIntroductionCell.h"
#import "UIView+UIViewFrame.h"

@interface WJHongBaoIntroductionCell ()

/* 红包内容 */
@property (strong , nonatomic) UIImageView *imageHongb;
/* 红包内容 */
@property (strong , nonatomic)UILabel *hongBaoLabel;

@end

@implementation WJHongBaoIntroductionCell


#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUpUI];
    }
    return self;
}

#pragma mark - UI
- (void)setUpUI
{
    self.backgroundColor = [UIColor clearColor];
    
   _imageHongb = [[UIImageView alloc]initWithFrame:CGRectMake(DCMargin, self.contentView.height/2-10, 20, 20)];
    _imageHongb.image = [UIImage imageNamed:@"hongBao_icon.png"];
    [self.contentView addSubview:_imageHongb];
    
    _hongBaoLabel = [[UILabel alloc] init];
    _hongBaoLabel.font = Font(12);
    _hongBaoLabel.textColor = [RegularExpressionsMethod ColorWithHexString:BASEPINK];
    [self.contentView addSubview:_hongBaoLabel];
    
}

-(void)setStr_bonus_tips:(NSString *)str_bonus_tips
{
    float height =  [RegularExpressionsMethod contentCellHeightWithText:str_bonus_tips font:Font(12) width:kMSScreenWith-56];
    _imageHongb.frame = CGRectMake(DCMargin, self.contentView.height/2-10, 20, 20);
    
    _hongBaoLabel.frame = CGRectMake(_imageHongb.Right+DCMargin, 2, kMSScreenWith-56, height+5);
    _hongBaoLabel.text = str_bonus_tips;
     _hongBaoLabel.numberOfLines = 0;
}

@end
