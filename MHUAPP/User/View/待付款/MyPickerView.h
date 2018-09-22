//
//  MyPickerView.h
//  YouXun
//
//  Created by xuym on 12-10-24.
//
//


// the custom UIPickerView



#import <UIKit/UIKit.h>

@protocol SelectPickerViewDelegate <NSObject>

- (void)selectPickerViewRow:(NSInteger)row andName:(NSString *)str;

@end

@interface MyPickerView : UIView <UIPickerViewDataSource,UIPickerViewDelegate>

@property (nonatomic, retain) UIPickerView *picker;
@property (nonatomic, retain) NSArray *arrays;
@property (nonatomic, retain) UIControl *control;

@property (nonatomic, assign) id<SelectPickerViewDelegate>delegate;
@property (nonatomic, assign) NSInteger currRow;

- (void)hideAnimate;

@end
