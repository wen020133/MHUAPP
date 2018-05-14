//
//  WJStoreInfoClassViewController.m
//  MHUAPP
//
//  Created by wenchengjun on 2018/5/13.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import "WJStoreInfoClassViewController.h"
#import "WJStoreHeadCollectionView.h"
#import "WJHomeRecommendCollectionViewCell.h"

@interface WJStoreInfoClassViewController ()

@property (strong, nonatomic)  UICollectionView *collectionV;
@property (strong, nonatomic)  NSMutableArray *arr_infomationresults;

@end

@implementation WJStoreInfoClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSendReplyWithTitle:@"精选店铺" andLeftButtonName:@"ic_back.png" andRightButtonName:nil andTitleLeftOrRight:YES];
    self.view.backgroundColor = [RegularExpressionsMethod ColorWithHexString:kMSVCBackgroundColor];
    _arr_infomationresults = [NSMutableArray array];
    [self.view addSubview:self.collectionV];
    // Do any additional setup after loading the view.
}
-(UICollectionView *)collectionV
{
    if (!_collectionV) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        _collectionV = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 44, kMSScreenWith, kMSScreenHeight-kMSNaviHight-44) collectionViewLayout:layout];
        
        _collectionV.backgroundColor = [UIColor clearColor];
        _collectionV.delegate = self;
        _collectionV.dataSource = self;
        _collectionV.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        [_collectionV registerClass:[WJStoreHeadCollectionView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"WJStoreHeadCollectionView"];
        [_collectionV registerClass:[WJHomeRecommendCollectionViewCell class] forCellWithReuseIdentifier:@"WJHomeRecommendCollectionViewCell"];
    }
    return _collectionV;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;

    if([kind isEqualToString:UICollectionElementKindSectionHeader])
    {
        WJStoreHeadCollectionView *head = [self.collectionV dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"WJStoreHeadCollectionView" forIndexPath:indexPath];
        reusableview = head;
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
#pragma mark - head宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return  CGSizeMake(kMSScreenWith, 240+kMSScreenWith/2);
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
    return _arr_infomationresults.count;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
   return CGSizeMake(kMSScreenWith/2-1, 200);
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    WJHomeRecommendCollectionViewCell *cell = [self.collectionV dequeueReusableCellWithReuseIdentifier:@"WJHomeRecommendCollectionViewCell" forIndexPath:indexPath];
//    cell.model = _arr_infomationresults[indexPath.row];
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
