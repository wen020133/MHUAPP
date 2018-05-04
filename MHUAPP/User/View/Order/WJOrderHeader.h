//
//  WJOrderHeader.h
//  MHUAPP
//
//  Created by jinri on 2017/12/21.
//  Copyright © 2017年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WJOrderHeader : UITableViewHeaderFooterView

@property (nonatomic, strong) UIImageView *shangjiaIcon;//商家logo

@property (nonatomic, strong) UILabel *shangjiaName;//商家名字

@property (nonatomic, strong) UILabel *state;

@property (copy,nonatomic) NSString *shangjiaTitle;
@end
