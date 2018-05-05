//
//  PayViewController.m
//  IOS_XW
//
//  Created by add on 15/10/22.
//  Copyright (c) 2015年 lan. All rights reserved.
//

#import "PayViewController.h"

#import "SuccessViewController.h"

//#import "WXApiObject.h"


#import "AliPayManagers.h"
//#import "WXApiManager.h"

@interface PayViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
@property (nonatomic, strong) UITableView *tb;
@end

@implementation PayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
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
        _tb = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kMSScreenWith, kMSScreenHeight-64) style:UITableViewStyleGrouped];
        _tb.delegate = self;
        _tb.dataSource = self;
        _tb.sectionHeaderHeight = 0;
        [_tb setSeparatorInset:(UIEdgeInsetsMake(0, 0, 0, 0))];

    }
    return _tb;
}

#pragma mark TableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    else
    {
        return 1;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 40;
    }
    else
    {
        return 49;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"first"];
        cell.textLabel.text = @"确定支付";
        cell.textLabel.font = Font(15);
        NSLog(@"%@",_infoDic);
        cell.detailTextLabel.text = [NSString stringWithFormat:@"￥%.2f",[_infoDic[@"realprice"] floatValue]];
        cell.detailTextLabel.font = Font(15);
        cell.detailTextLabel.tintColor = [UIColor redColor];
        return cell;
    }
    else if(indexPath.section == 1)
    {
        UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"second"];
        cell.imageView.image = [UIImage imageNamed:@"img_icon_zfb"];
        cell.imageView.frame = CGRectMake(0, 0, 30, 30);
        
        cell.textLabel.text = @"支付宝";
        cell.textLabel.font = Font(15);
        cell.textLabel.textColor =  [RegularExpressionsMethod ColorWithHexString:@"757575"];
        
        cell.detailTextLabel.text = @"安全支付";
        cell.detailTextLabel.font = Font(13);
        cell.detailTextLabel.textColor = [RegularExpressionsMethod  ColorWithHexString:@"A3A3A3"];
        return cell;
    }else
    {
        UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"second"];
        cell.imageView.image = [UIImage imageNamed:@"weChat"];
        cell.imageView.frame = CGRectMake(0, 0, 30, 30);
        
        cell.textLabel.text = @"微信支付";
        cell.textLabel.font = Font(15);
        cell.textLabel.textColor = [RegularExpressionsMethod  ColorWithHexString:@"757575"];
        
        cell.detailTextLabel.text = @"亿万用户的选择，更快更安全";
        cell.detailTextLabel.font = Font(13);
        cell.detailTextLabel.textColor = [RegularExpressionsMethod  ColorWithHexString:@"A3A3A3"];
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 11;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    if(indexPath.section == 1){
        
        AliPayManagers *manager = [AliPayManagers shareInstance];
        manager.infoDic = _infoDic;
        [manager payWithSuccess:^{
            SuccessViewController *success = [[SuccessViewController alloc]init];
            success.state = @(0);
            [self.navigationController pushViewController:success animated:YES];
        } fail:^{
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"支付失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
        }];
    }else if((indexPath.section == 2)){
        
//        WXApiManager *manager = [WXApiManager sharedManager];
//        manager.orderInfo = _infoDic;
//        [manager payWithSuccess:^(id status) {
//
//        } faild:^(id status) {
//
//        }];
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    SuccessViewController *success = [[SuccessViewController alloc]init];
    success.state = @(0);
    [self.navigationController pushViewController:success animated:YES];
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
