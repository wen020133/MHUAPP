//
//  WJFlowAttributeCell.m
//  MHUAPP
//
//  Created by wenchengjun on 2017/12/5.
//  Copyright © 2017年 wenchengjun. All rights reserved.
//

#import "WJFlowAttributeCell.h"
#import "UIView+UIViewFrame.h"


@implementation WJFlowAttributeCell

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
    _flowImageView = [[UIImageView alloc] init];
    _flowImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    _flowTextLabel = [[UILabel alloc] init];
    _flowTextLabel.font = PFR13Font;
    _flowTextLabel.textAlignment = NSTextAlignmentCenter;
}

#pragma mark - 布局
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    
        [self addSubview:_flowImageView];
        [self addSubview:_flowTextLabel];
        
        [self setUpTypeWithTopImageVewBottonLabel];
}

#pragma mark - typeOne
- (void)setUpTypeWithTopImageVewBottonLabel
{
    
    [_flowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        [make.top.mas_equalTo(self)setOffset:13];
        make.size.mas_equalTo(CGSizeMake(self.width*0.27, self.width*0.27));
        
    }];
    [_flowTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.top.mas_equalTo(_flowImageView.mas_bottom)setOffset:13];
        make.centerX.mas_equalTo(self);
    }];
}

#pragma mark - Setter Getter Methods
- (void)setFlowItem:(WJFlowItem *)flowItem
{
    _flowItem = flowItem;
    
    _flowImageView.image = [UIImage imageNamed:flowItem.flowImageView];
    _flowTextLabel.text = flowItem.flow_title;
}
@end
