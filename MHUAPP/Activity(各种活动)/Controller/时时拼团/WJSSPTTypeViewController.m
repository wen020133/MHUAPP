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


@interface WJSSPTTypeViewController ()

@end

@implementation WJSSPTTypeViewController

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
        [_collectionV registerClass:[WJSSPTTypeHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"WJSSPTTypeHeadView"];
        [_collectionV registerClass:[WJSSPTTypeCollectionViewCell class] forCellWithReuseIdentifier:@"WJSSPTTypeCollectionViewCell"];
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
    return 4;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(kMSScreenWith/2-2, 240);
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    WJSSPTTypeCollectionViewCell *cell = [self.collectionV dequeueReusableCellWithReuseIdentifier:@"WJSSPTTypeCollectionViewCell" forIndexPath:indexPath];


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
