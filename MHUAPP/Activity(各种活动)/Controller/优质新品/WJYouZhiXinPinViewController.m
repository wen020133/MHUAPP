//
//  WJYouZhiXinPinViewController.m
//  MHUAPP
//
//  Created by jinri on 2018/3/31.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import "WJYouZhiXinPinViewController.h"
#import "WJYouZhiXinPinCouponsCell.h"
#import "WJYZXPListViewCell.h"
#import "WJSSPTTypeHeadView.h"

@interface WJYouZhiXinPinViewController ()

@property (strong, nonatomic) NSArray *arr_HotSellType;

@end

@implementation WJYouZhiXinPinViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSendReplyWithTitle:@"优质新品" andLeftButtonName:@"ic_back.png" andRightButtonName:nil andTitleLeftOrRight:YES];
    self.view.backgroundColor = [RegularExpressionsMethod ColorWithHexString:kMSVCBackgroundColor];
    self.arr_HotSellType = [NSArray arrayWithObjects:@"全部",@"电吹风机",@"直卷发器",@"洗发定型",@"染发烫发",@"染发烫发",@"染发烫发", nil];
    [self addhotsellControlView];

    [self.view addSubview:self.collectionV];
    // Do any additional setup after loading the view.
}
-(void)addhotsellControlView
{
    _menu_newScrollView = [[MenuScrollView alloc]initWithFrame:CGRectMake(0, 0, kMSScreenWith, 44) withTitles:self.arr_HotSellType withScrollViewWidth:kMSScreenWith];
    _menu_newScrollView.delegate = self;
    [self.view addSubview:_menu_newScrollView];
}


-(UICollectionView *)collectionV
{
    if (!_collectionV) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        _collectionV = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 88, kMSScreenWith, kMSScreenHeight-kMSNaviHight-88) collectionViewLayout:layout];

        _collectionV.backgroundColor = [UIColor clearColor];
        _collectionV.delegate = self;
        _collectionV.dataSource = self;
        _collectionV.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        [_collectionV registerClass:[WJSSPTTypeHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"WJSSPTTypeHeadView"];
        [_collectionV registerClass:[WJYouZhiXinPinCouponsCell class] forCellWithReuseIdentifier:@"WJYouZhiXinPinCouponsCell"];
        [_collectionV registerClass:[WJYZXPListViewCell class] forCellWithReuseIdentifier:@"WJYZXPListViewCell"];
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
    return (section == 0) ?  CGSizeMake(kMSScreenWith, 120)  : CGSizeZero;
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
        return CGSizeMake(kMSScreenWith, 100);
    }
    else
    {
        return CGSizeMake(kMSScreenWith, 240);
    }

}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *gridcell = nil;
    if (indexPath.section == 0) {

        WJYouZhiXinPinCouponsCell *cell = [self.collectionV dequeueReusableCellWithReuseIdentifier:@"WJYouZhiXinPinCouponsCell" forIndexPath:indexPath];

        gridcell = cell;

    }

    else
    {
        WJYZXPListViewCell *cell = [self.collectionV dequeueReusableCellWithReuseIdentifier:@"WJYZXPListViewCell" forIndexPath:indexPath];
        gridcell = cell;
    }
    return gridcell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

}
- (void)didSelectedButtonWithTag:(NSInteger)currTag
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
