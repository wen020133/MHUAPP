//
//  WJCouponsListViewController.m
//  MHUAPP
//
//  Created by jinri on 2017/12/27.
//  Copyright © 2017年 wenchengjun. All rights reserved.
//

#import "WJCouponsListViewController.h"
#import "MJRefresh.h"
#import "WJCouponsListCell.h"

@interface WJCouponsListViewController ()

@end

@implementation WJCouponsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.view.backgroundColor = [RegularExpressionsMethod ColorWithHexString:kMSVCBackgroundColor];
    [self.view addSubview:self.mainTableView];
    // Do any additional setup after loading the view.
}
-(UITableView *)mainTableView
{
    if (!_mainTableView) {

        self.mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kMSScreenWith, kMSScreenHeight-kMSNaviHight-44)];
        self.mainTableView.backgroundColor = [UIColor clearColor];
        self.mainTableView.delegate = self;
        self.mainTableView.dataSource = self;
        self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.mainTableView registerClass:[WJCouponsListCell class] forCellReuseIdentifier:@"WJCouponsListCell"];
        self.mainTableView.alwaysBounceVertical = YES;

        // 下拉刷新
        self.mainTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRereshing)];
        [self.mainTableView.mj_header beginRefreshing];

        // 上拉刷新
        self.mainTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRereshing)];
    }
    return _mainTableView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    [self.mainTableView.mj_header endRefreshing];
    [self.mainTableView.mj_footer endRefreshing];
    _page = 1;
    [self loadData];
}

- (void)footerRereshing
{
    _page ++;
    [self addPhotoListData];

}

//加载数据
- (void)loadData
{

}

-(void)addPhotoListData
{
    _serverType = 2;
    NSMutableDictionary *infos = [NSMutableDictionary dictionary];
    [infos setValue:kMSPULLtableViewCellNumber forKey:@"img_sum"];
    [infos setValue:_str_imgTypeId forKey:@"type_id"];
    [infos setValue:[NSString stringWithFormat:@"%ld",_page] forKey:@"img_page"];
//    [self requestAPIWithServe:[kMSBaseLargeCollectionPortURL stringByAppendingString:kMSImageTypeGet] andInfos:infos];
}
-(void)processData
{
    if([[self.results objectForKey:@"code"] integerValue] == 200)
    {
        NSLog(@"responseObject====%@",[self.results objectForKey:@"msg"]);
        switch (_serverType) {
            case KGetCouponsServerSumList:
            {
                self.totleCount = [[self.results objectForKey:@"data"]  integerValue];
                if (self.totleCount>0) {
                    [self addPhotoListData];
                }
            }
                break;
            case KGetCouponsTypePortList:
            {
                [self.mainTableView.mj_header endRefreshing];
                [self.mainTableView.mj_footer endRefreshing];
                NSMutableArray *arr_Datalist = [NSMutableArray array];
                arr_Datalist =  [self.results objectForKey:@"data"];


                if (![arr_Datalist isEqual:[NSNull null]]) {

                    if(_page==1)
                    {
                        self.dataArr= arr_Datalist;
                    }else
                    {
                        [self.dataArr addObjectsFromArray:arr_Datalist];
                    }

                    if (self.page*10 >= self.totleCount)
                    {
                        [self.mainTableView.mj_footer endRefreshingWithNoMoreData];
                    }
                    [self.mainTableView reloadData];
                }
            }
            default:
                break;
        }


    }
    else
    {

        [self.mainTableView.mj_header endRefreshing];
        [self.mainTableView.mj_footer endRefreshing];
    }
}


#pragma mark TableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return 2;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WJCouponsListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WJCouponsListCell" forIndexPath:indexPath];
//    cell.listModel = self.dataArr[indexPath.row];
    return cell;
}

- (void)firstLoadViewRefresh
{
    [self.mainTableView.mj_footer endRefreshing];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation befre navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
