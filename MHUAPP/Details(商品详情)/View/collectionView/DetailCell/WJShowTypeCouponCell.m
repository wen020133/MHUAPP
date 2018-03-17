//
//  WJShowTypeCouponCell.m
//  MHUAPP
//
//  Created by jinri on 2017/12/4.
//  Copyright © 2017年 wenchengjun. All rights reserved.
//

#import "WJShowTypeCouponCell.h"
#import "UIView+UIViewFrame.h"


@implementation WJShowTypeCouponCell
#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {

    self = [super initWithFrame:frame];
    if (self) {

        self.arr_state = @[@"1",@"1",@"1",@"1"];
        self.arr_type = @[@"正品包邮",@"十五天退换",@"48小时发货",@"假一赔十"];
         [self setUpData];

    }
    return self;
}

- (void)setUpData
{
    float width = kMSScreenWith/4-20;
    for (int kk=0; kk<self.arr_type.count; kk++) {
        UIImageView *imageState =ImageViewInit(10+kMSScreenWith/4*kk, 10, 20, 20);
        [self addSubview:imageState];

        UILabel *label = LabelInit(imageState.Right+2+kMSScreenWith/4*kk, 10, width-30, 20);
        [self addSubview:label];

    }
}




@end
