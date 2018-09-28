//
//  WJSSPTFirstViewController.m
//  MHUAPP
//
//  Created by jinri on 2018/3/27.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import "WJSSPTFirstViewController.h"
#import "WJSSPTAllClassHeadView.h"
#import "WJJRBPCollectionCell.h"
#import "WJSSPTMRHHCollectionCell.h"

@interface WJSSPTFirstViewController ()

@end

@implementation WJSSPTFirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.collectionV];
    // Do any additional setup after loading the view.
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
        [_collectionV registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"common"];
        [_collectionV registerClass:[WJJRBPCollectionCell class] forCellWithReuseIdentifier:@"WJJRBPCollectionCell"];
         [_collectionV registerClass:[WJSSPTMRHHCollectionCell class] forCellWithReuseIdentifier:@"WJSSPTMRHHCollectionCell"];
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
            WJSSPTAllClassHeadView *head = [self.collectionV dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"WJSSPTAllClassHeadView" forIndexPath:indexPath];
            reusableview = head;
        }

       
        else
        {
            UICollectionReusableView *common = [self.collectionV dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"common" forIndexPath:indexPath];
            common.backgroundColor = kMSCellBackColor;

            UILabel *more = LabelInit(kMSScreenWith/2-40, 0, 80, 40);
            more.textColor = [RegularExpressionsMethod ColorWithHexString:BASELITTLEBLACKCOLOR];
            more.text = @"每日好货";
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
        return CGSizeMake(kMSScreenWith, 164);
    }
    else
        return CGSizeMake(kMSScreenWith, 40);  //推荐适合的宽高

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
    {
        return 2;
    }

}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        return CGSizeMake(kMSScreenWith, 200);
    }
    else
    {
        return CGSizeMake(kMSScreenWith, 110);
    }

}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *gridcell = nil;
    if (indexPath.section == 0) {

        WJJRBPCollectionCell *cell = [self.collectionV dequeueReusableCellWithReuseIdentifier:@"WJJRBPCollectionCell" forIndexPath:indexPath];

        gridcell = cell;

    }

    else
    {
        WJSSPTMRHHCollectionCell *cell = [self.collectionV dequeueReusableCellWithReuseIdentifier:@"WJSSPTMRHHCollectionCell" forIndexPath:indexPath];
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
