//
//  WJHotSellingViewController.m
//  MHUAPP
//
//  Created by jinri on 2018/3/31.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import "WJHotSellingViewController.h"
//#import "WJSegmentedInUpDownView.h"
#import "WJSSPTTypeHeadView.h"
#import "WJHotSellCollectionViewCell.h"
#import "WJGoodDetailViewController.h"
#import "WJJRPTItem.h"


@interface WJHotSellingViewController ()<UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource>

//@property (strong, nonatomic) NSArray *arr_HotSellType;

@property (strong, nonatomic) NSMutableArray <WJJRPTItem *> *arr_hotSellData;


@end

@implementation WJHotSellingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSendReplyWithTitle:@"热卖商品" andLeftButtonName:@"ic_back.png" andRightButtonName:nil andTitleLeftOrRight:YES];
    self.view.backgroundColor = [RegularExpressionsMethod ColorWithHexString:kMSVCBackgroundColor];
//    self.arr_HotSellType = [NSArray arrayWithObjects:@"全部",@"电吹风机",@"直卷发器",@"洗发定型",@"染发烫发",@"染发烫发",@"染发烫发", nil];
//    [self addhotsellControlView];
    [self initinfomationClassData];
    [self.view addSubview:self.collectionV];
    // Do any additional setup after loading the view.
}

-(void)initinfomationClassData
{
    NSMutableDictionary *infos = [NSMutableDictionary dictionary];
    [self requestAPIWithServe:[kMSBaseLargeCollectionPortURL stringByAppendingString:kMSGetGoodsGetHotList] andInfos:infos];
}

-(void)processData
{
    if([[self.results objectForKey:@"code"] integerValue] == 200)
    {

        NSMutableArray *arr_Datalist = [NSMutableArray array];
        arr_Datalist = [self.results objectForKey:@"data"];
        NSMutableArray *entities = [NSMutableArray array];
        if (arr_Datalist&&arr_Datalist.count>0) {

            entities = [WJJRPTItem mj_objectArrayWithKeyValuesArray:arr_Datalist];
            _arr_hotSellData =entities;
            [_collectionV reloadData];

        }

    }
    else
    {
        [self requestFailed:@"获取数据失败"];
    }
}
//-(void)addhotsellControlView
//{
//    _menu_HotSellScrollView = [[MenuScrollView alloc]initWithFrame:CGRectMake(0, 0, kMSScreenWith, 44) withTitles:self.arr_HotSellType withScrollViewWidth:kMSScreenWith];
//    _menu_HotSellScrollView.delegate = self;
//    [self.view addSubview:_menu_HotSellScrollView];
//
//    WJSegmentedInUpDownView *segmentV = [[WJSegmentedInUpDownView alloc]initWithFrame:CGRectMake(0, 44, kMSScreenWith, 44)];
//    segmentV.selectAction = ^(NSInteger typeID) {
//
//    };
//    [self.view addSubview:segmentV];
//}


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
        [_collectionV registerClass:[WJHotSellCollectionViewCell class] forCellWithReuseIdentifier:@"WJHotSellCollectionViewCell"];
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



-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{

    return CGSizeMake(kMSScreenWith, 120);

}


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _arr_hotSellData.count;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section;
{
    return 1;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(kMSScreenWith, 120);
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
        WJHotSellCollectionViewCell *cell = [self.collectionV dequeueReusableCellWithReuseIdentifier:@"WJHotSellCollectionViewCell" forIndexPath:indexPath];
    cell.model = _arr_hotSellData[indexPath.row];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    WJGoodDetailViewController *dcVc = [[WJGoodDetailViewController alloc] init];
    dcVc.goods_id = _arr_hotSellData[indexPath.row].goods_id;
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
