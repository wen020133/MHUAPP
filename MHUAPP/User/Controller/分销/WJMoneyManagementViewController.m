//
//  WJMoneyManagementViewController.m
//  MHUAPP
//
//  Created by wenchengjun on 2018/7/31.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import "WJMoneyManagementViewController.h"
#import "WJMoneyListTableCell.h"
#import "WJMoneyListItem.h"
#import "NOMoreDataView.h"
#import "UIView+UIViewFrame.h"


@interface WJMoneyManagementViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *infoTableView;
@property (strong, nonatomic)  NSMutableArray <WJMoneyListItem *> *arr_infoListData;
@property (strong, nonatomic) NOMoreDataView *noMoreView;
@end

@implementation WJMoneyManagementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [RegularExpressionsMethod ColorWithHexString:kMSVCBackgroundColor];
    [self initSendReplyWithTitle:@"资金明细" andLeftButtonName:@"ic_back.png" andRightButtonName:nil andTitleLeftOrRight:YES];
    [self.view addSubview:self.infoTableView];
    self.btn_tiXian.layer.borderColor = [[UIColor whiteColor] CGColor];
    self.btn_tiXian.layer.cornerRadius = 3;
    self.btn_tiXian.layer.masksToBounds = YES;//设置圆角
    self.btn_tiXian.layer.borderWidth = 1.0f;
    self.arr_infoListData = [NSMutableArray array];
    [self getMoneyManData];
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
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *uid = [[userDefaults objectForKey:@"userList"] objectForKey:@"uid" ];
    [self requestGetAPIWithServe:[NSString stringWithFormat:@"%@/%@/%@?user_id=%@",kMSBaseMiYoMeiPortURL,kMSappVersionCode,kMSDepositMoney,uid]];
}
-(void)getProcessData
{
    if([[self.results objectForKey:@"code"] integerValue] == 200)
    {
    
        [_arr_infoListData removeAllObjects];
            NSArray *arr_Datalist = [NSArray array];
            arr_Datalist = [self.results objectForKey:@"data"];
            if (arr_Datalist&&arr_Datalist.count>0) {
                [self.noMoreView hide];
                _arr_infoListData=[WJMoneyListItem mj_objectArrayWithKeyValuesArray:arr_Datalist];
            }
            else
            {
                [self.noMoreView hide];
                self.noMoreView = [[NOMoreDataView alloc]initWithFrame:CGRectMake(0, self.view_tabHead.height+44, kMSScreenWith, 80) withContent:@"暂无可分销商品." withNODataImage:@"noMore_bg.png"];
                [self.infoTableView addSubview:self.noMoreView];
            }
            [self.infoTableView reloadData];
        
    }
    else
    {
        [SVProgressHUD showErrorWithStatus:[self.results objectForKey:@"data"]];
        return;
    }
}
#pragma mark - UITableViewDelegate UITableViewDataSource Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arr_infoListData.count;
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
    cell.model = self.arr_infoListData[indexPath.row];
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
