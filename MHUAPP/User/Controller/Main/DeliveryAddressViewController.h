//
//  DeliveryAddressViewController.h
//  TOAFRICA
//
//  Created by wenchengjun on 15-1-4.
//
// 添加或者修改收货地址

#import <UIKit/UIKit.h>
#import "BaseNetworkViewController.h"


@interface DeliveryAddressViewController : BaseNetworkViewController<UITextFieldDelegate,UIAlertViewDelegate,UITextViewDelegate>
@property (retain, nonatomic) UITextField *texf_ContactName;
@property (retain, nonatomic) UITextField *texf_mobile;
//@property (retain, nonatomic) UITextField *text_postalCode;
@property (retain, nonatomic) UILabel *lab_province;

@property (retain, nonatomic) UITextView *texV_address;
//@property (retain, nonatomic) NSString *countryID;
//@property (retain, nonatomic) NSString *countryCode;
@property (retain, nonatomic) UIScrollView *scr_content;

@property NSInteger regType;
@property BOOL ADDorChange;

@property (retain, nonatomic) NSString *str_consignee;
@property (retain, nonatomic) NSString *str_mobile;
@property (retain, nonatomic) NSString *str_provinceName;
@property (retain, nonatomic) NSString *str_provinceId;
@property (retain, nonatomic) NSString *str_cityName;
//@property (retain, nonatomic) NSString *str_country;
@property (retain, nonatomic) NSString *str_cityId;
@property (retain, nonatomic) NSString *str_address;
@property (retain, nonatomic) NSString *str_district;   //县（区）
@property (retain, nonatomic) NSString *str_districtId;
@property (retain, nonatomic) NSString *str_id;
//@property (retain, nonatomic) NSString *str_postCode;

@end
