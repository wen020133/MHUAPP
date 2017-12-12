//
//  WJMYPickerView.h
//  MHUAPP
//
//  Created by jinri on 2017/12/12.
//  Copyright © 2017年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SelectPickerViewDelegate <NSObject>

- (void)selectPickerViewRow:(NSInteger)row andName:(NSString *)str;

@end

@interface WJMYPickerView : UIView<UIPickerViewDataSource,UIPickerViewDelegate>

@property (nonatomic, retain) UIPickerView *picker;
@property (nonatomic, retain) NSArray *arrays;
@property (nonatomic, retain) UIControl *control;

@property (nonatomic, assign) id<SelectPickerViewDelegate>delegate;
@property (nonatomic, assign) NSInteger currRow;

- (void)initView;
- (void)show;
- (void)hide;

@end
