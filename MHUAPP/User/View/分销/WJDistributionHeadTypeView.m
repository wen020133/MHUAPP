//
//  WJDistributionHeadTypeView.m
//  MHUAPP
//
//  Created by wenchengjun on 2018/7/27.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import "WJDistributionHeadTypeView.h"
#import "UIView+UIViewFrame.h"

@implementation WJDistributionHeadTypeView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [RegularExpressionsMethod ColorWithHexString:kMSVCBackgroundColor];        _defaultImgArr = @[@"user_kefenxiaoChanpin",@"user_myFenxiao",@"user_zijinManager"];
        _defaultTitleArr = @[@"可分销产品",@"我的分销",@"资金管理"];
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
   
    _img_content  = ImageViewInit(0, 0, kMSScreenWith, 120);
    _img_content.image = [UIImage imageNamed:@"user_Distribution"];
    [self addSubview:_img_content];
    
    CGFloat width = 44;
    
    UIImageView *backV = ImageViewInit(0, 120, kMSScreenWith, 80);
    backV.backgroundColor = kMSCellBackColor;
    [self addSubview:backV];
    
    
    for (int page = 0; page < _defaultImgArr.count; page ++) {
        
        UIImageView *iamgeV = [[UIImageView alloc]initWithFrame:CGRectMake(kMSScreenWith/6-width/2+page*kMSScreenWith/3, 125, width, width)];
        iamgeV.contentMode = UIViewContentModeScaleAspectFit;
        iamgeV.image = [UIImage imageNamed:_defaultImgArr[page]];
        
        [self addSubview:iamgeV];
        
        
        UILabel *titleLabel = LabelInit(page*kMSScreenWith/3, width+130, kMSScreenWith/3, 20);
        titleLabel.font = Font(15);
        titleLabel.text = _defaultTitleArr[page];
        
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.tag = 10000+page;
        [self addSubview:titleLabel];
        if (page == 0)
        {
            titleLabel.textColor = [RegularExpressionsMethod ColorWithHexString:BASEPINK];
        }
        else
        {
           titleLabel.textColor = [RegularExpressionsMethod ColorWithHexString:BASELITTLEBLACKCOLOR];
        }
        
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(page*kMSScreenWith/3,  120, kMSScreenWith/3, self.height);
        btn.tag = page+1000;
        btn.backgroundColor = [UIColor clearColor];
        [btn addTarget:self action:@selector(toJumpClassView:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
    }
}


- (void)toJumpClassView:(UIButton *)sender
{
    switch (sender.tag) {
        case 1000:
            {
                UILabel *labV = [self viewWithTag:10000];
                labV.textColor = [RegularExpressionsMethod ColorWithHexString:BASEPINK];
                UILabel *labV1 = [self viewWithTag:10001];
                labV1.textColor = [RegularExpressionsMethod ColorWithHexString:BASELITTLEBLACKCOLOR];
                UILabel *labV2 = [self viewWithTag:10002];
                labV2.textColor = [RegularExpressionsMethod ColorWithHexString:BASELITTLEBLACKCOLOR];
            }
            break;
            case 1001:
        {
            UILabel *labV = [self viewWithTag:10000];
            labV.textColor = [RegularExpressionsMethod ColorWithHexString:BASELITTLEBLACKCOLOR];
            UILabel *labV1 = [self viewWithTag:10001];
            labV1.textColor = [RegularExpressionsMethod ColorWithHexString:BASEPINK];
            UILabel *labV2 = [self viewWithTag:10002];
            labV2.textColor = [RegularExpressionsMethod ColorWithHexString:BASELITTLEBLACKCOLOR];
        }
            break;
            case 1002:
        {
            UILabel *labV = [self viewWithTag:10000];
            labV.textColor = [RegularExpressionsMethod ColorWithHexString:BASELITTLEBLACKCOLOR];
            UILabel *labV1 = [self viewWithTag:10001];
            labV1.textColor = [RegularExpressionsMethod ColorWithHexString:BASELITTLEBLACKCOLOR];
            UILabel *labV2 = [self viewWithTag:10002];
            labV2.textColor = [RegularExpressionsMethod ColorWithHexString:BASEPINK];
        }
            break;
        default:
            break;
    }
    !_goToSelectClassTypeAction ? : _goToSelectClassTypeAction(sender.tag-1000);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
