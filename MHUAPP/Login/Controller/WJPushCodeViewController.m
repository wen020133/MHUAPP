//
//  WJPushCodeViewController.m
//  MHUAPP
//
//  Created by jinri on 2017/12/11.
//  Copyright © 2017年 wenchengjun. All rights reserved.
//

#import "WJPushCodeViewController.h"
#import "WJPushPasswordViewController.h"
#import "JXTAlertController.h"

@interface WJPushCodeViewController ()

@end

@implementation WJPushCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [RegularExpressionsMethod ColorWithHexString:kMSVCBackgroundColor];
    [self initSendReplyWithTitle:@"账户注册" andLeftButtonName:@"ic_back.png" andRightButtonName:nil andTitleLeftOrRight:YES];

    [self rigister];
    [_cBtn countDownFromTime:60 unitTitle:@"s" completion:^(MJCountDownButton *countDownButton) {
        [countDownButton setTitle:@"重新发送" forState:UIControlStateNormal];
    }];
    // Do any additional setup after loading the view from its nib.
}
- (void)rigister
{

    NSMutableDictionary *infos = [NSMutableDictionary dictionary];
    [infos setObject:self.str_phone forKey:@"user_name"];
    [infos setObject:@"0" forKey:@"is_exist"];
    [self requestAPIWithServe:[kMSBaseLargeCollectionPortURL stringByAppendingString:kMSBaseCodePortURL] andInfos:infos];

}
-(void)processData
{
    [SVProgressHUD dismiss];
    if([[self.results objectForKey:@"code"] integerValue] == 200)
    {
        NSString *msgadsasd = [self.results objectForKey:@"msg"];
        NSLog(@"JSON: %@", self.results);
        [self jxt_showAlertWithTitle:@"消息提示" message:msgadsasd appearanceProcess:^(JXTAlertController * _Nonnull alertMaker) {
            alertMaker.toastStyleDuration = 2;
            [alertMaker setAlertDidShown:^{
                [self logMsg:@"alertDidShown"];//不用担心循环引用
            }];
            alertMaker.alertDidDismiss = ^{
                [self logMsg:@"alertDidDismiss"];
            };
        } actionsBlock:NULL];
    }
    else
    {
        [SVProgressHUD showErrorWithStatus:[self
                                            .results objectForKey:@"msg"]];
        return;
    }
}
-(void)logMsg:(NSString *)str
{
    NSLog(@"str===%@",str);
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

- (IBAction)toPasswordWC:(id)sender {
    if (_text_code.text.length!=6) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确的验证码！"];
        return;
    }

    [self.text_code resignFirstResponder];
    WJPushPasswordViewController *codeVc = [[WJPushPasswordViewController alloc]init];
    codeVc.str_phone = self.str_phone;
    codeVc.str_code = self.text_code.text;
    [self.navigationController pushViewController:codeVc animated:YES];
}
@end
