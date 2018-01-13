//
//  WJOrderFooter.h
//  MHUAPP
//
//  Created by jinri on 2017/12/21.
//  Copyright © 2017年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WJOrderListFootModel.h"


@interface WJOrderFooter : UITableViewHeaderFooterView

@property (nonatomic, strong) UILabel *totalPayPrice;

@property (strong , nonatomic) WJOrderListFootModel *footModel;

@end