//
//  PayViewController.m
//  IOS_XW
//
//  Created by add on 15/10/22.
//  Copyright (c) 2015年 lan. All rights reserved.
//

#import "PayViewController.h"

#import "SuccessViewController.h"
#import "AliPayManagers.h"
#import "WXApiManager.h"

#import "WJPayFristTableViewCell.h"
#import "WJpaySectionTableCell.h"

@interface PayViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tb;
@property (strong, nonatomic) UIView *view_foot;
@property (strong, nonatomic) NSIndexPath *selectPath;
@end

@implementation PayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    self.view.backgroundColor = kMSColorFromRGB(127, 127, 127);
    [self.view addSubview:self.tb];
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(push) name:UpLoadNoti object:nil];
}

-(void)push
{
    SuccessViewController *success = [[SuccessViewController alloc]init];
    [self.navigationController pushViewController:success animated:YES];

}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)initView
{
     [self initSendReplyWithTitle:@"收银台" andLeftButtonName:@"ic_back.png" andRightButtonName:nil andTitleLeftOrRight:YES];
}

-(void)backAction
{
    if (!_isDan) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}




-(UITableView *)tb
{
    if (!_tb) {
        _tb = [[UITableView alloc]initWithFrame:CGRectMake(0, kMSScreenHeight/2-80, kMSScreenWith, kMSScreenHeight/2+80) style:UITableViewStylePlain];
        _tb.delegate = self;
        _tb.dataSource = self;
        _tb.sectionHeaderHeight = 0;
        _tb.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tb.tableFooterView = self.view_foot;

    }
    return _tb;
}

#pragma mark TableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    else
    {
        return 2;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 90;
    }
    else
    {
        return 49;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {

        WJPayFristTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WJPayFristTableViewCell"];
        if (cell == nil) {
            cell = [[WJPayFristTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"WJPayFristTableViewCell"];
        }
        cell.lab_price.text = [NSString stringWithFormat:@"￥%.2f",[_oPrice floatValue]];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.colsePayView = ^{
            [self dismissViewControllerAnimated:YES completion:nil];
        };
        return cell;
    }
    else
    {
        WJpaySectionTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WJpaySectionTableCell"];
        if (cell == nil) {
            cell = [[WJpaySectionTableCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"WJpaySectionTableCell"];
        }
        if (indexPath.row==0) {
            cell.img_icon.image = [UIImage imageNamed:@"user_weixin"];
            cell.lab_title.text = @"微信支付";
        }
       else
       {
           cell.img_icon.image = [UIImage imageNamed:@"user_zhifubao"];
           cell.lab_title.text = @"支付宝支付";
        }
        if (_selectPath == indexPath) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }else{
            cell.accessoryType = UITableViewCellAccessoryNone;
        }

        return cell;
    }
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    int newRow = (int)[indexPath row];
    int oldRow = (int)(_selectPath != nil) ? (int)[_selectPath row]:-1;
    if (newRow != oldRow) {
        WJpaySectionTableCell *newCell = [_tb cellForRowAtIndexPath:indexPath];
        newCell.accessoryType = UITableViewCellAccessoryCheckmark;

        WJpaySectionTableCell *oldCell = [_tb cellForRowAtIndexPath:_selectPath];
        oldCell.accessoryType = UITableViewCellAccessoryNone;
        _selectPath = [indexPath copy];

    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}

-(void)PostAliSignStr
{
    NSMutableDictionary *infos = [NSMutableDictionary dictionary];
    [infos setObject:_orderNo forKey:@"orderNo"];
    [infos setObject:_oPrice forKey:@"oPrice"];
    [self requestAPIWithServe:[kMSBaseMiYoMeiPortURL stringByAppendingString:kMSMiYoMeipay] andInfos:infos];
}
-(void)PostWXpaySignStr
{
    NSMutableDictionary *infos = [NSMutableDictionary dictionary];
    [infos setObject:_orderNo forKey:@"orderNo"];
    [infos setObject:_oPrice forKey:@"oPrice"];
    [self requestAPIWithServe:[kMSBaseMiYoMeiPortURL stringByAppendingString:kMSMiYoMeiWXpay] andInfos:infos];
}
-(void)processData
{
    if (_selectPath.row==0) {
        if ([self.results allKeys].count>1) {
            if([WXApi isWXAppInstalled])
            {
            WXApiManager *manager = [WXApiManager sharedManager];
            manager.orderInfo = self.results;
            [manager payWithSuccess:^(id status) {
                NSLog(@"支付成功");
            } faild:^(id status) {
                NSLog(@"支付失败");
            }];
          }
            else
            {
                [SVProgressHUD showErrorWithStatus:@"您没有安装微信！"];
                return;
            }
        }
        else
        {
            [SVProgressHUD showErrorWithStatus:@"提交失败"];
            return;
        }
    }
    else
    {
    NSString *signedString = [self.results objectForKey:@"key"];
    if(signedString.length>1)
    {
        AliPayManagers *manager = [AliPayManagers shareInstance];
        manager.infoStr = signedString;
        [manager payWithSuccess:^{
            self.hidesBottomBarWhenPushed = YES;
            SuccessViewController *success = [[SuccessViewController alloc]init];
            success.state = @(0);
            [self.navigationController pushViewController:success animated:YES];
        } fail:^{
            [SVProgressHUD showErrorWithStatus:@"支付失败"];
        }];

    }
    else
    {
        [SVProgressHUD showErrorWithStatus:@"提交失败"];
        return;
    }
    }
}


-(UIView *)view_foot
{
    if (!_view_foot) {
        _view_foot = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kMSScreenWith, 200)];
        _view_foot.backgroundColor = kMSCellBackColor;

        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(20, 20, kMSScreenWith-40, 48);
        [btn setBackgroundColor:[UIColor redColor]];
        [btn setTitle:@"确定" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.layer.cornerRadius = 5.0;
        btn.titleLabel.font = PFR18Font;
        [btn addTarget:self action:@selector(gotoPayForSection:) forControlEvents:UIControlEventTouchUpInside];
        [_view_foot addSubview:btn];
    }
    return _view_foot;
}

-(void)gotoPayForSection:(UIButton *)sender
{
    if ([_selectPath row]==0) {
        [self PostWXpaySignStr];
    }
    else if ([_selectPath row]==1) {
         [self PostAliSignStr];
    }


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
