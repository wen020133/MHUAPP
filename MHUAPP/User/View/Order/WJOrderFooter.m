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
        self.contentView.backgroundColor = self.backgroundColor= kMSCellBackColor;
        [self setUpInitV];
    }
    return self;
}
-(void)setUpInitV
{

    _totalPayPrice = [[UILabel alloc] initWithFrame:CGRectMake(50, 5, kMSScreenWith-60, 20)];
    _totalPayPrice.textColor = [RegularExpressionsMethod ColorWithHexString:BASEBLACKCOLOR];
    _totalPayPrice.font = Font(15);
    _totalPayPrice.textAlignment = NSTextAlignmentRight;
    
    [self.contentView addSubview:_totalPayPrice];

    UIImageView *imgLine = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kMSScreenWith, 1)];
    imgLine.backgroundColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.4];
    [self.contentView addSubview:imgLine];

}


-(void)setOrderType:(NSInteger)orderType
{
    for(UIView *mylabelview in [self.contentView subviews]) {
        if ([mylabelview isKindOfClass:[UIButton class]]) {
             [mylabelview removeFromSuperview];
        }
    }

    NSMutableArray *arr_buttonTitle = [NSMutableArray array];
    switch (orderType) {
        case 0:   //待付款
        {
            arr_buttonTitle = [NSMutableArray arrayWithObjects:@"立即支付",@"取消订单", nil];
        }
            break;
        case 1:  //待发货
        {
            arr_buttonTitle = [NSMutableArray arrayWithObjects:@"我要催单", @"我要退款",nil];
        }
            break;
        case 2:  //待收货
        {
            arr_buttonTitle = [NSMutableArray arrayWithObjects:@"确认收货", @"查看物流",@"我要退款",nil];
        }
            break;
        case 3:   //已完成
        {
            arr_buttonTitle = [NSMutableArray arrayWithObjects:@"立即评价",@"再次购买",@"我要退款", nil];
        }
            break;
        case 7:  //已评价
        {
//            arr_buttonTitle = [NSMutableArray arrayWithObjects:@"再次购买", @"删除订单",nil];
            arr_buttonTitle = [NSMutableArray arrayWithObjects:@"再次购买",nil];
        }
            break;
        case 6:  //待评价
        {
            arr_buttonTitle = [NSMutableArray arrayWithObjects:@"去评价",@"我要退款",nil];
        }
            break;
        case 5:  //交易关闭
        {
            arr_buttonTitle = [NSMutableArray arrayWithObjects:@"已取消", nil];
        }
            break;
        case 8:  //退款
        {
            arr_buttonTitle = [NSMutableArray arrayWithObjects:@"查看详情",nil];
        }
            break;
        default:
            break;
    }
    for (int aa=0; aa<arr_buttonTitle.count; aa++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.layer.borderColor = [[RegularExpressionsMethod ColorWithHexString:BASEBLACKCOLOR] CGColor];
        btn.layer.borderWidth = 1.0f;
        btn.layer.cornerRadius = 3;
        btn.layer.masksToBounds = YES;//设置圆角
        btn.frame = CGRectMake(kMSScreenWith-(70+10)*(aa+1), 29, 70, 28);
        [btn setTitle:[arr_buttonTitle objectAtIndex:aa] forState:UIControlStateNormal];
        btn.titleLabel.font = Font(14);
        [btn setTitleColor:[RegularExpressionsMethod ColorWithHexString:BASEBLACKCOLOR] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(aeleteGoodsInCart:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:btn];
    }
}
-(void)aeleteGoodsInCart:(UIButton *)sender
{
     !_ClickStateForStrBlock ? : _ClickStateForStrBlock(sender.titleLabel.text);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
