//
//  WJNickNameChangeViewController.m
//  MHUAPP
//
//  Created by jinri on 2018/1/12.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import "WJNickNameChangeViewController.h"

@interface WJNickNameChangeViewController ()

@end

@implementation WJNickNameChangeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [RegularExpressionsMethod ColorWithHexString:kMSVCBackgroundColor];
    [self initSendReplyWithTitle:@"修改昵称" andLeftButtonName:@"ic_back.png" andRightButtonName:@"确定" andTitleLeftOrRight:NO];
    [self initNickNameTextf];
    [self.textf_nickName becomeFirstResponder];
    // Do any additional setup after loading the view.
}

-(void)initNickNameTextf
{
    UIImageView *img_back = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kMSScreenWith, 44)];
    img_back.backgroundColor = kMSCellBackColor;
    [self.view addSubview:img_back];

    self.textf_nickName = [[UITextField alloc]initWithFrame:CGRectMake(10, 0, kMSScreenWith-20, 44)];
    self.textf_nickName.clearButtonMode = UITextFieldViewModeAlways;
    self.textf_nickName.backgroundColor = kMSCellBackColor;
    [self.view addSubview:self.textf_nickName];

    UILabel *lab_action = [[UILabel alloc]initWithFrame:CGRectMake(10, 45, kMSScreenWith-20, 30)];
    lab_action.text = @"4-20个字符，可由中英文、数字、“_”、“-”组成";
    lab_action.font = PFR13Font;
    lab_action.textColor =[RegularExpressionsMethod ColorWithHexString:BASELITTLEBLACKCOLOR];
    [self.view addSubview:lab_action];
}

-(void)showright
{

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
