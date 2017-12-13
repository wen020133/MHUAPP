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

@interface WJUserSettingMainViewController ()

@end

@implementation WJUserSettingMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [RegularExpressionsMethod ColorWithHexString:kMSVCBackgroundColor];
    [self initSendReplyWithTitle:@"账户设置" andLeftButtonName:@"ic_back.png" andRightButtonName:nil andTitleLeftOrRight:YES];
    self.arr_typeName = [NSArray arrayWithObjects:@"账户安全", @"地址管理",@"用户协议",@"常见问题",@"意见反馈",@"设置",nil];
    [self.view addSubview:self.infoTableView];
    // Do any additional setup after loading the view.
}
-(UITableView *)infoTableView
{
    if (!_infoTableView) {
        _infoTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kMSScreenWith, kMSScreenHeight-kMSNaviHight)];
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
    NSString *str_nickname = [[userDefaults objectForKey:@"userList"] objectForKey:@"nickname"];
    NSString *str_username = [[userDefaults objectForKey:@"userList"] objectForKey:@"username"];
    if (!_view_head) {
        _view_head = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kMSScreenWith, 170)];
        UIImageView *backV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"user_backImageHead.png"]];
        backV.frame = _view_head.frame;
        [_view_head addSubview:backV];

        _headImageView = [[UIImageView alloc] init];
        _headImageView.contentMode = UIViewContentModeScaleAspectFit;
        _headImageView.userInteractionEnabled = YES;
        _headImageView.layer.masksToBounds = YES;
        _headImageView.layer.cornerRadius = 33;
        // 单击图片
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gotoInfoClick:)];
        [_headImageView addGestureRecognizer:singleTap];
        [_headImageView sd_setImageWithURL:[NSURL URLWithString:str_logo_img] placeholderImage:[UIImage imageNamed:@"ic_no_heardPic.png"]];
        [_view_head addSubview:_headImageView];
        [_headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            [make.top.mas_equalTo(_view_head.mas_top)setOffset:10];
            make.centerX.mas_equalTo(_view_head.mas_centerX);
            make.size.mas_equalTo(CGSizeMake(66, 66));

        }];

        _userNameLabel = [[UILabel alloc] init];
        _userNameLabel.font = PFR15Font;
        _userNameLabel.textColor = kMSViewTitleColor;
        _userNameLabel.text = str_username;
        _userNameLabel.textAlignment = NSTextAlignmentCenter;
        [_view_head addSubview:_userNameLabel];
        [_userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            [make.top.mas_equalTo(_headImageView.mas_bottom)setOffset:8];
            make.centerX.mas_equalTo(_view_head.mas_centerX);
            make.size.mas_equalTo(CGSizeMake(200, 20));

        }];

        _profileLabel = [[UILabel alloc] init];
        _profileLabel.font = PFR15Font;
        _profileLabel.textColor = kMSViewTitleColor;
        _profileLabel.textAlignment = NSTextAlignmentCenter;
        _profileLabel.text = str_nickname;
        [_view_head addSubview:_profileLabel];
        [_profileLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            [make.top.mas_equalTo(_userNameLabel.mas_bottom)setOffset:5];
            make.centerX.mas_equalTo(_view_head.mas_centerX);
            make.size.mas_equalTo(CGSizeMake(200, 20));

        }];
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
        btn.frame = CGRectMake(kMSScreenWith/4, 78, kMSScreenWith/2, 44);
        [btn setBackgroundImage:[UIImage imageNamed:@"print_chick_bg.png"] forState:UIControlStateNormal];
        [btn setTitle:@"安全退出" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.titleLabel.font = PFR18Font;
        [btn addTarget:self action:@selector(loginoutState) forControlEvents:UIControlEventTouchUpInside];
        [_view_foot addSubview:btn];
    }
    return _view_foot;
}

#pragma mark - UITableViewDelegate UITableViewDataSource Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
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
    cell.nameLabel.text = self.arr_typeName[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}
- (void)loginoutState {
    NSDictionary *dic = [NSDictionary dictionary];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:dic forKey:@"userList"];

    [userDefaults setObject:@"0" forKey:@"loginState"];
    [userDefaults synchronize];
    [self.navigationController popViewControllerAnimated:YES];
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
