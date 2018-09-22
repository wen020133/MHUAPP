//
//  WJProductsRecommendedViewController.m
//  MHUAPP
//
//  Created by wenchengjun on 2018/9/18.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import "WJProductsRecommendedViewController.h"
#import "WJYZXPListViewCell.h"
#import "WJSSPTTypeHeadView.h"
#import "WJJRPTItem.h"
#import "MJRefresh.h"
#import "WJGoodDetailViewController.h"


@interface WJProductsRecommendedViewController ()<UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource>
@property (strong, nonatomic) UICollectionView *collectionV;

@property (strong, nonatomic) NSMutableArray <WJJRPTItem *> *arr_JPData;
@property NSInteger page_Information;


@end

@implementation WJProductsRecommendedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSendReplyWithTitle:@"精品推荐" andLeftButtonName:@"ic_back.png" andRightButtonName:nil andTitleLeftOrRight:YES];
    self.view.backgroundColor = [RegularExpressionsMethod ColorWithHexString:kMSVCBackgroundColor];
    //    self.arr_HotSellType = [NSArray arrayWithObjects:@"全部",@"电吹风机",@"直卷发器",@"洗发定型",@"染发烫发",@"染发烫发",@"染发烫发", nil];
    //    [self addhotsellControlView];
    _arr_JPData = [NSMutableArray array];
    [self.view addSubview:self.collectionV];
    // Do any additional setup after loading the view.
}
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
    [self requestGetAPIWithServe:[NSString stringWithFormat:@"%@/%@/%@?id=%ld",kMSBaseMiYoMeiPortURL,kMSappVersionCode,kMSGetReputation,_page_Information]];
}
-(void)getProcessData
{
    
    [_collectionV.mj_header endRefreshing];
    [_collectionV.mj_footer endRefreshing];
    if([[self.results objectForKey:@"code"] integerValue] == 200)
    {
        
        NSArray *arr_Datalist = [self.results objectForKey:@"data"] ;
        NSMutableArray *entities = [NSMutableArray array];
        if (arr_Datalist&&arr_Datalist.count>0) {
            
            entities = [WJJRPTItem mj_objectArrayWithKeyValuesArray:arr_Datalist];
            
            if(_page_Information==1)
            {
                _arr_JPData= entities;
            }else
            {
                [_arr_JPData addObjectsFromArray:entities];
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
    return _arr_JPData.count;
    
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(kMSScreenWith/2-2, 240);
    
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    WJYZXPListViewCell *cell = [self.collectionV dequeueReusableCellWithReuseIdentifier:@"WJYZXPListViewCell" forIndexPath:indexPath];
    cell.model = _arr_JPData[indexPath.row];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    WJGoodDetailViewController *dcVc = [[WJGoodDetailViewController alloc] init];
    dcVc.goods_id = _arr_JPData[indexPath.row].goods_id;
    dcVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:dcVc animated:YES];
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
