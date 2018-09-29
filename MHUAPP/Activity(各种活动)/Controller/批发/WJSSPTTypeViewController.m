//
//  WJSSPTTypeViewController.m
//  MHUAPP
//
//  Created by jinri on 2018/3/27.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import "WJSSPTTypeViewController.h"
#import "WJSSPTTypeHeadView.h"
#import "WJSSPTTypeCollectionViewCell.h"
#import "WJSSPTDetailClassViewController.h"
#import "MJRefresh.h"

@interface WJSSPTTypeViewController ()

@property (strong, nonatomic) NSMutableArray *arr_PTdata;
@property NSInteger page_Information;

@end

@implementation WJSSPTTypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self initSendReplyWithTitle:@"采购批发" andLeftButtonName:@"ic_back.png" andRightButtonName:nil andTitleLeftOrRight:YES];
    self.view.backgroundColor = [RegularExpressionsMethod ColorWithHexString:kMSVCBackgroundColor];
    [self.view addSubview:self.collectionV];
    self.arr_PTdata = [NSMutableArray array];
    _page_Information = 1;
    [self getGetGroupList];
    // Do any additional setup after loading the view.
}

-(void)headerRereshingPifa
{
    _page_Information = 1;
    [self getGetGroupList];
}
-(void)footerRereshingPifa
{
    _page_Information ++;
    [self getGetGroupList];
}

-(void)getGetGroupList
{
    [self requestGetAPIWithServe:[NSString stringWithFormat:@"%@/%@/%@?page=%ld",kMSBaseMiYoMeiPortURL,kMSappVersionCode,kMSGetGroupList,_page_Information]];
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

            entities = [WJJRPTItem mj_objectArrayWithKeyValuesArray:dataArr];

            if(_page_Information==1)
            {
                _arr_PTdata= entities;
            }else
            {
                [_arr_PTdata addObjectsFromArray:entities];
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
    }
    else
    {
        [SVProgressHUD showErrorWithStatus:[self.results objectForKey:@"msg"]];
        return;
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
        [_collectionV registerClass:[WJSSPTTypeCollectionViewCell class] forCellWithReuseIdentifier:@"WJSSPTTypeCollectionViewCell"];
        _collectionV.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRereshingPifa)];
        _collectionV.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRereshingPifa)];
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
    return UIEdgeInsetsMake(0,1, 8, 0);//分别为上、左、下、右
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
    return CGSizeMake(kMSScreenWith, 120);
}


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _arr_PTdata.count;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(kMSScreenWith/2-2, 260);
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    WJSSPTTypeCollectionViewCell *cell = [self.collectionV dequeueReusableCellWithReuseIdentifier:@"WJSSPTTypeCollectionViewCell" forIndexPath:indexPath];
    cell.model = self.arr_PTdata[indexPath.row];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
//    WJSSPTDetailClassViewController *storeInfo = [[WJSSPTDetailClassViewController alloc]init];
//    storeInfo.goods_id = [NSString stringWithFormat:@"%@",[[_arr_PTdata objectAtIndex:indexPath.row] objectForKey:@"goods_id"]];
//    storeInfo.group_numb_one = [NSString stringWithFormat:@"%@",[[_arr_PTdata objectAtIndex:indexPath.row] objectForKey:@"group_numb_one"]];
//    storeInfo.group_numb_two = [NSString stringWithFormat:@"%@",[[_arr_PTdata objectAtIndex:indexPath.row] objectForKey:@"group_numb_two"]];
//    storeInfo.group_numb_three = [NSString stringWithFormat:@"%@",[[_arr_PTdata objectAtIndex:indexPath.row] objectForKey:@"group_numb_three"]];
//    storeInfo.group_price_one = [NSString stringWithFormat:@"%@",[[_arr_PTdata objectAtIndex:indexPath.row] objectForKey:@"group_price_one"]];
//    storeInfo.group_price_two = [NSString stringWithFormat:@"%@",[[_arr_PTdata objectAtIndex:indexPath.row] objectForKey:@"group_price_two"]];
//    storeInfo.group_price_three = [NSString stringWithFormat:@"%@",[[_arr_PTdata objectAtIndex:indexPath.row] objectForKey:@"group_price_three"]];
//    storeInfo.endTimeStr = [[_arr_PTdata objectAtIndex:indexPath.row] objectForKey:@"end_time"];
//    storeInfo.group_info_id = [[_arr_PTdata objectAtIndex:indexPath.row] objectForKey:@"group_info_id"];
//    storeInfo.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:storeInfo animated:YES];
//    self.hidesBottomBarWhenPushed = YES;
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
