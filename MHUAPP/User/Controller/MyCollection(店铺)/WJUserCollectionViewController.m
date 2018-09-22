//
//  WJUserCollectionViewController.m
//  MHUAPP
//
//  Created by jinri on 2017/12/29.
//  Copyright © 2017年 wenchengjun. All rights reserved.
//

#import "WJUserCollectionViewController.h"
#import "MJRefresh.h"
#import "WJCollectionTabCell.h"
#import "WJCollectionItem.h"
#import "NOMoreDataView.h"


@interface WJUserCollectionViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic)  UITableView *tab_collectionView;
@property (nonatomic,strong)  NSMutableArray<WJCollectionItem *> *dataArr;
@property BOOL editYes;
@property NSInteger page;
@property (strong, nonatomic) UIButton *allSellectedButton;
@property (strong,nonatomic) NSMutableArray *selectedArray;

@property (strong, nonatomic) NOMoreDataView *noMoreView;

@end

@implementation WJUserCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   [self initSendReplyWithTitle:@"我的收藏" andLeftButtonName:@"ic_back.png" andRightButtonName:@"编辑" andTitleLeftOrRight:NO];
    self.view.backgroundColor = [RegularExpressionsMethod ColorWithHexString:kMSVCBackgroundColor];
    [self.view addSubview:self.tab_collectionView];
    _selectedArray = [NSMutableArray array];
    _editYes = YES;
    // Do any additional setup after loading the view.
}
-(UITableView *)tab_collectionView
{
    if (!_tab_collectionView) {

        self.tab_collectionView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kMSScreenWith, kMSScreenHeight-kMSNaviHight)];
        self.tab_collectionView.backgroundColor = [UIColor clearColor];
        self.tab_collectionView.delegate = self;
        self.tab_collectionView.dataSource = self;
        self.tab_collectionView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.tab_collectionView registerClass:[WJCollectionTabCell class] forCellReuseIdentifier:@"WJCollectionTabCell"];
        self.tab_collectionView.alwaysBounceVertical = YES;

        // 下拉刷新
        self.tab_collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRereshing)];
        [self.tab_collectionView.mj_header beginRefreshing];

        // 上拉刷新
        self.tab_collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRereshing)];
    }
    return _tab_collectionView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)showright
{
        if(_editYes)
        {
            [self initSendReplyWithTitle:@"我的收藏" andLeftButtonName:@"ic_back.png" andRightButtonName:@"完成" andTitleLeftOrRight:NO];
            _editYes = NO;


        }
        else
        {
            [self initSendReplyWithTitle:@"我的收藏" andLeftButtonName:@"ic_back.png" andRightButtonName:@"编辑" andTitleLeftOrRight:NO];
            _editYes = YES;
        }
     [self changeViewBotton];
    [_tab_collectionView reloadData];
}

- (void)changeViewBotton {
    if (self.dataArr.count > 0&&!_editYes) {
        UIView *view = [self.view viewWithTag:1000];
        if (view != nil) {
            [view removeFromSuperview];
        }
        for (WJCollectionItem *shop in _dataArr) {
            shop.select = NO;
        }
        [self setupShopCustomBottomView];
    }
    else
    {
        UIView *view = [self.view viewWithTag:1000];
        if (view != nil) {
            [view removeFromSuperview];
        }
    }
}
#pragma mark -- 自定义底部视图
- (void)setupShopCustomBottomView {

    UIView *backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, kMSScreenHeight -  kTabBarHeight-kMSNaviHight, kMSScreenWith, 49)];
    backgroundView.tag = 1000;
    backgroundView.backgroundColor = kMSCellBackColor;
    [self.view addSubview:backgroundView];


    //全选按钮
    UIButton *selectAll = [UIButton buttonWithType:UIButtonTypeCustom];
    selectAll.titleLabel.font = [UIFont systemFontOfSize:16];
    selectAll.frame = CGRectMake(10, 5, 80, 49 - 10);
    [selectAll setTitle:@" 全选" forState:UIControlStateNormal];
    [selectAll setImage:[UIImage imageNamed:@"user_weigouxuan"] forState:UIControlStateNormal];
    [selectAll setImage:[UIImage imageNamed:@"shipcart_seleHigh"] forState:UIControlStateSelected];
    [selectAll setTitleColor:[RegularExpressionsMethod ColorWithHexString:@"666666"] forState:UIControlStateNormal];
    [selectAll addTarget:self action:@selector(selectAllShopBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [backgroundView addSubview:selectAll];
    self.allSellectedButton = selectAll;

    //取消关注
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [RegularExpressionsMethod ColorWithHexString:BASEPINK];
    btn.frame = CGRectMake(kMSScreenWith - 80, 0, 80, 49);
    [btn setTitle:@"取消收藏" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(cancelTheAttention:) forControlEvents:UIControlEventTouchUpInside];
    [backgroundView addSubview:btn];

}
-(void)selectAllShopBtnClick:(UIButton *)sender
{
    sender.selected = !sender.selected;
    //点击全选时,把之前已选择的全部删除
    for (WJCollectionItem *model in _selectedArray) {
        model.select = NO;
    }

    [_selectedArray removeAllObjects];


    if (sender.selected) {

        for (WJCollectionItem *shop in _dataArr) {
            shop.select = YES;
            [_selectedArray addObject:shop];
        }

    } else {
        for (WJCollectionItem *shop in _dataArr) {
            shop.select = NO;
        }
    }
    [_tab_collectionView reloadData];
}
-(void)cancelTheAttention:(UIButton *)button
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *uid = [[userDefaults objectForKey:@"userList"] objectForKey:@"uid" ];
    if (_selectedArray.count > 0) {
        NSMutableArray *arr_recId = [NSMutableArray array];
        for (WJCollectionItem *model in _selectedArray) {
            NSLog(@"选择的商品>>%@>>>%ld",model,(long)model.guanzhu_id);
            [arr_recId addObject:model.guanzhu_id];
        }
        NSString *attString =  [arr_recId componentsJoinedByString:@","];

        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        NSString *uid = [[userDefaults objectForKey:@"userList"] objectForKey:@"uid" ];
        NSMutableDictionary *infos = [NSMutableDictionary dictionary];
        [infos setValue:uid forKey:@"user_id"];
        [infos setValue:attString forKey:@"str"];
        [self requestAPIWithServe:[kMSBaseMiYoMeiPortURL stringByAppendingString:kMSDeleteSupplier] andInfos:infos];
        
        
//        [self requestDeleteAPIWithServe:[NSString stringWithFormat:@"%@/%@/%@?user_id=%@&str=%@",kMSBaseMiYoMeiPortURL,kMSappVersionCode,kMSDeleteSupplier,uid,attString]];

    } else {
        [SVProgressHUD showErrorWithStatus:@"你还没有选择任何店铺"];
    }
}

#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    [_noMoreView hide];
    [_dataArr removeAllObjects];
    _page = 1;
    [self loadData];
}

- (void)footerRereshing
{
    _page ++;
    [self loadData];

}

//加载数据
- (void)loadData
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *uid = [[userDefaults objectForKey:@"userList"] objectForKey:@"uid" ];
    [self requestGetAPIWithServe:[NSString stringWithFormat:@"%@/%@/%@?id=%ld&user_id=%@",kMSBaseMiYoMeiPortURL,kMSappVersionCode,kMSGetSupplierGuanzhu,_page,uid]];
}

-(void)getProcessData
{
    [_tab_collectionView.mj_header endRefreshing];
    [_tab_collectionView.mj_footer endRefreshing];
    if([[self.results objectForKey:@"code"] integerValue] == 200)
    {

        NSMutableArray *arr_Datalist = [NSMutableArray array];
        arr_Datalist = [self.results objectForKey:@"data"];
        if (arr_Datalist&&arr_Datalist.count>0) {
           [self.noMoreView hide];
            if(_page==1)
            {
                _dataArr= arr_Datalist;
            }else
            {
                [_dataArr addObjectsFromArray:arr_Datalist];
            }
             _dataArr = [WJCollectionItem mj_objectArrayWithKeyValuesArray:_dataArr];

            if(arr_Datalist.count<[kMSPULLtableViewCellNumber integerValue])
            {
                [_tab_collectionView.mj_footer endRefreshingWithNoMoreData];
            }
            else{
                _tab_collectionView.mj_footer.hidden = NO;
                self.noMoreView = [[NOMoreDataView alloc]initWithFrame:CGRectMake(0, 0, kMSScreenWith, 80) withContent:@"您还没有收藏的店铺" withNODataImage:@"default_nomore.png"];
                self.noMoreView.hidden = NO;
                [self.view addSubview:self.noMoreView];
            }
             [_tab_collectionView reloadData];
        }
        else
        {
            [_tab_collectionView reloadData];
            [_tab_collectionView.mj_footer endRefreshingWithNoMoreData];
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

    return _dataArr.count;
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WJCollectionTabCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WJCollectionTabCell" forIndexPath:indexPath];
    cell.selectIsHidden = _editYes;
    WJCollectionItem *item = _dataArr[indexPath.row];

    cell.moreShareCanceBlock = ^(BOOL select) {
        item.select = select;
        if (select) {
            [_selectedArray addObject:item];
        } else {
            [_selectedArray removeObject:item];
        }
        [self verityShopAllSelectState];
        [_tab_collectionView reloadData];

    };
    cell.listModel = item;
    return cell;
}

- (void)verityShopAllSelectState {

    NSInteger count = _dataArr.count;

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
    return @"取消收藏";
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
        NSString *attString = _dataArr[indexPath.row].guanzhu_id;
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        NSString *uid = [[userDefaults objectForKey:@"userList"] objectForKey:@"uid" ];
        NSMutableDictionary *infos = [NSMutableDictionary dictionary];
        [infos setValue:uid forKey:@"user_id"];
        [infos setValue:attString forKey:@"str"];
        [self requestAPIWithServe:[kMSBaseMiYoMeiPortURL stringByAppendingString:kMSDeleteSupplier] andInfos:infos];
//        [self requestDeleteAPIWithServe:[NSString stringWithFormat:@"%@/%@/%@?user_id=%@&str=%@",kMSBaseMiYoMeiPortURL,kMSappVersionCode,kMSDeleteSupplier,uid,attString]];

    }

}
-(void)processData
{
    if([[self.results objectForKey:@"code"] integerValue] == 200)
    {
        [self headerRereshing];
    }
    else
    {
        [SVProgressHUD showErrorWithStatus:[self.results objectForKey:@"msg"]];
        return;
    }
}
- (void)firstLoadViewRefresh
{
    [self.tab_collectionView.mj_footer endRefreshing];
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
