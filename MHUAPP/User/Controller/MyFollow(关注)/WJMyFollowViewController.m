//
//  WJMyFollowViewController.m
//  MHUAPP
//
//  Created by jinri on 2018/4/12.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import "WJMyFollowViewController.h"
#import "WJMyFollowTableViewCell.h"
#import "WJFollowClassItem.h"
#import "MJRefresh.h"
#import "NOMoreDataView.h"

@interface WJMyFollowViewController ()
@property (nonatomic,strong)  NSMutableArray <WJFollowClassItem *> *dataArray;
@property (strong,nonatomic) NSMutableArray *selectedArray;
@property (strong,nonatomic) NSMutableArray *goodsArray;
@property (strong, nonatomic) NOMoreDataView *noMoreView;
@property NSInteger page;
@property  BOOL selectedState;


@property (strong,nonatomic) UIButton *allSellectedButton;

@end

@implementation WJMyFollowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [RegularExpressionsMethod ColorWithHexString:kMSVCBackgroundColor];
    [self initSendReplyWithTitle:@"我的关注" andLeftButtonName:@"ic_back.png" andRightButtonName:@"编辑" andTitleLeftOrRight:NO];
//    self.arr_Type = [NSArray arrayWithObjects:@"全部商品",@"销量优先",nil];
    _selectedArray = [NSMutableArray array];
    _goodsArray = [NSMutableArray array];
    _selectedState = YES;
    [self.view addSubview:self.mainTableView];
    // Do any additional setup after loading the view.
}
-(void)showright
{
    if(_selectedState)
    {
        [self initSendReplyWithTitle:@"我的关注" andLeftButtonName:@"ic_back.png" andRightButtonName:@"完成" andTitleLeftOrRight:NO];
        _selectedState = NO;


    }
    else
    {
        [self initSendReplyWithTitle:@"我的关注" andLeftButtonName:@"ic_back.png" andRightButtonName:@"编辑" andTitleLeftOrRight:NO];
        _selectedState = YES;
    }
    [self changeViewBotton];
    [_mainTableView reloadData];
}
- (void)changeViewBotton {
    if (self.dataArray.count > 0&&!_selectedState) {
        UIView *view = [self.view viewWithTag:1001];
        if (view != nil) {
            [view removeFromSuperview];
        }
        for (WJFollowClassItem *shop in _dataArray) {
            shop.select = NO;
        }
        [self setupFollowCustomBottomView];
    }
    else
    {
        UIView *view = [self.view viewWithTag:1001];
        if (view != nil) {
            [view removeFromSuperview];
        }
    }
}
#pragma mark -- 自定义底部视图
- (void)setupFollowCustomBottomView {

    UIView *backgroundView = [[UIView alloc]init];
    backgroundView.backgroundColor = kMSCellBackColor;
    backgroundView.tag = 1000 + 1;
    [self.view addSubview:backgroundView];

    //当有tabBarController时,在tabBar的上面
        backgroundView.frame = CGRectMake(0, kMSScreenHeight -49-kMSNaviHight, kMSScreenWith, 49);



    //全选按钮
    UIButton *selectAll = [UIButton buttonWithType:UIButtonTypeCustom];
    selectAll.titleLabel.font = [UIFont systemFontOfSize:16];
    selectAll.frame = CGRectMake(10, 5, 80, 49 - 10);
    [selectAll setTitle:@" 全选" forState:UIControlStateNormal];
    [selectAll setImage:[UIImage imageNamed:@"user_weigouxuan"] forState:UIControlStateNormal];
    [selectAll setImage:[UIImage imageNamed:@"shipcart_seleHigh"] forState:UIControlStateSelected];
    [selectAll setTitleColor:[RegularExpressionsMethod ColorWithHexString:@"666666"] forState:UIControlStateNormal];
    [selectAll addTarget:self action:@selector(selectFollowAllBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [backgroundView addSubview:selectAll];
    self.allSellectedButton = selectAll;

    //结算按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [RegularExpressionsMethod ColorWithHexString:BASEPINK];
    btn.frame = CGRectMake(kMSScreenWith - 80, 0, 80, 49);
    [btn setTitle:@"取消关注" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(cancelButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [backgroundView addSubview:btn];


}
-(void)selectFollowAllBtnClick:(UIButton *)sender
{
    sender.selected = !sender.selected;
    //点击全选时,把之前已选择的全部删除
    for (WJFollowClassItem *model in _selectedArray) {
        model.select = NO;
    }

    [_selectedArray removeAllObjects];
    if (sender.selected) {

        for (WJFollowClassItem *shop in _dataArray) {
            shop.select = YES;
             [_selectedArray addObject:shop];
        }

    } else {
        for (WJFollowClassItem *shop in _dataArray) {
            shop.select = NO;
        }
    }
    [_mainTableView reloadData];
}
-(void)cancelButtonClick:(UIButton *)button
{
    if (_selectedArray.count > 0) {
        NSMutableArray *arr_recId = [NSMutableArray array];
        for (WJFollowClassItem *model in _selectedArray) {
            NSLog(@"选择的商品>>%@>>>%ld",model,(long)model.rec_id);
            [arr_recId addObject:model.rec_id];
        }
        NSString *attString =  [arr_recId componentsJoinedByString:@","];

        [self requestDeleteAPIWithServe:[NSString stringWithFormat:@"%@/%@/%@?user_id=%@&str=%@",kMSBaseMiYoMeiPortURL,kMSappVersionCode,kMSDeleteGoods,[AppDelegate shareAppDelegate].user_id,attString]];

    } else {
        [SVProgressHUD showErrorWithStatus:@"你还没有选择任何商品"];
    }
}
-(UITableView *)mainTableView
{
    if (!_mainTableView) {

        self.mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kMSScreenWith, kMSScreenHeight-kMSNaviHight)];
        self.mainTableView.backgroundColor = [UIColor clearColor];
        self.mainTableView.delegate = self;
        self.mainTableView.dataSource = self;
        [self.mainTableView registerClass:[WJMyFollowTableViewCell class] forCellReuseIdentifier:@"WJMyFollowTableViewCell"];
        self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.mainTableView.alwaysBounceVertical = YES;
        // 下拉刷新
        self.mainTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerFollowRereshing)];
        [self.mainTableView.mj_header beginRefreshing];

        // 上拉刷新
        self.mainTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerFollowRereshing)];

    }
    return _mainTableView;
}
-(void)headerFollowRereshing
{
    [_noMoreView hide];
    [_dataArray removeAllObjects];
    [self.mainTableView.mj_header endRefreshing];
    [self.mainTableView.mj_footer endRefreshing];
    _page = 1;
    [self loadData];
}

-(void)footerFollowRereshing
{
    _page ++;
    [self loadData];
}
//加载数据
- (void)loadData
{

    [self requestGetAPIWithServe:[NSString stringWithFormat:@"%@/%@/%@?id=%ld&user_id=%@",kMSBaseMiYoMeiPortURL,kMSappVersionCode,kMSGetCollectGoodsr,_page,[AppDelegate shareAppDelegate].user_id]];
}

-(void)getProcessData
{
    [_mainTableView.mj_header endRefreshing];
    [_mainTableView.mj_footer endRefreshing];
    if([[self.results objectForKey:@"code"] integerValue] == 200)
    {

        NSMutableArray *arr_Datalist = [NSMutableArray array];
        arr_Datalist = [[self.results objectForKey:@"data"]objectForKey:@"data"];
        if (arr_Datalist&&arr_Datalist.count>0) {
            [self.noMoreView hide];
            if(_page==1)
            {
                _goodsArray= arr_Datalist;
            }else
            {
                [_goodsArray addObjectsFromArray:arr_Datalist];
            }
            _dataArray = [WJFollowClassItem mj_objectArrayWithKeyValuesArray:_goodsArray];

            if(arr_Datalist.count<[kMSPULLtableViewCellNumber integerValue])
            {
                [_mainTableView.mj_footer endRefreshingWithNoMoreData];
            }
            else{
                _mainTableView.mj_footer.hidden = NO;
                self.noMoreView = [[NOMoreDataView alloc]initWithFrame:CGRectMake(0, 0, kMSScreenWith, 80) withContent:@"您还没有关注的商品" withNODataImage:@"default_nomore.png"];
                [self.view addSubview:self.noMoreView];
            }
             [_mainTableView reloadData];
        }
        else
        {
            [_mainTableView reloadData];
            [_mainTableView.mj_footer endRefreshingWithNoMoreData];
        }

    }
    else
    {
        [self requestFailed:@"获取数据失败"];
    }
}

#pragma mark TableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return _dataArray.count;
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WJMyFollowTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WJMyFollowTableViewCell" forIndexPath:indexPath];
    cell.selectHidden = _selectedState;
    WJFollowClassItem *item = _dataArray[indexPath.row];

    cell.WJCellSelectedBlock = ^(BOOL select) {
        item.select = select;
        if (select) {
            [_selectedArray addObject:item];
        } else {
            [_selectedArray removeObject:item];
        }
        [self verityShopAllSelectState];
        [_mainTableView reloadData];

    };

    cell.listModel = item;
    return cell;
}

- (void)verityShopAllSelectState {

    NSInteger count = _dataArray.count;

    if (_selectedArray.count == count) {
        _allSellectedButton.selected = YES;
    } else {
        _allSellectedButton.selected = NO;
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"取消关注";
}
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}
//进入编辑模式，按下出现的编辑按钮后

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath

{
    [tableView setEditing:NO animated:YES];

    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSString *attString = _dataArray[indexPath.row].rec_id;
        [self requestDeleteAPIWithServe:[NSString stringWithFormat:@"%@/%@/%@?user_id=%@&str=%@",kMSBaseMiYoMeiPortURL,kMSappVersionCode,kMSDeleteGoods,[AppDelegate shareAppDelegate].user_id,attString]];

    }

}
-(void)deleteProcessData
{
    if([[self.results objectForKey:@"code"] integerValue] == 200)
    {
        [self headerFollowRereshing];
    }
    else
    {
        [SVProgressHUD showErrorWithStatus:[self.results objectForKey:@"msg"]];
        return;
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
