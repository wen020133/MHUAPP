//
//  WJMYPickerView.h
//  MHUAPP
//
//  Created by jinri on 2017/12/12.
//  Copyright © 2017年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SelectPickerViewDelegate <NSObject>

-(void)selectPickerViewRow:(NSString*)province provinceID:(NSString*)provinceID city:(NSString*)city cityID:(NSString*)cityID area:(NSString*)area areaID:(NSString*)areaID;
@end

@interface WJMYPickerView : UIView<UIPickerViewDataSource,UIPickerViewDelegate>

@property (nonatomic, retain) UIPickerView *picker;
@property (nonatomic, retain) UIControl *control;

@property (nonatomic, assign) id<SelectPickerViewDelegate>delegate;
// 数据源数组
@property(nonatomic,strong) NSArray *allProvinces;// 所有省信息
@property(nonatomic,strong)NSMutableArray *currentCityArray;// 当前省的 所有城市名称
@property(nonatomic,strong)NSMutableArray *currentAreaArray;// 当前市的 所有区名称
// 记录当前行
@property(nonatomic,assign) NSInteger provinceIndex;
@property(nonatomic,assign) NSInteger cityIndex;
// 记录当前省市区
@property(nonatomic,copy) NSString *currentProvince;
@property(nonatomic,copy) NSString *currentCity;
@property(nonatomic,copy) NSString *currentArea;
@property(nonatomic,copy) NSString *currentProvinceID;
@property(nonatomic,copy) NSString *currentCityID;
@property(nonatomic,copy) NSString *currentAreaID;


- (void)initView;
- (void)hide;

@end
