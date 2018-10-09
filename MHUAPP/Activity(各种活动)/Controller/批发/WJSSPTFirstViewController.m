//
//  WJSSPTFirstViewController.m
//  MHUAPP
//
//  Created by jinri on 2018/3/27.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import "WJSSPTFirstViewController.h"
#import "WJSSPTAllClassHeadView.h"
#import "WJSSPTMRHHCollectionCell.h"
#import "MJRefresh.h"
#import "NOMoreDataView.h"
#import "WJJRPTItem.h"
#import "WJSSPTDetailClassViewController.h"

@interface WJSSPTFirstViewController ()

@property (strong, nonatomic) NSMutableArray <WJJRPTItem *> *arr_PTHomeList;
@property NSInteger page_Information;
@property (strong, nonatomic) NSString *str_keywords;

@property (strong, nonatomic) NOMoreDataView *noMoreView;

@end

@implementation WJSSPTFirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [RegularExpressionsMethod ColorWithHexString:kMSVCBackgroundColor];
    _page_Information = 1;
    _str_keywords = @"";
    self.arr_PTHomeList = [NSMutableArray array];
    [self getGetGroupListHome];
    [self.view addSubview:self.collectionV];
    // Do any additional setup after loading the view.
}

-(void)getGetGroupListHome
{

    NSString *encodedString =[RegularExpressionsMethod encodeString:self.str_keywords];
    [self requestGetAPIWithServe:[NSString stringWithFormat:@"%@/%@/%@?cat_id=%@&page=%ld&keywords=%@",kMSBaseMiYoMeiPortURL,kMSappVersionCode,kMSGetGroupList,self.str_catId,_page_Information,encodedString]];
}
-(void)headerRereshingGrouphome
{
    _page_Information = 1;
    [self getGetGroupListHome];
}
-(void)footerRereshingGrouphome
{
    _page_Information ++;
    [self getGetGroupListHome];
}
-(UICollectionView *)collectionV
{
    if (!_collectionV) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        _collectionV = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kMSScreenWith, kMSScreenHeight-kMSNaviHight-44) collectionViewLayout:layout];

        _collectionV.backgroundColor = [UIColor clearColor];
        _collectionV.delegate = self;
        _collectionV.dataSource = self;
        _collectionV.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        [_collectionV registerClass:[WJSSPTAllClassHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"WJSSPTAllClassHeadView"];
         [_collectionV registerClass:[WJSSPTMRHHCollectionCell class] forCellWithReuseIdentifier:@"WJSSPTMRHHCollectionCell"];
        _collectionV.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRereshingGrouphome)];
        _collectionV.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRereshingGrouphome)];
         _collectionV.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    }
    return _collectionV;
}
-(void)getProcessData
{
    [_collectionV.mj_header endRefreshing];
    [_collectionV.mj_footer endRefreshing];

    if([[self.results objectForKey:@"code"] integerValue] == 200)
    {
        NSArray *dataArr = [self.results objectForKey:@"data"];
        NSMutableArray *entities = [NSMutableArray array];
        if (dataArr&&dataArr.count>0) {
            [self.noMoreView hide];
            entities = [WJJRPTItem mj_objectArrayWithKeyValuesArray:dataArr];

            if(_page_Information==1)
            {
                [_arr_PTHomeList removeAllObjects];
                _arr_PTHomeList= entities;
            }else
            {
                [_arr_PTHomeList addObjectsFromArray:entities];
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
            self.noMoreView = [[NOMoreDataView alloc]initWithFrame:CGRectMake(0, 200, kMSScreenWith, 80) withContent:@"暂无数据." withNODataImage:@"noMore_bg.png"];
            [_collectionV addSubview:self.noMoreView];
            [_arr_PTHomeList removeAllObjects];
            [_collectionV reloadData];
        }
    }
    else
    {
        [SVProgressHUD showErrorWithStatus:[self.results objectForKey:@"msg"]];
        return;
    }
}
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;

    if([kind isEqualToString:UICollectionElementKindSectionHeader])
    {
        if(indexPath.section == 0)// 顶部滚动广告
        {
            WJSSPTAllClassHeadView *head = [self.collectionV dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"WJSSPTAllClassHeadView" forIndexPath:indexPath];
            WEAKSELF
            head.userChickSearch = ^(NSString *searchText) {
                _page_Information = 1;
                weakSelf.str_keywords = searchText;
                [weakSelf getGetGroupListHome];
            };
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
    return 2;
}

//两个cell之间的间距（同一行的cell的间距）
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section;
{
    return 2;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
//    if (section == 0) {
        return CGSizeMake(kMSScreenWith, 164);
//    }
//    else
//        return CGSizeMake(kMSScreenWith, 40);  //推荐适合的宽高

}


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.arr_PTHomeList.count;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
//    if (indexPath.section == 0)
//    {
//        return CGSizeMake(kMSScreenWith, 200);
//    }
//    else
//    {
        return CGSizeMake(kMSScreenWith, 110);
//    }

}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    WJSSPTMRHHCollectionCell *cell = [self.collectionV dequeueReusableCellWithReuseIdentifier:@"WJSSPTMRHHCollectionCell" forIndexPath:indexPath];
    cell.model = self.arr_PTHomeList[indexPath.row];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    WJSSPTDetailClassViewController *storeInfo = [[WJSSPTDetailClassViewController alloc]init];
    storeInfo.goods_id = [NSString stringWithFormat:@"%@",self.arr_PTHomeList[indexPath.row].goods_id];
    storeInfo.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:storeInfo animated:YES];
    self.hidesBottomBarWhenPushed = YES;
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
