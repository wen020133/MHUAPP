//
//  WJYouZhiXinPinViewController.m
//  MHUAPP
//
//  Created by jinri on 2018/3/31.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import "WJYouZhiXinPinViewController.h"
//#import "WJYouZhiXinPinCouponsCell.h"
#import "WJYZXPListViewCell.h"
#import "WJSSPTTypeHeadView.h"
#import "WJJRPTItem.h"
#import "MJRefresh.h"
#import "WJGoodDetailViewController.h"


@interface WJYouZhiXinPinViewController ()<UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource>

//@property (strong, nonatomic) NSArray *arr_HotSellType;

@property (strong, nonatomic) UICollectionView *collectionV;

@property (strong, nonatomic) NSMutableArray <WJJRPTItem *> *arr_newsData;
@property NSInteger page_Information;
@end

@implementation WJYouZhiXinPinViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSendReplyWithTitle:@"优质新品" andLeftButtonName:@"ic_back.png" andRightButtonName:nil andTitleLeftOrRight:YES];
    self.view.backgroundColor = [RegularExpressionsMethod ColorWithHexString:kMSVCBackgroundColor];
//    self.arr_HotSellType = [NSArray arrayWithObjects:@"全部",@"电吹风机",@"直卷发器",@"洗发定型",@"染发烫发",@"染发烫发",@"染发烫发", nil];
//    [self addhotsellControlView];
    _arr_newsData = [NSMutableArray array];
    [self.view addSubview:self.collectionV];
    // Do any additional setup after loading the view.
}
//-(void)addhotsellControlView
//{
//    _menu_newScrollView = [[MenuScrollView alloc]initWithFrame:CGRectMake(0, 0, kMSScreenWith, 44) withTitles:self.arr_HotSellType withScrollViewWidth:kMSScreenWith];
//    _menu_newScrollView.delegate = self;
//    [self.view addSubview:_menu_newScrollView];
//}
-(void)headerRereshingXinPin
{
    _page_Information = 1;
    [self getGetIsNewGoods];
}
-(void)footerRereshingXinPin
{
    _page_Information ++;
    [self getGetIsNewGoods];
}
-(void)getGetIsNewGoods
{
    [self requestGetAPIWithServe:[NSString stringWithFormat:@"%@/%@/%@?id=%ld",kMSBaseMiYoMeiPortURL,kMSappVersionCode,kMSGetIsNewGoods,_page_Information]];
}
-(void)getProcessData
{

    [_collectionV.mj_header endRefreshing];
    [_collectionV.mj_footer endRefreshing];
    if([[self.results objectForKey:@"code"] integerValue] == 200)
    {

        NSArray *arr_Datalist = [[self.results objectForKey:@"data"] objectForKey:@"data"];
        NSMutableArray *entities = [NSMutableArray array];
        if (arr_Datalist&&arr_Datalist.count>0) {

            entities = [WJJRPTItem mj_objectArrayWithKeyValuesArray:arr_Datalist];

            if(_page_Information==1)
            {
                _arr_newsData= entities;
            }else
            {
                [_arr_newsData addObjectsFromArray:entities];
            }
            [_collectionV reloadData];
            if(entities.count<[kMSPULLtableViewCellNumber integerValue])
            {
                [_collectionV.mj_footer endRefreshingWithNoMoreData];
            }
            else{
                _collectionV.mj_footer.hidden = NO;
            }
        }
        else
        {
            [_collectionV.mj_footer endRefreshingWithNoMoreData];
        }

    }
    else
    {
        [self requestFailed:@"获取数据失败"];
    }
}
-(UICollectionView *)collectionV
{
    if (!_collectionV) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        _collectionV = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kMSScreenWith, kMSScreenHeight-kMSNaviHight) collectionViewLayout:layout];

        _collectionV.backgroundColor = [UIColor clearColor];
        _collectionV.delegate = self;
        _collectionV.dataSource = self;
        _collectionV.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        [_collectionV registerClass:[WJSSPTTypeHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"WJSSPTTypeHeadView"];
//        [_collectionV registerClass:[WJYouZhiXinPinCouponsCell class] forCellWithReuseIdentifier:@"WJYouZhiXinPinCouponsCell"];
        [_collectionV registerClass:[WJYZXPListViewCell class] forCellWithReuseIdentifier:@"WJYZXPListViewCell"];

        // 下拉刷新
        _collectionV.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRereshingXinPin)];
        [_collectionV.mj_header beginRefreshing];
        // 上拉刷新
        _collectionV.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRereshingXinPin)];
    }
    return _collectionV;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;

    if([kind isEqualToString:UICollectionElementKindSectionHeader])
    {
        if(indexPath.section == 0)// 顶部滚动广告
        {
            WJSSPTTypeHeadView *head = [self.collectionV dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"WJSSPTTypeHeadView" forIndexPath:indexPath];
            reusableview = head;
        }
    }
    return reusableview;

}



//定义每个Section的四边间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0,0, 8, 0);//分别为上、左、下、右
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section;
{
    return 4;
}

//两个cell之间的间距（同一行的cell的间距）
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section;
{
    return 1;
}
#pragma mark - head宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return (section == 0) ?  CGSizeMake(kMSScreenWith, 120)  : CGSizeZero;
}


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _arr_newsData.count;

}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
     return CGSizeMake(kMSScreenWith/2-2, 240);

}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{

    WJYZXPListViewCell *cell = [self.collectionV dequeueReusableCellWithReuseIdentifier:@"WJYZXPListViewCell" forIndexPath:indexPath];
    cell.model = _arr_newsData[indexPath.row];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    WJGoodDetailViewController *dcVc = [[WJGoodDetailViewController alloc] init];
    dcVc.goods_id = _arr_newsData[indexPath.row].goods_id;
    dcVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:dcVc animated:YES];
}
//- (void)didSelectedButtonWithTag:(NSInteger)currTag
//{
//
//}

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
