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



@interface WJMyFenxiaoViewController ()<UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource>

@property (strong, nonatomic) UICollectionView *collectionV;
@property NSInteger page_Information;
@property (strong, nonatomic)  NSMutableArray  <WJDetailListFenxiao *>*arr_infoResults;

@property (strong, nonatomic) NOMoreDataView *noMoreView;

@end

@implementation WJMyFenxiaoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [RegularExpressionsMethod ColorWithHexString:kMSVCBackgroundColor];
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
        // 下拉刷新
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
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.arr_infoResults.count+1;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section;
{
    return 1;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(kMSScreenWith, 44);
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    WJMyFenXiaoOrderItemCell *cell = [self.collectionV dequeueReusableCellWithReuseIdentifier:@"WJMyFenXiaoOrderItemCell" forIndexPath:indexPath];
    if (indexPath.row>0) {
        cell.model = self.arr_infoResults[indexPath.row-1];
    }
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
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
