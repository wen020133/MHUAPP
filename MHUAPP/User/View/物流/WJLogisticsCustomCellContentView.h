//
//  WJLogisticsCustomCellContentView.h
//  MHUAPP
//
//  Created by jinri on 2018/5/8.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WJLogisticsModel;

@interface WJLogisticsCustomCellContentView : UIView

@property (assign, nonatomic) BOOL hasUpLine;
@property (assign, nonatomic) BOOL hasDownLine;
@property (assign, nonatomic) BOOL currented;

- (void)reloadDataWithModel:(WJLogisticsModel *)model;

@end
