//
//  MyPickerView.m
//  YouXun
//
//  Created by xuym on 12-10-24.
//
//

#import "MyPickerView.h"

@implementation MyPickerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        //self.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.2];
        //self.backgroundColor = [UIColor brownColor];
        //self.alpha = 0.5;
        self.currRow = 0;
        self.arrays = nil;
        [self initView];
    }
    return self;
}


- (void)initView {
    _control = [[UIControl alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, kMSScreenHeight)];
    [_control addTarget:self action:@selector(callControl:) forControlEvents:UIControlEventTouchDown];
    [self addSubview:_control];
    
    _picker = [[UIPickerView alloc]initWithFrame:CGRectMake(0, self.frame.size.height-216, self.frame.size.width, 216)];
    _picker.delegate = self;
    _picker.dataSource = self;
    _picker.showsSelectionIndicator = YES;
    _picker.backgroundColor = [RegularExpressionsMethod ColorWithHexString:kMSVCBackgroundColor];
    [self addSubview:_picker];
    
    UIImageView *toolBar = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 236 - 24, self.frame.size.width, 44)];
       CGRect frame = toolBar.frame;
    toolBar.image = [UIImage imageNamed:@"ship_info_bg.png"];
    frame.size.height = 44.0f;
    toolBar.frame = frame;
    [self addSubview:toolBar];
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame = CGRectMake(20, self.frame.size.height - 236 - 22, 60, 40);
    [cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [cancelBtn addTarget:self action:@selector(pickerCancel) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:cancelBtn];
    
    UIButton *doneBtn =  [UIButton buttonWithType:UIButtonTypeCustom];
    doneBtn.frame = CGRectMake(kMSScreenWith-80, self.frame.size.height - 236 - 22, 60, 40);
    [doneBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [doneBtn setTitle:@"确认" forState:UIControlStateNormal];
    doneBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [doneBtn addTarget:self action:@selector(pickerDone) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:doneBtn];
    
    UILabel *titleLab = [[UILabel alloc] init];
    titleLab.textColor = kMSCellBackColor;
    titleLab.font = Font(15);
    titleLab.text = @"选择红包";
    titleLab.textAlignment = NSTextAlignmentCenter;
    [self addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(toolBar.mas_centerX);
        make.centerY.mas_equalTo(toolBar.mas_centerY);
    }];
}

- (void)pickerCancel {
    [self hideAnimate];
}

- (void)pickerDone {
    [self hideAnimate];
    [self.delegate selectPickerViewRow:self.currRow andName:[self.arrays objectAtIndex:self.currRow]];
}

- (void)show {
    self.currRow = 0;
    //修改数据为空时pickerview显示crash问题(网络数据啦取失败的场景)
    if (self.arrays) {
    [self.picker reloadAllComponents];
        [self.picker selectRow:self.currRow inComponent:0 animated:YES];
        [UIView animateWithDuration:0.3 animations:^{
            self.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        }];
    }
    //修改数据为空时pickerview显示crash问题(网络数据啦取失败的场景)
}

- (void)hideAnimate {
    [UIView animateWithDuration:0.3 animations:^{
        self.frame = CGRectMake(0, self.frame.size.height, self.frame.size.width, self.frame.size.height);
        [self removeFromSuperview];
    }];
}

- (void)callControl:(id)sender {
    [self hideAnimate];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [self.arrays count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [self.arrays objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.currRow = row;
}

@end
