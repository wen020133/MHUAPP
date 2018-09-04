//
//  WJMyFenxiaoViewController.m
//  MHUAPP
//
//  Created by wenchengjun on 2018/7/27.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import "WJMyFenxiaoViewController.h"
#import "WJMyFenXiaoOrderItemCell.h"
#import "NOMoreDataView.h"
#import <MJRefresh.h>
#import "WJDetailListFenxiao.h"
#import "WJMyFootPrintHeadView.h"
#import "WJBrandsSortHeadView.h"

@interface WJMyFenxiaoViewController ()<UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource>

@property (strong, nonatomic) UICollectionView *collectionV;
@property NSInteger page_Information;
@property (strong, nonatomic)  NSMutableArray  <WJDetailListFenxiao *>*arr_infoResults;
@property (strong, nonatomic) NSMutableArray *arr_collListTitle;
@property (strong, nonatomic) NOMoreDataView *noMoreView;

@end

@implementation WJMyFenxiaoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [RegularExpressionsMethod ColorWithHexString:kMSVCBackgroundColor];
    self.arr_collListTitle = [NSMutableArray arrayWithObjects:@"分销规则",@"分销明细", nil];
    [self.view addSubview:self.collectionV];
    // Do any additional setup after loading the view.
}
-(UICollectionView *)collectionV
{
    if (!_collectionV) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        _collectionV = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 5, kMSScreenWith, kMSScreenHeight-kMSNaviHight-5) collectionViewLayout:layout];
        
        _collectionV.backgroundColor = [UIColor clearColor];
        _collectionV.delegate = self;
        _collectionV.dataSource = self;
        _collectionV.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        [_collectionV registerClass:[WJMyFenXiaoOrderItemCell class] forCellWithReuseIdentifier:@"WJMyFenXiaoOrderItemCell"];
        //注册时用UICollectionViewCell
        [_collectionV registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        // 下拉刷新
        //注册Header
        [_collectionV registerClass:[WJBrandsSortHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"WJBrandsSortHeadView"];
        _collectionV.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRereshingCircle)];
        [_collectionV.mj_header beginRefreshing];
        // 上拉刷新
        _collectionV.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerGoodsSetRereshingCircle)];
    }
    return _collectionV;
}
-(void)getMoneyManData
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *uid = [[userDefaults objectForKey:@"userList"] objectForKey:@"uid" ];
    [self requestGetAPIWithServe:[NSString stringWithFormat:@"%@/%@/%@?id=%ld&user_id=%@",kMSBaseMiYoMeiPortURL,kMSappVersionCode,kMSDetailList,_page_Information,uid]];
}
-(void)headerRereshingCircle
{
    _page_Information = 1;
    [self getMoneyManData];
}
-(void)footerGoodsSetRereshingCircle
{
    _page_Information ++;
    [self getMoneyManData];
}
-(void)getProcessData
{
    [_collectionV.mj_header endRefreshing];
    [_collectionV.mj_footer endRefreshing];
    if([[self.results objectForKey:@"code"] integerValue] == 200)
    {
        
        NSArray *arr_Datalist = [NSArray array];
        arr_Datalist = [self.results objectForKey:@"data"];
            NSMutableArray *entities = [NSMutableArray array];
            if (![arr_Datalist isKindOfClass:[NSNull class]]&&arr_Datalist.count>0) {
                 [self.noMoreView hide];
             entities = [WJDetailListFenxiao mj_objectArrayWithKeyValuesArray:arr_Datalist];
                if(_page_Information==1)
                {
                    [self.arr_infoResults removeAllObjects];
                    self.arr_infoResults = entities;
                }else
                {
                    [self.arr_infoResults addObjectsFromArray:entities];
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
                
                [self.noMoreView hide];
                self.noMoreView = [[NOMoreDataView alloc]initWithFrame:CGRectMake(0, 44, kMSScreenWith, 80) withContent:@"暂无记录." withNODataImage:@"noMore_bg.png"];
                [self.collectionV addSubview:self.noMoreView];
            }
        }
     else
{
    [SVProgressHUD showErrorWithStatus:[self.results objectForKey:@"data"]];
    return;
}
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    else
    return self.arr_infoResults.count+1;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section;
{
    return 1;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        NSString *stringCon= @"1.访问者点击某推荐人的分销商品链接后，下单，认为是该推荐人的所介绍的 \n2.指定商品的佣金作为分成金额\n3.所获得的佣金满100元可提现";
        float height = [RegularExpressionsMethod contentCellHeightWithText:stringCon font:Font(14) width:kMSScreenWith-20];
        return CGSizeMake(kMSScreenWith, height+15);
    }
    return CGSizeMake(kMSScreenWith, 44);
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        UICollectionViewCell *cell = [self.collectionV dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
        cell.backgroundColor = kMSCellBackColor;
        NSString *stringCon= @"1.访问者点击某推荐人的分销商品链接后，下单，认为是该推荐人的所介绍的 \n2.指定商品的佣金作为分成金额  \n3.所获得的佣金满100元可提现";
        float height = [RegularExpressionsMethod contentCellHeightWithText:stringCon font:Font(14) width:kMSScreenWith-20];
        UILabel *label = LabelInit(DCMargin, 5, kMSScreenWith-20, height+5);
        label.font = Font(14);
        label.text = stringCon;
        label.numberOfLines = 0;
        label.textColor = [RegularExpressionsMethod ColorWithHexString:BASELITTLEBLACKCOLOR];
        [cell addSubview:label];
        return cell;
    }
    else
    {
    WJMyFenXiaoOrderItemCell *cell = [self.collectionV dequeueReusableCellWithReuseIdentifier:@"WJMyFenXiaoOrderItemCell" forIndexPath:indexPath];
    if (indexPath.row==0) {
        cell.lab_orderNo.text = @"订单号";
        cell.lab_yongjin.text = @"分销佣金";
        cell.lab_name.text = @"购买会员";
        cell.lab_orderState.text = @"分成状态";
        
    }
        else
        {
            cell.model = self.arr_infoResults[indexPath.row-1];
        }
    return cell;
    }
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    WJBrandsSortHeadView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"WJBrandsSortHeadView" forIndexPath:indexPath];
    headerView.headLabel.text = self.arr_collListTitle[indexPath.section];
    headerView.headLabel.font = Font(17);
    return headerView;
}

#pragma mark - head宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(kMSScreenWith, 40);
}

#pragma mark - foot宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeZero;
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
