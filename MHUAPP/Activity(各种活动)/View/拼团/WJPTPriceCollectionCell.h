//
//  WJPTPriceCollectionCell.h
//  MHUAPP
//
//  Created by jinri on 2018/5/22.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WJPTPriceCollectionCell : UICollectionViewCell

@property (assign , nonatomic)NSString *start_num;
@property (assign , nonatomic)NSString *group_numb_one;
@property (assign , nonatomic)NSString *group_numb_two;
@property (assign , nonatomic)NSString *group_numb_three;
@property (assign , nonatomic)NSString *group_price_one;
@property (assign , nonatomic)NSString *group_price_two;
@property (assign , nonatomic)NSString *group_price_three;


- (void)reloadDataAllLabel;
@end
