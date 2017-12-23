//
//  WJOrderFooter.m
//  MHUAPP
//
//  Created by jinri on 2017/12/21.
//  Copyright © 2017年 wenchengjun. All rights reserved.
//

#import "WJOrderFooter.h"
#import "UIView+UIViewFrame.h"

@implementation WJOrderFooter

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
    _totalPayPrice = [[UILabel alloc] initWithFrame:CGRectMake(50, 5, self.contentView.width-60, 30)];
    _totalPayPrice.backgroundColor = [RegularExpressionsMethod ColorWithHexString:BASEBLACKCOLOR];
    _totalPayPrice.textAlignment = NSTextAlignmentRight;
    
    [self.contentView addSubview:_totalPayPrice];

    UIImageView *imgLine = [[UIImageView alloc]initWithFrame:CGRectMake(0, self.contentView.height, self.contentView.width, 1)];
    imgLine.backgroundColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.4];
    [self.contentView addSubview:imgLine];
}

-(void)setFootModel:(WJOrderListFootModel *)footModel
{
    if (footModel!=_footModel) {
        _footModel = footModel;
    }

    _totalPayPrice.text = [NSString stringWithFormat:@"共%@件商品 合计：￥%@（含运费￥%@）",_footModel.OrderNum,_footModel.totalPrice,_footModel.freight];

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
