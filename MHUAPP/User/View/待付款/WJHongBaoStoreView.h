//
//  WJHongBaoStoreView.h
//  MHUAPP
//
//  Created by wenchengjun on 2018/9/18.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPNumberButton.h"
#import "MyPickerView.h"


@interface WJHongBaoStoreView : UIView<PPNumberButtonDelegate,SelectPickerViewDelegate>

@property (strong, nonatomic)  NSArray *arr_hongbao;
@property (strong, nonatomic)  UILabel *lab_amount;
@property (strong, nonatomic)  UILabel *lab_hbName;
@property (strong, nonatomic)  UILabel *lab_userStore;
@property (strong, nonatomic)  UILabel *lab_maxStore;
@property NSInteger num;
@property NSInteger user_storeNum;
@property NSInteger num_check;


- (instancetype)initWithFrame:(CGRect)frame withBouns:(NSArray *)arr withUserStore:(NSString *)userStore withServerStore:(NSString *)serverStore withViewHeight:(float)viewHeight;
@property (retain, nonatomic)  MyPickerView *pickerView;

/** 点击回调 */
@property (nonatomic , copy) void(^jifenStoreClickBlock)(double storeNum);

/** 点击回调 */
@property (nonatomic , copy) void(^bonusIdClickBlock)(NSInteger bonusId);
@end
