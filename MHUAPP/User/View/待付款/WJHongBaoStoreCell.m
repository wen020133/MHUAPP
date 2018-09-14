//
//  WJHongBaoStoreCell.m
//  MHUAPP
//
//  Created by wenchengjun on 2018/9/7.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import "WJHongBaoStoreCell.h"
#import "UIView+UIViewFrame.h"



@implementation WJHongBaoStoreCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
#pragma mark - Intial
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setUpUI];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setUpUI
{
    
    UIImageView *imageBV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kMSScreenWith, 200)];
    imageBV.backgroundColor =kMSCellBackColor;
    [self addSubview:imageBV];
    
    UILabel *subtract = LabelInit(DCMargin, 10, 20, 20);
    subtract.backgroundColor = [RegularExpressionsMethod ColorWithHexString:BASEPINK];
    subtract.text = @"减";
    subtract.textAlignment = NSTextAlignmentCenter;
    subtract.font = Font(14);
    subtract.textColor = [UIColor whiteColor];
    [self addSubview:subtract];
    
    UILabel *subtract_Describe = LabelInit(subtract.Right+DCMargin, 10, 100, 20);
    subtract_Describe.text = @"满减优惠";
    subtract_Describe.textColor = [RegularExpressionsMethod ColorWithHexString:BASELITTLEBLACKCOLOR];
    [self addSubview:subtract_Describe];
    
    _lab_amount = LabelInit(kMSScreenWith-128, 10, 120, 20);
    _lab_amount.font = PFR16Font;
    _lab_amount.textColor = [RegularExpressionsMethod ColorWithHexString:BASEPINK];
    [self addSubview:_lab_amount];
    
    UIImageView *line1 = ImageViewInit(0, 40, kMSScreenWith, 1);
    line1.backgroundColor = [RegularExpressionsMethod ColorWithHexString:@"E6E6E6"];
    [self addSubview:line1];
    
    UILabel *lab_hongbaoT = LabelInit(DCMargin, 50, 80, 30);
    lab_hongbaoT.text = @"红包";
    lab_hongbaoT.font = Font(16);
    lab_hongbaoT.textColor = [RegularExpressionsMethod ColorWithHexString:BASEBLACKCOLOR];
    [self addSubview:lab_hongbaoT];
    
    _lab_hbName = LabelInit(kMSScreenWith-160, 50, 120, 30);
    _lab_hbName.font = PFR14Font;
    _lab_hbName.textColor = [RegularExpressionsMethod ColorWithHexString:BASEPINK];
    _lab_hbName.textAlignment = NSTextAlignmentRight;
    [self addSubview:_lab_hbName];
    
    
    UIImageView *actionImageView = ImageViewInit(kMSScreenWith-35, 63, 9, 5);
    actionImageView.image = [UIImage imageNamed:@"price_no_down"];
    [self addSubview:actionImageView];
    
    UIButton *buttonHB = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonHB.backgroundColor = [UIColor clearColor];
    buttonHB.frame = CGRectMake(kMSScreenWith-200, 45, 190, 40);
    [buttonHB addTarget:self action:@selector(chickHongBao) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:buttonHB];
    
    UIImageView *line2 = ImageViewInit(0, 94, kMSScreenWith, 1);
    line2.backgroundColor = [RegularExpressionsMethod ColorWithHexString:@"E6E6E6"];
    [self addSubview:line2];
    
    UILabel *lab_jifenT = LabelInit(DCMargin, line2.Bottom+20, 40, 25);
    lab_jifenT.text = @"积分";
    lab_jifenT.font = Font(16);
    lab_jifenT.textColor = [RegularExpressionsMethod ColorWithHexString:BASEBLACKCOLOR];
    [self addSubview:lab_jifenT];
    
    
    _lab_maxStore = LabelInit(lab_jifenT.Right, line2.Bottom+25, 150, 20);
    _lab_maxStore.font = PFR12Font;
    _lab_maxStore.text = @"(最高可使用800积分抵扣)";
    _lab_maxStore.textColor = [RegularExpressionsMethod ColorWithHexString:BASELITTLEBLACKCOLOR];
    [self addSubview:_lab_maxStore];
    
    PPNumberButton *numberButton = [PPNumberButton numberButtonWithFrame:CGRectMake(kMSScreenWith-160, line2.Bottom+15, 150, 35)];
    numberButton.shakeAnimation = NO;
    numberButton.minValue = 0;
    numberButton.inputFieldFont = 20;
    numberButton.increaseTitle = @"＋";
    numberButton.decreaseTitle = @"－";
    numberButton.currentNumber = 0;
    numberButton.delegate = self;

    numberButton.resultBlock = ^(NSInteger num ,BOOL increaseStatus){
        if (num<=_user_storeNum) {
            _num = num;
        }
        else
        {
        }
    };
    [self addSubview:numberButton];
    
//    _jifenGuizeButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    _jifenGuizeButton.titleLabel.font = PFR14Font;
//    _jifenGuizeButton.titleLabel.textAlignment = NSTextAlignmentLeft;
//    _jifenGuizeButton.frame = CGRectMake(DCMargin, line2.Bottom+65, 110, 30);
//    [_jifenGuizeButton setImage:[UIImage imageNamed:@"user_jifenguize.png"] forState:UIControlStateNormal];
//    [_jifenGuizeButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
//    [_jifenGuizeButton setTitle:@"积分使用规则 "
//                       forState:UIControlStateNormal];
//    [_jifenGuizeButton setbuttonType:LZCategoryTypeLeft];
//    [self addSubview:_jifenGuizeButton];
    
    UILabel *lab_jifenMiaoshu = LabelInit(DCMargin, line2.Bottom+50, 220, 40);
    lab_jifenMiaoshu.font = Font(11);
    lab_jifenMiaoshu.numberOfLines = 2;
    lab_jifenMiaoshu.text = @"100积分抵扣1元 \n订单使用积分不能超过商家设定抵扣总积分";
    lab_jifenMiaoshu.textColor = [RegularExpressionsMethod ColorWithHexString:BASELITTLEBLACKCOLOR];
    [self addSubview:lab_jifenMiaoshu];
    
    
    _lab_userStore = LabelInit(kMSScreenWith-160, line2.Bottom+60, 150, 30);
    _lab_userStore.font = PFR14Font;
    _lab_userStore.textColor = [RegularExpressionsMethod ColorWithHexString:BASEBLACKCOLOR];
    _lab_userStore.text = @"您当前总积分100";
    _lab_userStore.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_lab_userStore];
}


-(void)chickHongBao
{
    NSLog(@"选择红包！！！");
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
