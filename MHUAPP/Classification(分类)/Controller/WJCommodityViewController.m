//
//  WJCommodityViewController.m
//  MHUAPP
//
//  Created by wenchengjun on 2017/11/28.
//  Copyright © 2017年 wenchengjun. All rights reserved.
//
#define tableViewW  110
#import "WJCommodityViewController.h"

#import "WJGoodsSortCell.h"
#import "WJClassCategoryCell.h"
#import "WJBrandsSortHeadView.h"

#import "WJHomeNavTopView.h"

#import "WJSearchViewController.h"
#import "WJGoodsSetViewController.h"

// Vendors
#import <UIImageView+WebCache.h>

@interface WJCommodityViewController ()
{
    NSInteger _selectIndex;
}
@end

@implementation WJCommodityViewController

#pragma mark - LifeCyle
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpNav];

    [self setUpTab];

     [self setUpData];

    _selectIndex = 0;
    // Do any additional setup after loading the view.
}
#pragma mark - initizlize
- (void)setUpTab
{
    self.view.backgroundColor = [RegularExpressionsMethod ColorWithHexString:kMSVCBackgroundColor];
    self.tableView.backgroundColor = [RegularExpressionsMethod ColorWithHexString:kMSVCBackgroundColor];
    self.collectionView.backgroundColor = kMSViewBackColor;
    self.automaticallyAdjustsScrollViewInsets = NO;
}
#pragma mark - 设置导航条
- (void)setUpNav
{

    WJHomeNavTopView *searchBarVc = [[WJHomeNavTopView alloc] initWithFrame:CGRectMake(0, 0, kMSScreenWith, kMSNaviHight)];
    searchBarVc.leftItemClickBlock = ^{
        
    };
    searchBarVc.rightItemClickBlock = ^{
        self.tabBarController.selectedIndex = 2;
    };
    searchBarVc.searchButtonClickBlock = ^{
        NSLog(@"点击了搜索");
        WJSearchViewController *ddc = [[WJSearchViewController alloc]init];
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:ddc animated:YES];
        self.hidesBottomBarWhenPushed = NO;

    };
    [self.view addSubview:searchBarVc];

//    searchBarVc.searchViewBlock = ^{
//        NSLog(@"搜索");
//        WJSearchViewController *ddc = [[WJSearchViewController alloc]init];
//        self.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:ddc animated:YES];
//        self.hidesBottomBarWhenPushed = NO;
//    };
//    self.navigationItem.titleView = searchBarVc;
}
#pragma mark - LazyLoad
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.frame = CGRectMake(0, kMSNaviHight, tableViewW, kMSScreenHeight  - kTabBarHeight-kMSNaviHight);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        [self.view addSubview:_tableView];

        [_tableView registerClass:[WJClassCategoryCell class] forCellReuseIdentifier:@"WJClassCategoryCell"];
    }
    return _tableView;
}

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.minimumInteritemSpacing = 3; //X
        layout.minimumLineSpacing = 5;  //Y
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [self.view addSubview:_collectionView];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.alwaysBounceVertical = YES;
        _collectionView.frame = CGRectMake(tableViewW, kMSNaviHight, kMSScreenWith - tableViewW, kMSScreenHeight -kMSNaviHight - kTabBarHeight);
        //注册Cell
        [_collectionView registerClass:[WJGoodsSortCell class] forCellWithReuseIdentifier:@"WJGoodsSortCell"];
        //注册Header
        [_collectionView registerClass:[WJBrandsSortHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"WJBrandsSortHeadView"];
    }
    return _collectionView;
}

#pragma mark - 加载数据
- (void)setUpData
{
    NSMutableDictionary *infos = [NSMutableDictionary dictionary];
    [self requestAPIWithServe:[kMSBaseLargeCollectionPortURL stringByAppendingString:kMSGetGoodsClassType] andInfos:infos];
}
-(void)processData
{
    if([[self.results objectForKey:@"code"] integerValue] == 200)
    {
        id arr = [self.results objectForKey:@"data"];
        if([arr isKindOfClass:[NSArray class]])
        {
             self.titleItem = [WJClassGoodsItem mj_objectArrayWithKeyValuesArray:arr];
            self.arr_collectionList = arr;
            [self.tableView reloadData];
            [self.collectionView reloadData];
           [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:_selectIndex inSection:0] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
        }

    }
    else
    {
        [SVProgressHUD showErrorWithStatus:[self
                                            .results objectForKey:@"msg"]];
    }
}
#pragma mark - <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _titleItem.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WJClassCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WJClassCategoryCell" forIndexPath:indexPath];
    cell.titleItem = _titleItem[indexPath.row];
    return cell;
}

#pragma mark - <UITableViewDelegate>
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat offsetX = indexPath.row*50 - (kMSScreenHeight-113) * 0.5;
    if (offsetX < 0) { //最小
        offsetX = 0;
    }
    CGFloat offsetMax = self.tableView.contentSize.height - (kMSScreenHeight-113);
    if (offsetX > offsetMax) { //最大
        offsetX = offsetMax;
    }
    if(indexPath.row*50>kMSScreenHeight-113)
        [self.tableView setContentOffset:CGPointMake(0, offsetX) animated:YES];
      _selectIndex = indexPath.row;
    [_collectionView reloadData];
    [_collectionView setContentOffset:CGPointMake(0, 0) animated:YES];
}



#pragma mark - <UICollectionDataSource>
- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    NSArray *arr = [[self.arr_collectionList objectAtIndex:_selectIndex] objectForKey:@"children"];
    return arr.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSArray *arr = [[self.arr_collectionList objectAtIndex:_selectIndex] objectForKey:@"children"];
    NSArray *arrList = [[arr objectAtIndex:section] objectForKey:@"children"];
    return arrList.count;
}
#pragma mark - <UICollectionViewDelegate>
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    WJGoodsSortCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WJGoodsSortCell" forIndexPath:indexPath];


   NSArray *arr = [[self.arr_collectionList objectAtIndex:_selectIndex] objectForKey:@"children"];
   NSArray *arrList = [[arr objectAtIndex:indexPath.section] objectForKey:@"children"];
    NSString *urlStr = [NSString stringWithFormat:@"%@",[[arrList objectAtIndex:indexPath.row] objectForKey:@"type_img"]] ;
    NSLog(@"urlStr==%@",urlStr);
    [cell.goodsImageView sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:@"cart_default_bg.png"]];

    cell.goodsTitleLabel.text = [[arrList objectAtIndex:indexPath.row] objectForKey:@"cat_name"];

    return cell;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {


        WJBrandsSortHeadView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"WJBrandsSortHeadView" forIndexPath:indexPath];
    NSArray *arr = [[self.arr_collectionList objectAtIndex:_selectIndex] objectForKey:@"children"];
        headerView.headLabel.text = [[arr objectAtIndex:indexPath.section] objectForKey:@"cat_name"];
    return headerView;
}
#pragma mark - item宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {

    return CGSizeMake((kMSScreenWith - tableViewW- 6)/3, (kMSScreenWith - tableViewW - 6)/3 + 20);

}

#pragma mark - head宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(kMSScreenWith, 40);
}

#pragma mark - foot宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeZero;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"点击了个第%zd分组第%zd几个Item",indexPath.section,indexPath.row);
    self.hidesBottomBarWhenPushed = YES;
    WJGoodsSetViewController *dcVc = [[WJGoodsSetViewController alloc] init];
     _mainmodel = [WJClassGoodsItem mj_objectArrayWithKeyValuesArray:[[[[self.arr_collectionList objectAtIndex:_selectIndex] objectForKey:@"children"] objectAtIndex:indexPath.section] objectForKey:@"children"]];
    dcVc.goodTypeName = _mainmodel[indexPath.row].cat_name;
    dcVc.category_id = _mainmodel[indexPath.row].cat_id;
    [self.navigationController pushViewController:dcVc animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}

#pragma 设置StatusBar为白色
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
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
