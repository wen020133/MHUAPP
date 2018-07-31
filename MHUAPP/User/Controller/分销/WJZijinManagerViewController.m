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
    
    [self.view addSubview:self.infoTableView];
    // Do any additional setup after loading the view from its nib.
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
            
        }
     else  if (indexPath.row==1) {
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

- (IBAction)goToManagerListView:(id)sender {
    
    WJMoneyManagementViewController *AddressVC = [[WJMoneyManagementViewController alloc]init];
    AddressVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:AddressVC animated:YES];
    self.hidesBottomBarWhenPushed = YES;

}
@end
