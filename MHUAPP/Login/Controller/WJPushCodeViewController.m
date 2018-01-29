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

//    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
//    NSTimeInterval a=[dat timeIntervalSince1970];  //  *1000 是精确到毫秒，不乘就是精确到秒
//    NSString *timeString = [NSString stringWithFormat:@"%.0f",a ]; //转为字符型
//
//    NSString *token= [[NSString stringWithFormat:@"jinri_%@_jinri",[timeString md5]] md5] ;
//    NSLog(@"NSString stringWithFo===%@/%@/%@/%@/%@",kMSBaseCodePortURL,timeString,token,self.str_phone,@"0");
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/html",@"text/plain", nil ];
//    [manager GET:[NSString stringWithFormat:@"%@/%@/%@/%@/%@",kMSBaseCodePortURL,timeString,token,self.str_phone,@"0"] parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
//        NSLog(@"JSON: %@", responseObject);
//        if ([responseObject isKindOfClass:[NSDictionary class]]) {
//            NSDictionary *dic = responseObject;
//            NSString *str=[dic objectForKey:@"msg"];
//            if([[dic objectForKey:@"code"] integerValue] == 200)
//            {
//
//                [self jxt_showAlertWithTitle:@"消息提示" message:str appearanceProcess:^(JXTAlertController * _Nonnull alertMaker) {
//                    alertMaker.toastStyleDuration = 2;
//                } actionsBlock:NULL];
//            }
//            else
//            {
//                 NSLog(@"JSON: %@", responseObject);
//                [SVProgressHUD showErrorWithStatus:[responseObject objectForKey:@"msg"]];
//                return;
//            }
//
//        }
//
//    } failure:^(NSURLSessionTask *operation, NSError *error) {
//        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
//        return;
//    }];
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
- (IBAction)getCodeAgain:(id)sender {
    [self rigister];
}
@end
