//
//  WJGoodBaseViewController.h
//  MHUAPP
//
//  Created by jinri on 2017/12/4.
//  Copyright © 2017年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WJMYPickerView.h"
#import "BaseNetworkViewController.h"

@interface WJGoodBaseViewController : BaseNetworkViewController<SelectPickerViewDelegate>

/** 更改标题 */
@property (nonatomic , copy) void(^changeTitleBlock)(BOOL isChange);

/* 商品标题 */
@property (strong , nonatomic)NSString *goodTitle;
/* 店铺价格 */
@property (strong , nonatomic)NSString *goodPrice;
/* 原价格 */
@property (strong , nonatomic)NSString *oldPrice;
/* 商品小标题 */
@property (strong , nonatomic)NSString *goodSubtitle;
/* 商品图片 */
@property (strong , nonatomic)NSString *goodImageView;

/* 商品轮播图 */
@property (strong , nonatomic)NSArray *shufflingArray;
/* 商品属性 */
@property (strong , nonatomic)NSArray *attributeArray;
/* 商品ID */
@property (strong , nonatomic) NSString *goods_id;
/* 店铺ID */
@property (strong , nonatomic) NSString *supplier_id;

@property (retain, nonatomic)  WJMYPickerView *pickerView;

@property (retain, nonatomic) NSString *str_provinceName;
@property (retain, nonatomic) NSString *str_provinceId;
@property (retain, nonatomic) NSString *str_cityName;
@property (retain, nonatomic) NSString *str_cityId;
@property (retain, nonatomic) NSString *str_address;
@property (retain, nonatomic) NSString *str_district;   //县（区）
@property (retain, nonatomic) NSString *str_districtId;

@end
