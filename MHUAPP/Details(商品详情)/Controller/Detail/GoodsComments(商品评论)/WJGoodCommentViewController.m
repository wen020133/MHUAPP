//
//  WJGoodCommentViewController.m
//  MHUAPP
//
//  Created by jinri on 2017/12/4.
//  Copyright © 2017年 wenchengjun. All rights reserved.
//

#import "WJGoodCommentViewController.h"
#import "MJRefresh.h"

#import "WJDetailPartCommentCell.h"
#import "WJDetailPartCommentItem.h"


@interface WJGoodCommentViewController ()
/* 商品评论 */
@property (strong , nonatomic)NSArray<WJDetailPartCommentItem *> *getCommentArray;
@end

@implementation WJGoodCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [RegularExpressionsMethod ColorWithHexString:kMSVCBackgroundColor];
    
    self.page_Information=0;
    [self.view addSubview:self.collectionV];
    [self getinfomationRefresh];
    // Do any additional setup after loading the view.
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
        [_collectionV registerClass:[WJDetailPartCommentCell class] forCellWithReuseIdentifier:@"WJDetailPartCommentCell"];
    }
    return _collectionV;
}

- (void)getinfomationRefresh
{

    // 下拉刷新
    self.collectionV.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRereshingCircle)];
    [self.collectionV.mj_header beginRefreshing];
    // 上拉刷新
    self.collectionV.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRereshingCircle)];

}
-(void)headerRereshingCircle
{
    [self.collectionV.mj_header endRefreshing];
    [self.collectionV.mj_footer endRefreshing];
    _page_Information = 0;
    [self initinfomationClassDataCount];
}

-(void)footerRereshingCircle
{
    _page_Information +=10;
    [self initinfomationClassDataCount];
}

-(void)initinfomationClassDataCount
{
    [self requestGetAPIWithServe:[NSString stringWithFormat:@"%@/%@/%@/%@?start=%ld&numb=%@",kMSBaseMiYoMeiPortURL,kMSappVersionCode,kMSGetComment,_goods_id,_page_Information,kMSPULLtableViewCellNumber]];
}

-(void)getProcessData
{
    [self.collectionV.mj_header endRefreshing];
    [self.collectionV.mj_footer endRefreshing];
    if([[self.results objectForKey:@"code"] integerValue] == 200)
    {
        NSMutableArray *arr_Datalist = [NSMutableArray array];
        arr_Datalist = [self.results objectForKey:@"data"];
        if (![arr_Datalist isEqual:[NSNull null]]) {
            _getCommentArray = [WJDetailPartCommentItem mj_objectArrayWithKeyValuesArray:arr_Datalist];
        }
        [_collectionV reloadData];
    }

    else
    {
        [SVProgressHUD showErrorWithStatus:[self.results objectForKey:@"msg"]];
        return;
    }
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _getCommentArray.count;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(kMSScreenWith, 80);

}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{

    WJDetailPartCommentCell *cell = [self.collectionV dequeueReusableCellWithReuseIdentifier:@"WJDetailPartCommentCell" forIndexPath:indexPath];
    cell.model = _getCommentArray[indexPath.row];
    return cell;
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
