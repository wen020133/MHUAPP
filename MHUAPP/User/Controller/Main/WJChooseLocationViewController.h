//
//  WJChooseLocationViewController.h
//  MHUAPP
//
//  Created by jinri on 2018/1/30.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseNetworkViewController.h"

@interface WJChooseLocationViewController : BaseNetworkViewController

@property (nonatomic, copy) NSString * address;

@property (nonatomic, copy) dispatch_block_t chooseFinish;;

@property (nonatomic,copy) NSString * str_fatherID;

// 记录当前省市区
@property(nonatomic,copy) NSString *currentProvince;
@property(nonatomic,copy) NSString *currentCity;
@property(nonatomic,copy) NSString *currentArea;
@property(nonatomic,copy) NSString *currentProvinceID;
@property(nonatomic,copy) NSString *currentCityID;
@property(nonatomic,copy) NSString *currentAreaID;

// 记录当前行
@property(nonatomic,assign) NSInteger provinceIndex;
@property(nonatomic,assign) NSInteger cityIndex;

@property NSInteger regType;
@end
