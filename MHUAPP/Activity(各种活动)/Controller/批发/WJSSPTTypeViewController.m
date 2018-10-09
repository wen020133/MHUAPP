//
//  WJSSPTTypeViewController.m
//  MHUAPP
//
//  Created by jinri on 2018/3/27.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import "WJSSPTTypeViewController.h"
#import "WJSSPTMRHHCollectionCell.h"
#import "WJSSPTDetailClassViewController.h"
#import "MJRefresh.h"
#import "NOMoreDataView.h"
#import "WJJRPTItem.h"

@interface WJSSPTTypeViewController ()

@property (strong, nonatomic) NSMutableArray <WJJRPTItem *> *arr_PTdata;
@property NSInteger page_Information;

@property (strong, nonatomic) NSString *str_keywords;
@property (strong, nonatomic) NOMoreDataView *noMoreView;
@end

@implementation WJSSPTTypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self initSendReplyWithTitle:@"采购批发" andLeftButtonName:@"ic_back.png" andRightButtonName:nil andTitleLeftOrRight:YES];
    self.view.backgroundColor = [RegularExpressionsMethod ColorWithHexString:kMSVCBackgroundColor];
    [self.view addSubview:self.collectionV];
    self.arr_PTdata = [NSMutableArray array];
    _page_Information = 1;
    _str_keywords = @"";
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
    [self requestGetAPIWithServe:[NSString stringWithFormat:@"%@/%@/%@?cat_id=%@&page=%ld&keywords=%@",kMSBaseMiYoMeiPortURL,kMSappVersionCode,kMSGetGroupList,self.str_catId,_page_Information,self.str_keywords]];
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
       else
       {
           [self.noMoreView hide];
           self.noMoreView = [[NOMoreDataView alloc]initWithFrame:CGRectMake(0, 44, kMSScreenWith, 80) withContent:@"暂无数据." withNODataImage:@"noMore_bg.png"];
           [_collectionV addSubview:self.noMoreView];
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
        [_collectionV registerClass:[WJSSPTMRHHCollectionCell class] forCellWithReuseIdentifier:@"WJSSPTMRHHCollectionCell"];
        _collectionV.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRereshingPifa)];
        _collectionV.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRereshingPifa)];
    }
    return _collectionV;
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



-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.arr_PTdata.count;
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
    cell.model = self.arr_PTdata[indexPath.row];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    WJSSPTDetailClassViewController *storeInfo = [[WJSSPTDetailClassViewController alloc]init];
    storeInfo.goods_id = [NSString stringWithFormat:@"%@",self.arr_PTdata[indexPath.row].goods_id];
//    storeInfo.group_numb_one = self.arr_PTdata[indexPath.row].offer_numb_one;
//    storeInfo.group_numb_two = self.arr_PTdata[indexPath.row].offer_numb_two;
//    storeInfo.group_numb_three = self.arr_PTdata[indexPath.row].offer_numb_three;
//    storeInfo.group_price_one = self.arr_PTdata[indexPath.row].offer_price_one;
//    storeInfo.group_price_two = self.arr_PTdata[indexPath.row].offer_price_two;
//    storeInfo.group_price_three = self.arr_PTdata[indexPath.row].offer_price_three;
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
