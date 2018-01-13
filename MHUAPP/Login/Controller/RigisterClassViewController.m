//
//  RigisterClassViewController.m
//  meijiaPrinter
//
//  Created by 今日电器 on 15/7/10.
//  Copyright (c) 2015年 wenchengjun. All rights reserved.
//

#import "RigisterClassViewController.h"
#import "XYMKeyChain.h"
#import "RigisterProtocolViewController.h"
#import "WJPushCodeViewController.h"

@interface RigisterClassViewController ()

@end

@implementation RigisterClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [RegularExpressionsMethod ColorWithHexString:kMSVCBackgroundColor];
    [self initSendReplyWithTitle:@"账户注册" andLeftButtonName:@"ic_back.png" andRightButtonName:nil andTitleLeftOrRight:YES];

    [self.text_moblieNumber becomeFirstResponder];

    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"注册即代表阅读并同意用户协议"];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(10,4)];
    [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue-Bold"size:16] range:NSMakeRange(10, 4)];
    //加下划线
    [str addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(10, 4)];
    self.lab_protocol.userInteractionEnabled = YES;
    self.lab_protocol.attributedText = str;

    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickStr)];
    [self.lab_protocol addGestureRecognizer:tap];

//    _rigisterWebView = [[RigisterProtocolV alloc]initWithFrame:CGRectMake(0, 0, kMSScreenWith, kMSScreenHeight-kMSNaviHight)];
//    [self.view addSubview:_rigisterWebView];

    // Do any additional setup after loading the view from its nib.
}
-(void)clickStr
{
    RigisterProtocolViewController *rigisterPr = [[RigisterProtocolViewController alloc]init];
    rigisterPr.str_urlHttp = @"https://www.baidu.com/";
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:rigisterPr animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





- (IBAction)theNextStep:(id)sender {
    if ([_lab_countryNum.text isEqualToString: @"+86"]&& ![RegularExpressionsMethod validateMobile:self.text_moblieNumber.text]) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确的手机号码！"];
        return;
    }

    [self.text_moblieNumber resignFirstResponder];
    WJPushCodeViewController *codeVc = [[WJPushCodeViewController alloc]init];
    codeVc.str_phone = self.text_moblieNumber.text;
    [self.navigationController pushViewController:codeVc animated:YES];
}
@end
