//
//  WJZijinManagerViewController.m
//  MHUAPP
//
//  Created by wenchengjun on 2018/7/30.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import "WJZijinManagerViewController.h"
#import <UIImageView+WebCache.h>
#import "WJSetHeadTableCell.h"
#import "WJFlowItem.h"
#import "WJMoneyManagementViewController.h"
#import "WJWithdrawViewController.h"

@interface WJZijinManagerViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) NSArray   *arr_typeName;

@property (strong, nonatomic) UITableView *infoTableView;

@end

@implementation WJZijinManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [RegularExpressionsMethod ColorWithHexString:kMSVCBackgroundColor];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"fenXiaoTableListItem" ofType:@"plist" inDirectory:nil];
    _arr_typeName = [[NSArray alloc]initWithContentsOfFile:path];
   [self getZijinManager];
    [self.view addSubview:self.infoTableView];
    
    // Do any additional setup after loading the view from its nib.
}
-(void)getZijinManager
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *uid = [[userDefaults objectForKey:@"userList"] objectForKey:@"uid" ];
    NSMutableDictionary *infos = [NSMutableDictionary dictionary];
    [infos setValue:uid forKey:@"user_id"];
    [self requestAPIWithServe:[kMSBaseMiYoMeiPortURL stringByAppendingString:kMSAccountDeposit] andInfos:infos];
}
-(void)processData
{
    if([[self.results objectForKey:@"code"] integerValue] == 200)
    {
        self.lab_Num.text = self.results[@"data"][@"distributionMoney"];
        self.lab_Num.adjustsFontSizeToFitWidth = YES;
       self.lab_keTiXian.text = self.results[@"data"][@"user_money"];
        self.lab_keTiXian.adjustsFontSizeToFitWidth = YES;
        self.str_distributionMoney = self.lab_keTiXian.text;
        }
    else
    {
       [self requestFailed:self.results[@"msg"]];
        return;
    }
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
        
        _infoTableView.tableHeaderView = self.tab_headNumView;
    }
    return _infoTableView;
}


#pragma mark - UITableViewDelegate UITableViewDataSource Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

//section头部视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 5)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.f;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIndentifier = @"WJSetHeadTableCell";
    WJSetHeadTableCell *cell = (WJSetHeadTableCell *)[tableView dequeueReusableCellWithIdentifier:CellIndentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSArray *data = [WJFlowItem mj_objectArrayWithKeyValuesArray:self.arr_typeName];
    cell.flowItem = [data objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
        if (indexPath.row==0) {
            WJWithdrawViewController *AddressVC = [[WJWithdrawViewController alloc]init];
            AddressVC.str_distributionMoney = self.lab_keTiXian.text;
            AddressVC.hidesBottomBarWhenPushed = YES;
            self.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:AddressVC animated:YES];
        }
     else  if (indexPath.row==1) {
         WJMoneyManagementViewController *AddressVC = [[WJMoneyManagementViewController alloc]init];
         AddressVC.hidesBottomBarWhenPushed = YES;
         self.hidesBottomBarWhenPushed = YES;
         [self.navigationController pushViewController:AddressVC animated:YES];
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
