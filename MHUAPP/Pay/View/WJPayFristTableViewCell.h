//
//  WJPayFristTableViewCell.h
//  MHUAPP
//
//  Created by jinri on 2018/5/7.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WJPayFristTableViewCell : UITableViewCell

@property (strong, nonatomic)  UILabel *lab_price;

/** 关闭 */
@property (nonatomic, copy) dispatch_block_t colsePayView;
@end
