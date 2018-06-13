//
//  WJUserSettingMainViewController.m
//  MHUAPP
//
//  Created by jinri on 2017/12/6.
//  Copyright © 2017年 wenchengjun. All rights reserved.
//

#import "WJUserSettingMainViewController.h"
#import "WJSetHeadTableCell.h"
#import "WJManageUserInfoViewController.h"
#import "AddAddressViewController.h"
#import <UIImageView+WebCache.h>

#import "WJFlowItem.h"

@interface WJUserSettingMainViewController ()

@end

@implementation WJUserSettingMainViewController

-(void)viewWillAppear:(BOOL)animated
{
    [self.infoTableView reloadData];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *str_logo_img = [[userDefaults objectForKey:@"userList"] objectForKey:@"user_icon"];
    [_headImageView sd_setImageWithURL:[NSURL URLWithString:str_logo_img] placeholderImage:[UIImage imageNamed:@"ic_no_heardPic.png"]];

    [super viewWillAppear:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [RegularExpressionsMethod ColorWithHexString:kMSVCBackgroundColor];
    [self initSendReplyWithTitle:@"账户设置" andLeftButtonName:@"ic_back.png" andRightButtonName:nil andTitleLeftOrRight:YES];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"UserSetIconFlow" ofType:@"plist" inDirectory:nil];

    _arr_typeName = [[NSArray alloc]initWithContentsOfFile:path];

    [self.view addSubview:self.infoTableView];
    // Do any additional setup after loading the view.
}
-(UITableView *)infoTableView
{
    if (!_infoTableView) {
        _infoTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kMSScreenWith, kMSScreenHeight-kMSNaviHight) style:UITableViewStyleGrouped];
        _infoTableView.delegate = self;
        _infoTableView.dataSource = self;
        _infoTableView.backgroundColor =[UIColor clearColor];
        _infoTableView.showsHorizontalScrollIndicator = NO;
    _infoTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        [_infoTableView registerClass:[WJSetHeadTableCell class] forCellReuseIdentifier:@"WJSetHeadTableCell"];

        _infoTableView.tableHeaderView = self.view_head;
        _infoTableView.tableFooterView = self.view_foot;
    }
    return _infoTableView;
}
-(UIView *)view_head
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSLog(@"userlist=%@",[userDefaults objectForKey:@"userList"] );
    NSString *str_logo_img = [[userDefaults objectForKey:@"userList"] objectForKey:@"user_icon"];
    NSString *str_username = [[userDefaults objectForKey:@"userList"] objectForKey:@"username"];
    NSString *phone = [[userDefaults objectForKey:@"userList"] objectForKey:@"phone"];
    if (!_view_head) {
        _view_head = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kMSScreenWith, 108)];
        _view_head.backgroundColor = [RegularExpressionsMethod ColorWithHexString:kMSVCBackgroundColor];
        UIImageView *imagback = ImageViewInit(0, 0, kMSScreenWith, 100);
        imagback.backgroundColor = kMSCellBackColor;
        [_view_head addSubview:imagback];

        _headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 17, 66, 66)];
        _headImageView.contentMode = UIViewContentModeScaleAspectFill;
        _headImageView.userInteractionEnabled = YES;
        _headImageView.layer.masksToBounds = YES;
        _headImageView.layer.cornerRadius = 33;
        // 单击图片
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gotoInfoClick:)];
        [_headImageView addGestureRecognizer:singleTap];
        [_headImageView sd_setImageWithURL:[NSURL URLWithString:str_logo_img] placeholderImage:[UIImage imageNamed:@"ic_no_heardPic.png"]];
        [_view_head addSubview:_headImageView];

        _userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 25, 200, 21)];
        _userNameLabel.font = PFR15Font;
        _userNameLabel.textColor = [RegularExpressionsMethod ColorWithHexString:BASEBLACKCOLOR];
        _userNameLabel.text = str_username;
        [_view_head addSubview:_userNameLabel];

        _phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 50, 200, 21)];
        _phoneLabel.font = PFR14Font;
        _phoneLabel.textColor = [RegularExpressionsMethod ColorWithHexString:BASELITTLEBLACKCOLOR];
        _phoneLabel.text = phone;
        [_view_head addSubview:_phoneLabel];

    }
    return _view_head;
    
}
- (void)gotoInfoClick:(UITapGestureRecognizer *)recognizer
{
    WJManageUserInfoViewController  *userSettingVC = [[WJManageUserInfoViewController alloc]init];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:userSettingVC animated:YES];
}
-(UIView *)view_foot
{
    if (!_view_foot) {
        _view_foot = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kMSScreenWith, 200)];
        _view_foot.backgroundColor = [RegularExpressionsMethod ColorWithHexString:kMSVCBackgroundColor];

        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(20, 78, kMSScreenWith-40, 48);
        [btn setBackgroundColor:[UIColor redColor]];
        [btn setTitle:@"退出登录" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.layer.cornerRadius = 5.0;
        btn.titleLabel.font = PFR18Font;
        [btn addTarget:self action:@selector(loginoutState) forControlEvents:UIControlEventTouchUpInside];
        [_view_foot addSubview:btn];
    }
    return _view_foot;
}

#pragma mark - UITableViewDelegate UITableViewDataSource Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *arr = [self.arr_typeName objectAtIndex:section];
    return arr.count;
}
//section头部间距
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01f;//section头部高度
}
//section头部视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 1)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

//section底部间距
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 8;
}
//section底部视图
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 1)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.arr_typeName.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.f;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIndentifier = @"WJSetHeadTableCell";
    WJSetHeadTableCell *cell = (WJSetHeadTableCell *)[tableView dequeueReusableCellWithIdentifier:CellIndentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSArray *arr = [self.arr_typeName objectAtIndex:indexPath.section];
    NSArray *data = [WJFlowItem mj_objectArrayWithKeyValuesArray:arr];
    cell.flowItem = [data objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.section==0) {
        WJManageUserInfoViewController  *userSettingVC = [[WJManageUserInfoViewController alloc]init];
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:userSettingVC animated:YES];
    }
    else if (indexPath.section==1)
    {
        if (indexPath.row==0) {
            AddAddressViewController *AddressVC = [[AddAddressViewController alloc]init];
            AddressVC.selectCellIndexpathYES = YES;
            self.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:AddressVC animated:YES];
        }
    }
     else if (indexPath.section==2)
     {
         if (indexPath.row==0) {
             AddAddressViewController *AddressVC = [[AddAddressViewController alloc]init];
             AddressVC.selectCellIndexpathYES = YES;
             self.hidesBottomBarWhenPushed = YES;
             [self.navigationController pushViewController:AddressVC animated:YES];
         }
         if (indexPath.row==1) {
             AddAddressViewController *AddressVC = [[AddAddressViewController alloc]init];
             AddressVC.selectCellIndexpathYES = YES;
             self.hidesBottomBarWhenPushed = YES;
             [self.navigationController pushViewController:AddressVC animated:YES];
         }
     }
}
- (void)loginoutState {


    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/xml",@"text/html", nil];


    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970];  //  *1000 是精确到毫秒，不乘就是精确到秒
    NSString *timeString = [NSString stringWithFormat:@"%.0f",a ]; //转为字符型
    NSString *token = [[NSString stringWithFormat:@"mhupro_%@_mhupro",[timeString md5]] md5];

    NSString *url  = [NSString stringWithFormat:@"%@/%@/%@?time=%@&token=%@",kMSBaseMiYoMeiPortURL,kMSappVersionCode,kMSOutLogin,timeString,token];
    NSLog(@"url====%@",url);

    [manager DELETE:url parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"responseObject====%@",responseObject);
        if([[responseObject objectForKey:@"code"] integerValue] == 200)
        {
            NSDictionary *dic = [NSDictionary dictionary];
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            [userDefaults setObject:dic forKey:@"userList"];
            [AppDelegate shareAppDelegate].user_id = @"";
            [userDefaults setObject:@"0" forKey:@"loginState"];
            [userDefaults synchronize];
            [self.navigationController popViewControllerAnimated:YES];
        }
        else
        {
             [SVProgressHUD showErrorWithStatus:@"退出失败"];
        }
    }
     failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 失败，关闭网络指示器
        NSLog(@"ada===%@",[error localizedDescription]);
        NSString *str_error = [error localizedDescription];
        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:str_error];
        return;
    }];
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
