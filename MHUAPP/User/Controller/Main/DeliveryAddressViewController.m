//
//  DeliveryAddressViewController.m
//  TOAFRICA
//
//  Created by wenchengjun on 15-1-4.
//
//

#import "DeliveryAddressViewController.h"
#import "JXTAlertController.h"
#import "XWDrawerAnimator.h"
#import "UIViewController+XWTransition.h"
#import "WJChooseLocationViewController.h"
#define TextViewBackHight 50

@interface DeliveryAddressViewController ()<selectAddressDelegate>
//省市县
@property (strong , nonatomic) NSArray *arr_siteList;

@end

@implementation DeliveryAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [RegularExpressionsMethod ColorWithHexString:kMSVCBackgroundColor];
    if (_ADDorChange) {
      [self initSendReplyWithTitle:@"编辑地址" andLeftButtonName:@"ic_back.png" andRightButtonName:@"保存" andTitleLeftOrRight:NO];
    }
    else
    {
      [self initSendReplyWithTitle:@"新建地址" andLeftButtonName:@"ic_back.png" andRightButtonName:@"保存" andTitleLeftOrRight:NO];
    }
    self.scr_content = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kMSScreenWith, kMSScreenHeight-kMSNaviHight)];
    self.scr_content.backgroundColor = [UIColor clearColor];
    NSArray *arrtitle = [NSArray arrayWithObjects:@"收货人:", @"手机号:",@"省、市、区:",nil];
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
    img_province.image = [UIImage imageNamed:@"home_more"];
    [self.scr_content addSubview:img_province];
    
    self.lab_province = [[UILabel alloc]initWithFrame:CGRectMake(90, 12+(TextViewBackHight+2)*2, kMSScreenWith-140, TextViewBackHight-2)];
    self.lab_province.font =[UIFont systemFontOfSize:14];
    self.lab_province.text = self.str_provinceName;
    [self.scr_content addSubview:self.lab_province];
    

//    self.text_postalCode = [[UITextField alloc]initWithFrame:CGRectMake(90, 12+(TextViewBackHight+2)*3, kMSScreenWith-90, TextViewBackHight-2)];
//    self.text_postalCode.font =[UIFont systemFontOfSize:14];
//    self.text_postalCode.delegate =self;
//    self.text_postalCode.keyboardType = UIKeyboardTypePhonePad;
//    self.text_postalCode.text = self.str_postCode;
//    [self.scr_content addSubview:self.text_postalCode];

    UIImageView *image_back = [[UIImageView alloc]initWithFrame:CGRectMake(0,12+(TextViewBackHight+2)*3, kMSScreenWith, TextViewBackHight*2-4)];
    image_back.backgroundColor = [UIColor whiteColor];
    [self.scr_content addSubview:image_back];
    
    UILabel *labeltit = [[UILabel alloc]initWithFrame:CGRectMake(7, 12+(TextViewBackHight+2)*3, 150, TextViewBackHight-2)];
    labeltit.font = [UIFont systemFontOfSize:14];
    labeltit.numberOfLines = 0;
    labeltit.text = @"详细地址:";
    [self.scr_content addSubview:labeltit];
    
    self.texV_address = [[UITextView alloc]initWithFrame:CGRectMake(90, 16+(TextViewBackHight+2)*3, kMSScreenWith-90, TextViewBackHight*2-4)];
    self.texV_address.font =[UIFont systemFontOfSize:14];
    self.texV_address.delegate =self;
    self.texV_address.text = self.str_address;
    [self.scr_content addSubview:self.texV_address];

    
    self.scr_content.contentSize = CGSizeMake(kMSScreenWith, 52*arrtitle.count+20);
    [self.view addSubview:self.scr_content];
    
    [self getServiceAddressList];
    // Do any additional setup after loading the view.
}


-(void)getServiceAddressList
{
    
}

-(void)processData
{
    if([[self.results objectForKey:@"code"] integerValue] == 200)
    {
        if (self.regType==0) {
            id arr = [self.results objectForKey:@"data"];
            if([arr isKindOfClass:[NSArray class]])
            {
                NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
                NSString *fileName = [path stringByAppendingPathComponent:@ "address.plist" ];
                [arr writeToFile:fileName atomically:YES];//执行此行代码时默认新创建一个plist文件
                self.arr_siteList = arr;
            }
        }
        else
        {
             NSString *msgadsasd = [self.results objectForKey:@"msg"];
            [self jxt_showAlertWithTitle:@"消息提示" message:msgadsasd appearanceProcess:^(JXTAlertController * _Nonnull alertMaker) {
                alertMaker.toastStyleDuration = 1;
                [self.navigationController popViewControllerAnimated:YES];

            }actionsBlock:NULL];
        }

    }
    else
    {
        [SVProgressHUD showErrorWithStatus:[self
                                            .results objectForKey:@"msg"]];
    }
}

-(void)selectprovice
{
    [self hiddenTextView];
    WJChooseLocationViewController *dcFeaVc = [WJChooseLocationViewController new];
    dcFeaVc.delegate = self;
    [self setUpAlterViewControllerWith:dcFeaVc WithDistance:kMSScreenHeight * 0.6 WithDirection:XWDrawerAnimatorDirectionBottom WithParallaxEnable:YES WithFlipEnable:YES];
}
-(void)selectAddressRow:(NSString*)province provinceID:(NSString*)provinceID city:(NSString*)city cityID:(NSString*)cityID area:(NSString*)area areaID:(NSString*)areaID
{
    self.str_provinceName = province;
    self.str_provinceId = provinceID;
    self.str_cityName = city;
    self.str_cityId = cityID;
    self.str_district = area;
    self.str_districtId = areaID;
    self.lab_province.text = [NSString stringWithFormat:@"%@ %@ %@",province,city,area];
}
#pragma mark - 转场动画弹出控制器
- (void)setUpAlterViewControllerWith:(UIViewController *)vc WithDistance:(CGFloat)distance WithDirection:(XWDrawerAnimatorDirection)vcDirection WithParallaxEnable:(BOOL)parallaxEnable WithFlipEnable:(BOOL)flipEnable
{

     [self dismissViewControllerAnimated:YES completion:nil];
    XWDrawerAnimatorDirection direction = vcDirection;
    XWDrawerAnimator *animator = [XWDrawerAnimator xw_animatorWithDirection:direction moveDistance:distance];
    animator.toDuration = 0.5;
    animator.backDuration = 0.5;
    animator.parallaxEnable = parallaxEnable;
    animator.flipEnable = flipEnable;
    [self xw_presentViewController:vc withAnimator:animator];
    
    __weak typeof(self)weakSelf = self;
    [animator xw_enableEdgeGestureAndBackTapWithConfig:^{
        [weakSelf _xw_back];
    }];


}
- (void)_xw_back{
    if (self.presentedViewController) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}


-(void)showright
{
    
    if(self.texf_ContactName.text.length==0)
    {
        [SVProgressHUD showErrorWithStatus:@"请输入收货人姓名"];
        return;
    }
    if(![RegularExpressionsMethod validateMobile:self.texf_mobile.text])
    {
        [SVProgressHUD showErrorWithStatus:@"请输入手机号"];
        return;
    }

    if(self.texV_address.text.length==0)
    {
        [SVProgressHUD showErrorWithStatus:@"请填写详细收货地址"];
        return;
    }
    [self hiddenTextView];
    NSString *type = _ADDorChange ? @"add" : @"update";
    self.regType = 2;
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *uid = [[userDefaults objectForKey:@"userList"] objectForKey:@"uid" ];
    [userDefaults synchronize];
    NSMutableDictionary *infos = [NSMutableDictionary dictionary];
    [infos setValue:uid forKey:@"user_id"];
    [infos setValue:type forKey:@"type"];
    [infos setObject:self.texf_ContactName.text forKey:@"consignee"];
    [infos setObject:self.texf_mobile.text forKey:@"mobile"];
//    [infos setObject:self.text_postalCode.text forKey:@"zipcode"];
    [infos setObject:self.str_provinceId forKey:@"province"];
    [infos setObject:self.str_cityId forKey:@"city"];
    [infos setObject:self.str_districtId forKey:@"district"];
    [infos setObject:self.texV_address.text forKey:@"address"];
    if (_ADDorChange) {

    }
    else
    {
        [infos setObject:self.str_id forKey:@"site_id"];
     }
    [self requestAPIWithServe:[kMSBaseLargeCollectionPortURL stringByAppendingString:kMSAddressChangeType] andInfos:infos];
   
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
//    else  if (textField == self.text_postalCode) {
//        [self.text_postalCode becomeFirstResponder];
//        [UIView beginAnimations:nil context:NULL];
//        [UIView setAnimationDuration:0.3f];
//        self.scr_content.contentOffset = CGPointMake(0, 0);
//        [UIView commitAnimations];
//    }

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
//     [self.text_postalCode resignFirstResponder];
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
