//
//  WJMoneyManagementViewController.m
//  MHUAPP
//
//  Created by wenchengjun on 2018/7/31.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import "WJMoneyManagementViewController.h"
#import "WJMoneyListTableCell.h"


@interface WJMoneyManagementViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *infoTableView;


@end

@implementation WJMoneyManagementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [RegularExpressionsMethod ColorWithHexString:kMSVCBackgroundColor];
    [self initSendReplyWithTitle:@"资金明细" andLeftButtonName:@"ic_back.png" andRightButtonName:nil andTitleLeftOrRight:YES];
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
        [_infoTableView registerClass:[WJMoneyListTableCell class] forCellReuseIdentifier:@"WJMoneyListTableCell"];
        
        _infoTableView.tableHeaderView = self.view_tabHead;
        
    }
    return _infoTableView;
}

-(void)getMoneyManData
{
    [self requestGetAPIWithServe:[NSString stringWithFormat:@"%@/%@/%@?id=%@&user_id=%@",kMSBaseMiYoMeiPortURL,kMSappVersionCode,kMSDistributionList,@"1",[AppDelegate shareAppDelegate].user_id]];
}

#pragma mark - UITableViewDelegate UITableViewDataSource Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
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
    static NSString *CellIndentifier = @"WJMoneyListTableCell";
    WJMoneyListTableCell *cell = (WJMoneyListTableCell *)[tableView dequeueReusableCellWithIdentifier:CellIndentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
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
