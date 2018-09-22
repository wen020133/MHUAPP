//
//  WJHongBaoStoreView.m
//  MHUAPP
//
//  Created by wenchengjun on 2018/9/18.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import "WJHongBaoStoreView.h"
#import "UIView+UIViewFrame.h"


@implementation WJHongBaoStoreView

- (instancetype)initWithFrame:(CGRect)frame withBouns:(NSArray *)arr withUserStore:(NSString *)userStore withServerStore:(NSString *)serverStore withViewHeight:(float)viewHeight
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        _arr_hongbao = arr;
        _num_check = 0;
        _num = [serverStore integerValue];
        _user_storeNum = [userStore integerValue];
        if (viewHeight==0) {
            return self;
        }
        else
            [self setUpUI:viewHeight];
    }
    return self;
}

- (void)setUpUI:(float)viewHeight
{
    
    UIImageView *imageBV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kMSScreenWith, viewHeight)];
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
    if (viewHeight==200) {
        [self addSubview:lab_hongbaoT];
    }
    
    
    _lab_hbName = LabelInit(kMSScreenWith-160, 50, 120, 30);
    _lab_hbName.font = PFR14Font;
    _lab_hbName.textColor = [RegularExpressionsMethod ColorWithHexString:BASEPINK];
    _lab_hbName.textAlignment = NSTextAlignmentRight;
    if (viewHeight==200) {
        [self addSubview:_lab_hbName];
    }
    
    
    UIImageView *actionImageView = ImageViewInit(kMSScreenWith-35, 63, 9, 5);
    actionImageView.image = [UIImage imageNamed:@"price_no_down"];
    if (viewHeight==200) {
         [self addSubview:actionImageView];
    }
   
    
    UIButton *buttonHB = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonHB.backgroundColor = [UIColor clearColor];
    buttonHB.frame = CGRectMake(kMSScreenWith-200, 45, 190, 40);
    [buttonHB addTarget:self action:@selector(chickHongBao) forControlEvents:UIControlEventTouchUpInside];
    if (viewHeight==200)
    [self addSubview:buttonHB];
    
    UIImageView *line2 = ImageViewInit(0, 94, kMSScreenWith, 1);
    line2.backgroundColor = [RegularExpressionsMethod ColorWithHexString:@"E6E6E6"];
    if (viewHeight==200)
    [self addSubview:line2];
    
    float jifenY=40.0f;
    if (viewHeight==200) {
        jifenY = 95;
    }
    UILabel *lab_jifenT = LabelInit(DCMargin, jifenY+20, 40, 25);
    lab_jifenT.text = @"积分";
    lab_jifenT.font = Font(16);
    lab_jifenT.textColor = [RegularExpressionsMethod ColorWithHexString:BASEBLACKCOLOR];
    [self addSubview:lab_jifenT];
    
    
    _lab_maxStore = LabelInit(lab_jifenT.Right, jifenY+25, 150, 20);
    _lab_maxStore.font = PFR12Font;
    _lab_maxStore.text = [NSString stringWithFormat:@"(最高可使用%ld积分抵扣)",_num];
    _lab_maxStore.textColor = [RegularExpressionsMethod ColorWithHexString:BASELITTLEBLACKCOLOR];
    [self addSubview:_lab_maxStore];
    
    PPNumberButton *numberButton = [PPNumberButton numberButtonWithFrame:CGRectMake(kMSScreenWith-160, jifenY+15, 150, 35)];
    numberButton.shakeAnimation = NO;
    numberButton.minValue = 0;
    if(_user_storeNum>=_num)
    numberButton.maxValue =_num;
    else
    {
        numberButton.maxValue =_user_storeNum;
    }
    _num_check = 0;
    numberButton.inputFieldFont = 20;
    numberButton.increaseTitle = @"＋";
    numberButton.decreaseTitle = @"－";
    numberButton.currentNumber = 0;
    numberButton.delegate = self;
    
    numberButton.resultBlock = ^(NSInteger num ,BOOL increaseStatus){
        _num_check = num;
        [self changeOrderPrice];
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
    
    UILabel *lab_jifenMiaoshu = LabelInit(DCMargin, jifenY+50, 220, 40);
    lab_jifenMiaoshu.font = Font(11);
    lab_jifenMiaoshu.numberOfLines = 2;
    lab_jifenMiaoshu.text = @"100积分抵扣1元 \n订单使用积分不能超过商家设定抵扣总积分";
    lab_jifenMiaoshu.textColor = [RegularExpressionsMethod ColorWithHexString:BASELITTLEBLACKCOLOR];
    [self addSubview:lab_jifenMiaoshu];
    
    
    _lab_userStore = LabelInit(kMSScreenWith-160, jifenY+60, 150, 30);
    _lab_userStore.font = PFR14Font;
    _lab_userStore.textColor = [RegularExpressionsMethod ColorWithHexString:BASEBLACKCOLOR];
    _lab_userStore.text =[NSString stringWithFormat:@"您当前总积分%ld",_user_storeNum];
    _lab_userStore.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_lab_userStore];
}


-(void)chickHongBao
{
    NSLog(@"选择红包！！！");
    [_pickerView removeFromSuperview];
    NSLog(@"---%@",self.arr_hongbao );
    _pickerView = [[MyPickerView alloc]initWithFrame:CGRectMake(0, kMSNaviHight, kMSScreenWith, kMSScreenHeight-44)];
    _pickerView.delegate = self;
    NSMutableArray *arr = [NSMutableArray array];
    for (int kkk=0; kkk<self.arr_hongbao.count; kkk++) {
        [arr addObject:[NSString stringWithFormat:@"%@", [[self.arr_hongbao objectAtIndex:kkk] objectForKey:@"type_name"]]];
    }

    _pickerView.arrays = arr;
    [self.window addSubview:_pickerView];
 
}
- (void)selectPickerViewRow:(NSInteger)row andName:(NSString *)str
{
    self.lab_hbName.text = [[self.arr_hongbao objectAtIndex:row] objectForKey:@"type_name"];
    [self checkBonusId:row];
    
}
-(void)checkBonusId:(NSInteger )bonusId
{
    !_bonusIdClickBlock ? : _bonusIdClickBlock(bonusId);
}
-(void)changeOrderPrice
{
    !_jifenStoreClickBlock ? : _jifenStoreClickBlock(_num_check);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
