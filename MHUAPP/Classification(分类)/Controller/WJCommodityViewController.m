//
//  WJCommodityViewController.m
//  MHUAPP
//
//  Created by wenchengjun on 2017/11/28.
//  Copyright © 2017年 wenchengjun. All rights reserved.
//
#define tableViewW  100
#import "WJCommodityViewController.h"

#import "WJGoodsSortCell.h"
#import "WJClassCategoryCell.h"
#import "WJBrandsSortHeadView.h"

#import "WJNavSearchBarView.h"




@interface WJCommodityViewController ()

@end

@implementation WJCommodityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpNav];

    [self setUpTab];

     [self setUpData];
    // Do any additional setup after loading the view.
}
#pragma mark - initizlize
- (void)setUpTab
{
    self.view.backgroundColor = [RegularExpressionsMethod ColorWithHexString:kMSVCBackgroundColor];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
}
#pragma mark - 设置导航条
- (void)setUpNav
{

    WJNavSearchBarView *searchBarVc = [[WJNavSearchBarView alloc] init];
    searchBarVc.placeholdLabel.text = @"快速查找商品";
    searchBarVc.frame = CGRectMake(20, 25, kMSScreenWith * 0.88, 35);

    searchBarVc.searchViewBlock = ^{
        NSLog(@"搜索");
    };

    self.navigationItem.titleView = searchBarVc;
}
#pragma mark - LazyLoad
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.frame = CGRectMake(0, 0, tableViewW, kMSScreenHeight  - 49);
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
        _collectionView.frame = CGRectMake(tableViewW, 0, kMSScreenWith - tableViewW, kMSScreenHeight  - 49);
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
    _titleItem = [WJClassGoodsItem mj_objectArrayWithFilename:@"ClassifyTitles.plist"];
    _mainmodel = [WJClassMainGoodTypeModel mj_objectArrayWithFilename:@"HomeHighGoods.plist"];
    //默认选择第一行（注意一定要在加载完数据之后）
    [_tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
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

}

#pragma mark - <UICollectionDataSource>
- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return _titleItem.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _mainmodel.count;
}
#pragma mark - <UICollectionViewDelegate>
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    WJGoodsSortCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WJGoodsSortCell" forIndexPath:indexPath];
    cell.model = _mainmodel[indexPath.row];
    return cell;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {


        WJBrandsSortHeadView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"WJBrandsSortHeadView" forIndexPath:indexPath];
        headerView.titleItem = _titleItem[indexPath.section];
    return headerView;
}
#pragma mark - item宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {

    return CGSizeMake((kMSScreenWith - tableViewW - 6)/3, (kMSScreenWith - tableViewW - 6)/3 + 20);

}

#pragma mark - head宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(kMSScreenWith, 25);
}

#pragma mark - foot宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeZero;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"点击了个第%zd分组第%zd几个Item",indexPath.section,indexPath.row);
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
