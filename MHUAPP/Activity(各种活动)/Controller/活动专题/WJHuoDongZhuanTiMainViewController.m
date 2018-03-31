//
//  WJHuoDongZhuanTiMainViewController.m
//  MHUAPP
//
//  Created by jinri on 2018/3/29.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import "WJHuoDongZhuanTiMainViewController.h"
#import <UIImageView+WebCache.h>
#import "UIView+UIViewFrame.h"

#import "WJSSPTTypeHeadView.h"
#import "WJZhuanTiHDGridViewCell.h"
#import "WJZhuanTiHDXinPinCell.h"
#import "WJZhuanTiHDBenZhouZuiLXCell.h"
#import "WJZhuanTiHDTypeCollrctionCell.h"

@interface WJHuoDongZhuanTiMainViewController ()

@property (strong, nonatomic) NSArray *arr_HDType;

@end

@implementation WJHuoDongZhuanTiMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSendReplyWithTitle:@"活动专题" andLeftButtonName:@"ic_back.png" andRightButtonName:nil andTitleLeftOrRight:YES];
    self.view.backgroundColor = [RegularExpressionsMethod ColorWithHexString:kMSVCBackgroundColor];
    [self.view addSubview:self.collectionV];
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
        [_collectionV registerClass:[WJSSPTTypeHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"WJSSPTTypeHeadView"];
        [_collectionV registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"xinpinqiangxiankan"];
        [_collectionV registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"benzhouzuiliuxing"];
        [_collectionV registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"huodongType"];
        [_collectionV registerClass:[WJZhuanTiHDGridViewCell class] forCellWithReuseIdentifier:@"WJZhuanTiHDGridViewCell"];
        [_collectionV registerClass:[WJZhuanTiHDXinPinCell class] forCellWithReuseIdentifier:@"WJZhuanTiHDXinPinCell"];
        [_collectionV registerClass:[WJZhuanTiHDBenZhouZuiLXCell class] forCellWithReuseIdentifier:@"WJZhuanTiHDBenZhouZuiLXCell"];
        [_collectionV registerClass:[WJZhuanTiHDTypeCollrctionCell class] forCellWithReuseIdentifier:@"WJZhuanTiHDTypeCollrctionCell"];
    }
    return _collectionV;
}
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;

    if([kind isEqualToString:UICollectionElementKindSectionHeader])
    {
        if(indexPath.section == 0)
        {
            WJSSPTTypeHeadView *head = [self.collectionV dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"WJSSPTTypeHeadView" forIndexPath:indexPath];
            reusableview = head;
        }


        else if(indexPath.section == 1)
        {
            UICollectionReusableView *common = [self.collectionV dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"xinpinqiangxiankan" forIndexPath:indexPath];
            common.backgroundColor = kMSCellBackColor;

            UILabel *more = LabelInit(kMSScreenWith/2-100, 0, 200, 40);
            more.textColor = [RegularExpressionsMethod ColorWithHexString:BASELITTLEBLACKCOLOR];
            more.text = @"一 新品抢先看 一";
            [common addSubview:more];
            more.font = PFR14Font;

            reusableview = common;
        }
        else if(indexPath.section == 2)
        {
            UICollectionReusableView *common = [self.collectionV dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"xinpinqiangxiankan" forIndexPath:indexPath];
            common.backgroundColor = kMSCellBackColor;

            UILabel *more = LabelInit(kMSScreenWith/2-100, 0, 200, 40);
            more.textColor = [RegularExpressionsMethod ColorWithHexString:BASELITTLEBLACKCOLOR];
            more.text = @"一 本周最流行 一";
            [common addSubview:more];
            more.font = PFR14Font;

            reusableview = common;
        }
        else if(indexPath.section == 3)
        {
            UICollectionReusableView *common = [self.collectionV dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"xinpinqiangxiankan" forIndexPath:indexPath];
            common.backgroundColor = kMSCellBackColor;

            UILabel *more = LabelInit(kMSScreenWith/2-100, 0, 200, 40);
            more.textColor = [RegularExpressionsMethod ColorWithHexString:BASELITTLEBLACKCOLOR];
            more.text = @"一 电吹风机 一";
            [common addSubview:more];
            more.font = PFR14Font;

            reusableview = common;
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
    if (section == 0) {
        return CGSizeMake(kMSScreenWith, 120);
    }
    else
        return CGSizeMake(kMSScreenWith, 40);  //推荐适合的宽高

}


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 4;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 3) {
        return 4;
    }
    else
    {
        return 1;
    }

}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 3)
    {
        return CGSizeMake(kMSScreenWith/2, 260);
    }
    else
    {
        return CGSizeMake(kMSScreenWith, 200);
    }

}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *gridcell = nil;
    if (indexPath.section == 0) {

        WJZhuanTiHDGridViewCell *cell = [self.collectionV dequeueReusableCellWithReuseIdentifier:@"WJZhuanTiHDGridViewCell" forIndexPath:indexPath];

        gridcell = cell;

    }

    else if (indexPath.section == 1)
    {
        WJZhuanTiHDXinPinCell *cell = [self.collectionV dequeueReusableCellWithReuseIdentifier:@"WJZhuanTiHDXinPinCell" forIndexPath:indexPath];
        gridcell = cell;
    }
    else if (indexPath.section == 2)
    {
        WJZhuanTiHDBenZhouZuiLXCell *cell = [self.collectionV dequeueReusableCellWithReuseIdentifier:@"WJZhuanTiHDBenZhouZuiLXCell" forIndexPath:indexPath];
        gridcell = cell;
    }
    else if (indexPath.section == 3)
    {
        WJZhuanTiHDTypeCollrctionCell *cell = [self.collectionV dequeueReusableCellWithReuseIdentifier:@"WJZhuanTiHDTypeCollrctionCell" forIndexPath:indexPath];
        gridcell = cell;
    }
    return gridcell;
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
