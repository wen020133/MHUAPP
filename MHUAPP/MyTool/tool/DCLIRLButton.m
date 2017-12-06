//
//  DCLIRLButton.m
//  CDDMall
//
//  Created by apple on 2017/6/27.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "DCLIRLButton.h"
#import "UIView+UIViewFrame.h"

@interface DCLIRLButton ()



@end

@implementation DCLIRLButton

#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.titleLabel sizeToFit];
    self.titleLabel.dc_centerX = self.width * 0.55;
    self.imageView.x = self.titleLabel.x - self.imageView.width - 5;
}

#pragma mark - Setter Getter Methods

@end
