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
#import "MuluScrollView.h"


@interface WJMoneyManagementViewController ()<UITableViewDelegate,UITableViewDataSource,MuluBtnDelegate>

@property (strong, nonatomic) UITableView *infoTableView;
@property (strong, nonatomic)  NSMutableArray <WJMoneyListItem *> *arr_infoListData;
@property (strong, nonatomic) MuluScrollView *menu_ScrollView; //分类ScrollView
@property (strong, nonatomic) NOMoreDataView *noMoreView;

@property (strong, nonatomic) NSArray *arr_Type;

@property (strong, nonatomic) NSString *str_Type;

@end

@implementation WJMoneyManagementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [RegularExpressionsMethod ColorWithHexString:kMSVCBackgroundColor];
    [self initSendReplyWithTitle:@"提现记录" andLeftButtonName:@"ic_back.png" andRightButtonName:nil andTitleLeftOrRight:YES];
    [self.view addSubview:self.infoTableView];
//    self.btn_tiXian.layer.borderColor = [[UIColor whiteColor] CGColor];
//    self.btn_tiXian.layer.cornerRadius = 3;
//    self.btn_tiXian.layer.masksToBounds = YES;//设置圆角
//    self.btn_tiXian.layer.borderWidth = 1.0f;
//    self.arr_infoListData = [NSMutableArray array];


    self.arr_Type = [NSArray arrayWithObjects:@"全部",@"待审核",@"已完成", nil];
    [self addAccountLog];
    // Do any additional setup after loading the view from its nib.
}

-(void)addAccountLog
{
    _menu_ScrollView = [[MuluScrollView alloc]initWithFrame:CGRectMake(0, 0, kMSScreenWith, 44) withTitles:_arr_Type];
    _menu_ScrollView.delegate = self;
    [self.view addSubview:_menu_ScrollView];

    self.str_Type = @"2";
     [self getMoneyManData];

}


-(UITableView *)infoTableView
{
    if (!_infoTableView) {
        _infoTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 44, kMSScreenWith, kMSScreenHeight-kMSNaviHight-44) style:UITableViewStyleGrouped];
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
- (void)didSelectedButtonWithTag:(NSInteger)currTag
{
    switch (currTag) {
        case 0:
            self.str_Type = @"2";
            break;
        case 1:
            self.str_Type = @"0";
            break;
        case 2:
            self.str_Type = @"1";
            break;
        default:
            break;
    }
    [self getMoneyManData];
}
-(void)getMoneyManData
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *uid = [[userDefaults objectForKey:@"userList"] objectForKey:@"uid" ];
    NSMutableDictionary *infos = [NSMutableDictionary dictionary];
    [infos setValue:uid forKey:@"user_id"];
    [infos setValue:self.str_Type forKey:@"is_complete"];
    [self requestAPIWithServe:[kMSBaseMiYoMeiPortURL stringByAppendingString:kMSAccountLog] andInfos:infos];
}
-(void)processData
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
            self.noMoreView = [[NOMoreDataView alloc]initWithFrame:CGRectMake(0, self.view_tabHead.height+44, kMSScreenWith, 80) withContent:@"暂无提现记录." withNODataImage:@"noMore_bg.png"];
            [self.infoTableView addSubview:self.noMoreView];
        }
        [self.infoTableView reloadData];
        
    }
    else
    {
        [SVProgressHUD showErrorWithStatus:[self.results objectForKey:@"msg"]];
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
    return 80.f;
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
