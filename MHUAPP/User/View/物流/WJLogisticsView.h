//
//  WJLogisticsView.h
//  MHUAPP
//
//  Created by jinri on 2018/5/8.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WJLogisticsTableHeadView.h"

@interface WJLogisticsView : UIView

/**
 运单号码
 */
@property (copy, nonatomic)NSString *number;

/**
 承运公司
 */
@property (copy, nonatomic)NSString *company;

/**
 物流状态
 */
@property (nonatomic,copy) NSString * wltype;

/**
 图片url
 */
@property (nonatomic,copy) NSString * imageUrl;
@property (strong, nonatomic)NSArray *datas;
@property (nonatomic,strong) WJLogisticsTableHeadView *headerView;
- (instancetype)initWithDatas:(NSArray*)array;
- (void)reloadDataWithDatas:(NSArray *)array;

@end
