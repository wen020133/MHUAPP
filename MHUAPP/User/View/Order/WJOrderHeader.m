//
//  WJOrderHeader.m
//  MHUAPP
//
//  Created by jinri on 2017/12/21.
//  Copyright © 2017年 wenchengjun. All rights reserved.
//

#import "WJOrderHeader.h"
// Vendors
#import <UIImageView+WebCache.h>

@implementation WJOrderHeader

-(id)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self setUpInitV];
    }
    return self;
}
-(void)setUpInitV
{
    _shangjiaIcon = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 20, 20)];
       [self.contentView addSubview:_shangjiaIcon];

    _shangjiaName = [[UILabel alloc] init];
    _shangjiaName.textColor = kMSNavBarBackColor;
    [self.contentView addSubview:_shangjiaName];

    _state = [[UILabel alloc] init];
    _state.textColor = [RegularExpressionsMethod ColorWithHexString:BASEPINK];
    [self.contentView addSubview:_state];
}

-(void)setNameModel:(WJOrderShangjiaNameModel *)nameModel
{
    _nameModel = nameModel;
    [_shangjiaIcon sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",kMSBaseUserHeadPortURL,nameModel.str_url]]];

    _shangjiaName.text = nameModel.name;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
