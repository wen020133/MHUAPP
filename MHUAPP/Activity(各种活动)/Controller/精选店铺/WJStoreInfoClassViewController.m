//
//  WJStoreInfoClassViewController.m
//  MHUAPP
//
//  Created by wenchengjun on 2018/5/13.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import "WJStoreInfoClassViewController.h"
#import "WJStoreHeadCollectionView.h"
#import "WJStoreInfoCollectionCell.h"
#import "WJGoodsDataModel.h"
#import "UIImageView+WebCache.h"
#import "WJGoodDetailViewController.h"


@interface WJStoreInfoClassViewController ()

@property (strong, nonatomic)  UICollectionView *collectionV;
@property NSInteger serviceType;
@property (strong, nonatomic) NSArray <WJGoodsDataModel *>  *goodsImageArr;
@property (strong ,nonatomic) NSString *str_addGoodsNum;

@end

@implementation WJStoreInfoClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSendReplyWithTitle:@"精选店铺" andLeftButtonName:@"ic_back.png" andRightButtonName:nil andTitleLeftOrRight:YES];
    self.view.backgroundColor = [RegularExpressionsMethod ColorWithHexString:kMSVCBackgroundColor];
    [self.view addSubview:self.collectionV];
    [self getStreetCategory];
    _str_addGoodsNum = @"0";
    // Do any additional setup after loading the view.
}
-(void)getStreetCategory
{
    _serviceType = 1;
    [self requestGetAPIWithServe:[NSString stringWithFormat:@"%@/%@/%@?id=%@",kMSBaseMiYoMeiPortURL,kMSappVersionCode,kMSGetSupplierNum,_storeId]];
}

-(void)addServiceListData
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *uid = [[userDefaults objectForKey:@"userList"] objectForKey:@"uid" ];
    _serviceType = 2;
    [self requestGetAPIWithServe:[NSString stringWithFormat:@"%@/%@/%@?id=%@&user_id=%@",kMSBaseMiYoMeiPortURL,kMSappVersionCode,kMSGetBestSeller,_storeId,uid]];
}
-(void)getProcessData
{
    if([[self.results objectForKey:@"code"] integerValue] == 200)
    {
        if (_serviceType ==1) {
            _str_addGoodsNum = [self.results objectForKey:@"data"];
            [self addServiceListData];
        }
        else
        {
            id arr = [[self.results objectForKey:@"data"] objectForKey:@"goods_list"];
            if([arr isKindOfClass:[NSArray class]])
            {
                self.goodsImageArr =   [WJGoodsDataModel mj_objectArrayWithKeyValuesArray:arr];
                [self.collectionV reloadData];
            }
            self.is_attention = [self.results objectForKey:@"is_attention"];
            
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
        [_collectionV registerClass:[WJStoreHeadCollectionView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"WJStoreHeadCollectionView"];
        [_collectionV registerClass:[WJStoreInfoCollectionCell class] forCellWithReuseIdentifier:@"WJStoreInfoCollectionCell"];
    }
    return _collectionV;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;

    if([kind isEqualToString:UICollectionElementKindSectionHeader])
    {
        WJStoreHeadCollectionView *head = [self.collectionV dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"WJStoreHeadCollectionView" forIndexPath:indexPath];
        head.lab_allGood.text = [NSString stringWithFormat:@"%@",_str_addGoodsNum];
        head.titleLabel.text = _storeName;
        if([self.is_attention integerValue]==1)
        {
            [head.btnSeeAll setBackgroundImage:[UIImage imageNamed:@"commit_star"] forState:UIControlStateNormal];
            [SVProgressHUD showSuccessWithStatus:@"该店铺已收藏"];
            [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
            [SVProgressHUD dismissWithDelay:1.0];
        }
        else
        {
            [head.btnSeeAll setBackgroundImage:[UIImage imageNamed:@"jxdp_shoucang"] forState:UIControlStateNormal];
            head.goToTuijianGoodBlock = ^{
                [self initgetFollowData];
            };
        }
        
        [head.headImageView sd_setImageWithURL:[NSURL URLWithString:_storeLogo] placeholderImage:[UIImage imageNamed:@"ic_no_heardPic.png"]];
        
        reusableview = head;
    }
    return reusableview;

}
-(void)initgetFollowData
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *uid = [[userDefaults objectForKey:@"userList"] objectForKey:@"uid" ];
    NSMutableDictionary *infos = [NSMutableDictionary dictionary];
    [infos setValue:uid forKey:@"user_id"];
    [infos setValue:_storeId forKey:@"id"];
    [self requestAPIWithServe:[kMSBaseMiYoMeiPortURL stringByAppendingString:kMSGetFollow] andInfos:infos];
}
-(void)processData
{
    if([[self.results objectForKey:@"code"] integerValue] == 200)
    {
        [SVProgressHUD showSuccessWithStatus:@"收藏成功"];
            [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
            [SVProgressHUD dismissWithDelay:1.0];
        self.is_attention = @"1";

    }
    else
    {
        NSLog(@"加入足迹---%@！",self.results[@"data"]);

        [SVProgressHUD showSuccessWithStatus:self.results[@"data"]];
            [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
            [SVProgressHUD dismissWithDelay:1.0];

        return;
    }
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
#pragma mark - head宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return  CGSizeMake(kMSScreenWith, 220);
}

#pragma mark - foot宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeZero;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _goodsImageArr.count;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
   return CGSizeMake(kMSScreenWith/2-1, 200);
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    WJStoreInfoCollectionCell *cell = [self.collectionV dequeueReusableCellWithReuseIdentifier:@"WJStoreInfoCollectionCell" forIndexPath:indexPath];
    cell.item = _goodsImageArr[indexPath.row];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    WJGoodDetailViewController *dcVc = [[WJGoodDetailViewController alloc] init];
    dcVc.goods_id = _goodsImageArr[indexPath.row].goods_id;
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
