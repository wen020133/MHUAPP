//
//  WJLogisticsTableHeadView.m
//  MHUAPP
//
//  Created by jinri on 2018/5/8.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import "WJLogisticsTableHeadView.h"

@interface WJLogisticsTableHeadView ()

@property (nonatomic,strong) UIImageView *goodsPic;
@property (nonatomic,strong) UILabel *type;
@property (strong, nonatomic) UILabel *numLabel;
@property (strong, nonatomic) UILabel *comLabel;
@property (nonatomic,strong) UIWebView *phoneCallWebView;

@end

#define GRAY_TITLECOLOR 0x9D9D9D
@implementation WJLogisticsTableHeadView
-(instancetype)initWithFrame:(CGRect)frame{

    self=[super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}


- (void)setNumber:(NSString *)number {
    _number = number;
    self.numLabel.text = [NSString stringWithFormat:@"物流编号：%@",number];
}

- (void)setCompany:(NSString *)company {
    _company = company;
    self.comLabel.text = [NSString stringWithFormat:@"物流公司：%@",company];
}
- (void)setWltype:(NSString *)wltype {
    _wltype = wltype;

    NSMutableAttributedString *wlStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"物流状态：%@",wltype]];
    NSRange range = [[NSString stringWithFormat:@"物流状态：%@",wltype] rangeOfString: wltype];
    [wlStr addAttribute:NSForegroundColorAttributeName value:BASEGreenColor range:range];
    self.type.attributedText = wlStr;
}
- (void)setImageUrl:(NSString *)imageUrl {
    _imageUrl = imageUrl;
    self.goodsPic.image = [UIImage imageNamed:imageUrl];

}
- (void)setupUI {
    self.backgroundColor=[UIColor whiteColor];

    self.goodsPic = [[UIImageView alloc]init];
    self.goodsPic.frame=CGRectMake(15, 15, 85,85);
    self.goodsPic.image = [UIImage imageNamed:@"logistics_EMS.png"];
    [self addSubview:self.goodsPic];

    self.type =[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.goodsPic.frame)+14,12, 20*10, 2*10)];
    self.type.font = [UIFont systemFontOfSize:14];
    [self addSubview:self.type];


    self.numLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.type.frame.origin.x ,CGRectGetMaxY(self.type.frame)+5, 20*10, 2*10)];
    self.numLabel.font = [UIFont systemFontOfSize:12];
    self.numLabel.textColor = [RegularExpressionsMethod ColorWithHexString:BASELITTLEBLACKCOLOR];
    self.numLabel.text = @"物流编号:";
    [self addSubview:self.numLabel];


    self.comLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.numLabel.frame.origin.x ,CGRectGetMaxY(self.numLabel.frame)+5, 20*10, 2*10)];
    self.comLabel.font = [UIFont systemFontOfSize:12];
    self.comLabel.textColor = [RegularExpressionsMethod ColorWithHexString:BASELITTLEBLACKCOLOR];
    self.comLabel.text = @"物流公司:";
    [self addSubview:self.comLabel];
    
     [RegularExpressionsMethod dc_setUpAcrossPartingLineWith:self WithColor:[[UIColor lightGrayColor]colorWithAlphaComponent:0.3]];

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
