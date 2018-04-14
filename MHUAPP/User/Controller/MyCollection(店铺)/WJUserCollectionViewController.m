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


@interface WJUserCollectionViewController ()

@end

@implementation WJUserCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSendReplyWithTitle:@"店铺" andLeftButtonName:@"ic_back.png" andRightButtonName:nil andTitleLeftOrRight:YES];
    self.view.backgroundColor = [RegularExpressionsMethod ColorWithHexString:kMSVCBackgroundColor];
    [self.view addSubview:self.tab_collectionView];
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
#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    [self.tab_collectionView.mj_header endRefreshing];
    [self.tab_collectionView.mj_footer endRefreshing];
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
    [infos setValue:[NSString stringWithFormat:@"%ld",_page] forKey:@"img_page"];
//    [self requestAPIWithServe:[kMSBaseLargeCollectionPortURL stringByAppendingString:kMSImageTypeGet] andInfos:infos];
}
-(void)processData
{
    if([[self.results objectForKey:@"code"] integerValue] == 200)
    {
        NSLog(@"responseObject====%@",[self.results objectForKey:@"msg"]);
        switch (_serverType) {
            case KGetCollectionServerSumList:
            {
                self.totleCount = [[self.results objectForKey:@"data"]  integerValue];
                if (self.totleCount>0) {
                    [self addPhotoListData];
                }
            }
                break;
            case KGetCollectionTypePortList:
            {
                [self.tab_collectionView.mj_header endRefreshing];
                [self.tab_collectionView.mj_footer endRefreshing];
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
                        [self.tab_collectionView.mj_footer endRefreshingWithNoMoreData];
                    }
                    [self.tab_collectionView reloadData];
                }
            }
            default:
                break;
        }


    }
    else
    {

        [self.tab_collectionView.mj_header endRefreshing];
        [self.tab_collectionView.mj_footer endRefreshing];
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
    WJCollectionTabCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WJCollectionTabCell" forIndexPath:indexPath];
    cell.moreShareCanceBlock  = ^{
        [self moreClickShareAndCancel:indexPath.row];
    };
    return cell;
}

-(void)moreClickShareAndCancel:(NSInteger )tag
{

    self.zh_popupController = [zhPopupController popupControllerWithMaskType:zhPopupMaskTypeClear];
    self.zh_popupController.layoutType = zhPopupLayoutTypeBottom;
    self.zh_popupController.allowPan = YES;
    // ...
    [self.zh_popupController presentContentView:self.wallView];


}
- (zhWallView *)wallView {
    CGRect rect = CGRectMake(100, 100, kMSScreenWith, 300);
    zhWallView *wallView = [[zhWallView alloc] initWithFrame:rect];
    wallView.wallHeaderLabel.text = @"";
    wallView.wallFooterLabel.text = @"取消";
    wallView.models = [self wallModels];
    [wallView autoAdjustFitHeight];
    return wallView;
}

- (NSArray *)wallModels {

    NSArray *titles = @[@"取消收藏",@"进入店铺",@"分享"];
    NSArray *images = @[@"user_icon_wodeshoucang.png",@"user_icon_enterShop.png",@"user_icon_share.png"];

    NSMutableArray *array1 = [NSMutableArray array];
    for (int kk=0;kk<titles.count;kk++) {
        [array1 addObject:[zhWallItemModel modelWithImage:[UIImage imageNamed:[images objectAtIndex:kk]] text:[titles objectAtIndex:kk]]];
    }

    return [NSMutableArray arrayWithObjects:array1, nil];
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


        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"你确定删除该消息？" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {

        }]];

        [self presentViewController:alertController animated:YES completion:nil];

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
