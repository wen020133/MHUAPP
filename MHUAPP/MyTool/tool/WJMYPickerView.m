//
//  WJMYPickerView.m
//  MHUAPP
//
//  Created by jinri on 2017/12/12.
//  Copyright © 2017年 wenchengjun. All rights reserved.
//

#import "WJMYPickerView.h"

@implementation WJMYPickerView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self allProvinces];// 初始化所有省数据
        [self currentCityArray]; //初始化当前市数据
        [self currentAreaArray];// 初始化当前区数组
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
    _picker.backgroundColor = kMSCellBackColor;
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



}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {

    switch (component) {
        case 0:
            return self.allProvinces.count;
            break;
        case 1:
            return self.currentCityArray.count;
            break;
        case 2:
            return self.currentAreaArray.count;
            break;
        default:
            break;
    }
    return 0;
}


- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {

    switch (component) {
        case 0:
            return [self.allProvinces[row] objectForKey:@"province_name"];
            break;
        case 1:
            return [self.currentCityArray[row] objectForKey:@"city_name"];
            break;
        case 2:
            return [self.currentAreaArray[row] objectForKey:@"district_name"];
            break;
        default:
            break;
    }
    return nil;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{

    if (component == 0) {
        // 重置当前城市数组
        self.provinceIndex = row;
        [self resetCityArray];
        // 刷新城市列表,并滚动至第一行
        [self scrollToTopRowAtComponent:1];
        // 记录当前城市
        _currentCity = [_currentCityArray[0]objectForKey:@"city_name"];
        // 根据当前城市重置区数组
        self.cityIndex = 0;
        [self resetAreaArray];
        // 刷新区列表,并滚动至第一行
        [self scrollToTopRowAtComponent:2];
        // 记录当前
        _currentProvince = [_allProvinces[row] objectForKey:@"province_name"];
        // 记录当前区
        if (_currentAreaArray.count) {
            _currentArea = [_currentAreaArray[0]objectForKey:@"district_name"];
        }
        else{
            _currentArea = @"";
        }
    }
    else if(component == 1){
        // 记录当前城市
        _currentCity = [_currentCityArray[row] objectForKey:@"city_name"];
        // 根据当前城市重置区数组
        self.cityIndex = row;
        [self resetAreaArray];
        // 刷新区列表,并滚动至第一行
        [self scrollToTopRowAtComponent:2];
        if (_currentAreaArray.count) {
            _currentArea = [_currentAreaArray[0]objectForKey:@"district_name"];
        }
        else{
            _currentArea = @"";
        }
    }
    else{
        // 重置当前区
        if (_currentAreaArray.count) {
            _currentArea = _currentAreaArray[row];
        }
        else{
            _currentArea = @"";
        }
    }
}

- (void)pickerCancel {
    [self hide];
}

- (void)pickerDone {
    [self hide];
    [self.delegate selectPickerViewRow:self.currentProvince provinceID:self.currentProvinceID city:self.currentCity cityID:self.currentCityID area:self.currentArea areaID:self.currentAreaID];
}

/** 获取当前省 的市数组 */
-(void)resetCityArray{
    [self.currentCityArray removeAllObjects];
    // 当前省信息字典
    NSDictionary *currentPorvinceDict = self.allProvinces[_provinceIndex];
    // 当前省编码
    // 根据省编码 获取 市信息数组
    self.currentCityArray = [currentPorvinceDict objectForKey:@"city"];
}

/** 根据当前城市编号 获取区数组 */
-(void)resetAreaArray{
    [self.currentAreaArray removeAllObjects];
    NSDictionary *currentDistrict = self.currentCityArray[_cityIndex];
    // 重置区数组
    self.currentAreaArray = [currentDistrict objectForKey:@"district"];
}

/** 刷新区列表,并滚动至第一行 */
-(void)scrollToTopRowAtComponent:(NSInteger)component{
    [self.picker reloadComponent:component];
    [self.picker selectRow:0 inComponent:component animated:YES];
}

#pragma mark - lazy
/** 所有省字典数据 */
-(NSArray *)allProvinces{
    if (!_allProvinces) {
        NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
        NSString *fileName = [path stringByAppendingPathComponent:@ "address.plist" ];
        NSArray *result = [NSArray arrayWithContentsOfFile:fileName];
        _allProvinces = result;

    }
    _currentProvince = [_allProvinces[0] objectForKey:@"province_name"];// 初始化当前省
    _currentProvinceID = [_allProvinces[0] objectForKey:@"province_id"];// 初始化当前省

    return _allProvinces;
}

/** 市名称 数组 */
-(NSMutableArray*)currentCityArray{
    if (!_currentCityArray) {
        _currentCityArray = [[NSMutableArray alloc] init];
        // 重置城市数组
        [self resetCityArray];
        _currentCity = [_currentCityArray[0]objectForKey:@"city_name"];
        _currentCityID = [_currentCityArray[0]objectForKey:@"city_id"];
    }
    return _currentCityArray;
}

/** 区名称 数组 */
-(NSMutableArray*)currentAreaArray{
    if (!_currentAreaArray) {
        _currentAreaArray = [[NSMutableArray alloc] init];
        // 重置区数组
        [self resetAreaArray];
        _currentArea = [_currentAreaArray[0] objectForKey:@"district_name"];
        _currentAreaID = [_currentAreaArray[0] objectForKey:@"district_id"];
    }
    return _currentAreaArray;
}
- (void)callControl:(id)sender {
    [self hide];
}

- (void)hide {
    [UIView animateWithDuration:0.3 animations:^{
        self.frame = CGRectMake(0, self.frame.size.height, self.frame.size.width, self.frame.size.height);
    }];
}
@end
