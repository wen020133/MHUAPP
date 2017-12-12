//
//  DeliveryAddressViewController.m
//  TOAFRICA
//
//  Created by wenchengjun on 15-1-4.
//
//

#import "DeliveryAddressViewController.h"
#define TextViewBackHight 50

@interface DeliveryAddressViewController ()

@end

@implementation DeliveryAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kMSViewBackColor;
    [self initSendReplyWithTitle:@"编辑收货地址" andLeftButtonName:@"ic_back.png" andRightButtonName:@"保存" andTitleLeftOrRight:NO];
    self.scr_content = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kMSScreenWith, kMSScreenHeight-kMSNaviHight)];
    self.scr_content.backgroundColor = [UIColor clearColor];
    NSArray *arrtitle = [NSArray arrayWithObjects:@"收货人姓名:", @"手机号:",@"省、市、区:",@"邮编:",nil];
    for (int kkk=0; kkk<arrtitle.count; kkk++) {
       
        UIImageView *image_back = [[UIImageView alloc]initWithFrame:CGRectMake(0, 12+(TextViewBackHight+2)*kkk, kMSScreenWith, TextViewBackHight-2)];
        image_back.backgroundColor = [UIColor whiteColor];
        [self.scr_content addSubview:image_back];
        
            UILabel *labeltit = [[UILabel alloc]initWithFrame:CGRectMake(7, 12+(TextViewBackHight+2)*kkk, 150, TextViewBackHight-2)];
            labeltit.font = [UIFont systemFontOfSize:14];
            labeltit.numberOfLines = 0;
            labeltit.text = [arrtitle objectAtIndex:kkk];
            [self.scr_content addSubview:labeltit];
    }
    
    self.texf_ContactName = [[UITextField alloc]initWithFrame:CGRectMake(90, 12, kMSScreenWith-90, TextViewBackHight-2)];
    self.texf_ContactName.font =[UIFont systemFontOfSize:14];
    self.texf_ContactName.placeholder = @"请填写收货人姓名";
    self.texf_ContactName.delegate =self;
    self.texf_ContactName.backgroundColor = [UIColor clearColor];
    self.texf_ContactName.text =self.str_consignee;
    [self.scr_content addSubview:self.texf_ContactName];
    
    self.texf_mobile = [[UITextField alloc]initWithFrame:CGRectMake(90, 12+(TextViewBackHight+2)*1, kMSScreenWith-90, TextViewBackHight-2)];
    self.texf_mobile.font =[UIFont systemFontOfSize:14];
    self.texf_mobile.placeholder = @"请输入手机号";
    self.texf_mobile.delegate =self;
    self.texf_mobile.keyboardType = UIKeyboardTypePhonePad;
    self.texf_mobile.text = self.str_mobile;
    [self.scr_content addSubview:self.texf_mobile];
    
    UIButton *province =[UIButton buttonWithType:UIButtonTypeCustom];//select Province
    [province setFrame:CGRectMake(0, 12+(TextViewBackHight+2)*2, kMSScreenWith, TextViewBackHight-2)];
    province.backgroundColor = [UIColor clearColor];
    [province addTarget:self action:@selector(selectprovice) forControlEvents:UIControlEventTouchUpInside];
    [self.scr_content addSubview:province];
    
    UIImageView *img_province = [[UIImageView alloc]initWithFrame:CGRectMake(kMSScreenWith-20, 32+(TextViewBackHight+2)*2, 5, 9)];
    img_province.image = [UIImage imageNamed:@"right_arrow.png"];
    [self.scr_content addSubview:img_province];
    
    self.lab_province = [[UILabel alloc]initWithFrame:CGRectMake(90, 12+(TextViewBackHight+2)*2, kMSScreenWith-140, TextViewBackHight-2)];
    self.lab_province.font =[UIFont systemFontOfSize:14];
    self.lab_province.text = self.str_provinceName;
    [self.scr_content addSubview:self.lab_province];
    

    self.text_postalCode = [[UITextField alloc]initWithFrame:CGRectMake(90, 12+(TextViewBackHight+2)*3, kMSScreenWith-90, TextViewBackHight-2)];
    self.text_postalCode.font =[UIFont systemFontOfSize:14];
    self.text_postalCode.delegate =self;
    self.text_postalCode.keyboardType = UIKeyboardTypePhonePad;
    self.text_postalCode.text = self.str_postCode;
    [self.scr_content addSubview:self.text_postalCode];
    
    UIImageView *image_back = [[UIImageView alloc]initWithFrame:CGRectMake(0, 12+(TextViewBackHight+2)*4, kMSScreenWith, TextViewBackHight*2-4)];
    image_back.backgroundColor = [UIColor whiteColor];
    [self.scr_content addSubview:image_back];
    
    UILabel *labeltit = [[UILabel alloc]initWithFrame:CGRectMake(7, 12+(TextViewBackHight+2)*4, 150, TextViewBackHight-2)];
    labeltit.font = [UIFont systemFontOfSize:14];
    labeltit.numberOfLines = 0;
    labeltit.text = @"详细地址:";
    [self.scr_content addSubview:labeltit];
    
    self.texV_address = [[UITextView alloc]initWithFrame:CGRectMake(90, 16+(TextViewBackHight+2)*4, kMSScreenWith-90, TextViewBackHight*2-4)];
    self.texV_address.font =[UIFont systemFontOfSize:14];
    self.texV_address.delegate =self;
    self.texV_address.text = self.str_address;
    [self.scr_content addSubview:self.texV_address];

    
    self.scr_content.contentSize = CGSizeMake(kMSScreenWith, 52*arrtitle.count+20);
    [self.view addSubview:self.scr_content];
    
    [self investListRequest];
    // Do any additional setup after loading the view.
}
-(void)selectcountry
{
  
}
- (void)checkCountry:(NSString *)country phonePrefix:(NSString*)phonePrefix countryLogo:(NSString*)countryLogo countryCode:(NSString *)countryCode countryid:(NSString *)countryid
{
    self.str_country = country;
    self.countryID = countryid;
    [self investListRequest];
}
-(void)investListRequest
{
    self.regType = 0;
    
}

-(void)selectprovice
{
    
    [self hiddenTextView];
    [_pickerView removeFromSuperview];
    _pickerView = [[WJMYPickerView alloc]initWithFrame:CGRectMake(0, kMSNaviHight, kMSScreenWith, kMSScreenHeight-44)];
    _pickerView.delegate = self;
    [_pickerView initView];
//    NSMutableArray *arr = [NSMutableArray array];
//    for (int kkk=0; kkk<self.arr_country.count; kkk++) {
//        [arr addObject:[NSString stringWithFormat:@"%@", [[self.arr_country objectAtIndex:kkk] objectForKey:@"regionNameEn"]]];
//    }
//    self.selectprovinceOrCity=1;
//    if(self.arr_country.count>0)
//    {
//        _pickerView.arrays = arr;
//        [self.view addSubview:_pickerView];
//        [_pickerView show];
//    }
}
-(void)selectcity
{
    [self hiddenTextView];
    [_pickerView removeFromSuperview];
    NSLog(@"---%@",self.arr_city );
    _pickerView = [[WJMYPickerView alloc]initWithFrame:CGRectMake(0, kMSNaviHight, kMSScreenWith, kMSScreenHeight-44)];
    _pickerView.delegate = self;
    [_pickerView initView];
    NSMutableArray *arr = [NSMutableArray array];
    for (int kkk=0; kkk<self.arr_city.count; kkk++) {
        [arr addObject:[NSString stringWithFormat:@"%@", [[self.arr_city objectAtIndex:kkk] objectForKey:@"regionNameEn"]]];
    }
    self.selectprovinceOrCity=2;
    if(self.arr_city.count>0)
    {
        _pickerView.arrays = arr;
        [self.view addSubview:_pickerView];
        [_pickerView show];
    }
}
- (void)selectPickerViewRow:(NSInteger)row andName:(NSString *)str
{
    if(self.selectprovinceOrCity==1)
    {
        self.lab_province.text = str;
        self.str_cityId = nil;
            self.regType =4;
    }
    else
    {
        self.str_cityId = [[self.arr_city objectAtIndex:row] objectForKey:@"id"];
    }
}
-(void)showright
{
    
    if(self.texf_ContactName.text.length==0)
    {
        [SVProgressHUD showErrorWithStatus:@"请输入收货人姓名"];
        return;
    }
    if(self.texf_mobile.text.length==0)
    {
        [SVProgressHUD showErrorWithStatus:@"请输入手机号"];
        return;
    }
    if(self.text_postalCode.text.length==0)
    {
        [SVProgressHUD showErrorWithStatus:@"请输入邮政编码"];
        return;
    }
    if(!self.countryID)
    {
        [SVProgressHUD showErrorWithStatus:@"请选择城市"];
        return;
    }

    if(self.texV_address.text.length==0)
    {
        [SVProgressHUD showErrorWithStatus:@"请填写详细收货地址"];
        return;
    }
    [self hiddenTextView];
   
   
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.scr_content.contentSize = CGSizeMake(kMSScreenWith, 500+(TextViewBackHight+2)*6);
    if (textField == self.texf_ContactName) {
        [self.texf_ContactName becomeFirstResponder];
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.3f];
        self.scr_content.contentOffset = CGPointMake(0, 0);
        [UIView commitAnimations];
    }
   
    else  if (textField == self.texf_mobile) {
        [self.texf_mobile becomeFirstResponder];
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.3f];
        self.scr_content.contentOffset = CGPointMake(0, 0);
        [UIView commitAnimations];
    }
    else  if (textField == self.text_postalCode) {
        [self.text_postalCode becomeFirstResponder];
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.3f];
        self.scr_content.contentOffset = CGPointMake(0, 0);
        [UIView commitAnimations];
    }
    
}
- (void)textViewDidBeginEditing:(UITextView *)textView
{
  if (textView == self.texV_address) {
        [self.texV_address becomeFirstResponder];
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.3f];
        self.scr_content.contentOffset = CGPointMake(0, 50);
        [UIView commitAnimations];
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self hiddenTextView];
    
    return YES;
}
-(void)hiddenTextView
{
    [self.texf_ContactName resignFirstResponder];
    [self.texf_mobile resignFirstResponder];
     [self.text_postalCode resignFirstResponder];
     self.scr_content.contentSize = CGSizeMake(kMSScreenWith, 52*6+280);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
