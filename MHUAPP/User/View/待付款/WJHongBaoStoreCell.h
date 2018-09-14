//
//  WJHongBaoStoreCell.h
//  MHUAPP
//
//  Created by wenchengjun on 2018/9/7.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPNumberButton.h"

@interface WJHongBaoStoreCell : UITableViewCell<PPNumberButtonDelegate>

@property (strong, nonatomic)  NSArray *arr_hongbao;
@property (strong, nonatomic)  UILabel *lab_amount;
@property (strong, nonatomic)  UILabel *lab_hbName;
@property (strong, nonatomic)  UILabel *lab_userStore;
@property (strong, nonatomic)  UILabel *lab_maxStore;
@property NSInteger num;
@property NSInteger user_storeNum;
@end
