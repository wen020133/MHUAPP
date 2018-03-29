//
//  WJSSPTTypeHeadView.m
//  MHUAPP
//
//  Created by jinri on 2018/3/28.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import "WJSSPTTypeHeadView.h"

@implementation WJSSPTTypeHeadView

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

    _img_content  = ImageViewInit(0, 0, kMSScreenWith, 120);
    _img_content.image = [UIImage imageNamed:@"main_sspt_haowuyiqipin.jpg"];
    [self addSubview:_img_content];

}
@end
