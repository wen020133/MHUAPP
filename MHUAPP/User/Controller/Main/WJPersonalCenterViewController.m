//
//  WJPersonalCenterViewController.m
//  MHUAPP
//
//  Created by wenchengjun on 2017/11/28.
//  Copyright © 2017年 wenchengjun. All rights reserved.
//

#import "WJPersonalCenterViewController.h"
#import "WJUserHeadAndOrderView.h"
#import "WJFlowAttributeCell.h"
#import "WJUserMainTabelCell.h"
#import "WJFlowItem.h"

#import "WJUserSettingMainViewController.h"

@interface WJPersonalCenterViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

/* collection */
@property (strong , nonatomic)UICollectionView *collectionView;
/* 购买流程属性 */
@property (strong , nonatomic)NSMutableArray<WJFlowItem *> *buyFlowItem;
/* 娱乐属性 */
@property (strong , nonatomic)NSMutableArray<WJFlowItem *> *recreationFlowItem;
/* table属性 */
@property (strong , nonatomic)NSMutableArray<WJFlowItem *> *tableFlowItem;
@end

@implementation WJPersonalCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [RegularExpressionsMethod ColorWithHexString:kMSVCBackgroundColor];
     [self initSendReplyWithTitle:@"个人中心" andLeftButtonName:nil andRightButtonName:@"user_set.png" andTitleLeftOrRight:YES];
    self.collectionView.backgroundColor = self.view.backgroundColor;
    self.automaticallyAdjustsScrollViewInsets = NO;
     [self setUpData];
    [self.view addSubview:_collectionView];


    // Do any additional setup after loading the view.
}
-(void)showright
{
    WJUserSettingMainViewController *userSettingVC = [[WJUserSettingMainViewController alloc]init];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:userSettingVC animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}
#pragma mark - LazyLoad
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
        _collectionView.frame = CGRectMake(0, 0, kMSScreenWith, kMSScreenHeight - kMSNaviHight -49);
         _collectionView.alwaysBounceVertical = YES;
        //头部
          [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([WJUserHeadAndOrderView class]) bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"WJUserHeadAndOrderView"];
        //cell
        [_collectionView registerClass:[WJFlowAttributeCell class] forCellWithReuseIdentifier:@"WJFlowAttributeCell"];
        [_collectionView registerClass:[WJUserMainTabelCell class] forCellWithReuseIdentifier:@"WJUserMainTabelCell"];
        //尾部
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"UICollectionReusableView"]; //分割线

    }
    return _collectionView;
}

#pragma mark - 加载数据
- (void)setUpData
{
    _buyFlowItem = [WJFlowItem mj_objectArrayWithFilename:@"MyBuyFlow.plist"];
    _recreationFlowItem = [WJFlowItem mj_objectArrayWithFilename:@"UserCommitFlow.plist"];
    _tableFlowItem = [WJFlowItem mj_objectArrayWithFilename:@"UserTableFlow.plist"];
}

#pragma mark - <UICollectionViewDataSource>
- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 3;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
   return (section == 0)  ? 5 : 4;
}
#pragma mark - <UICollectionViewDelegate>
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{

   if (indexPath.section == 2) {
       WJUserMainTabelCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WJUserMainTabelCell" forIndexPath:indexPath];
       cell.flowItem = _tableFlowItem[indexPath.row];
       return cell;
    }
    else
    {
         WJFlowAttributeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WJFlowAttributeCell" forIndexPath:indexPath];
        if (indexPath.section==0) {
            cell.flowItem = _buyFlowItem[indexPath.row];
            return cell;

        }
        else
        {
        cell.flowItem = _recreationFlowItem[indexPath.row];
        return cell;
        }
    }

}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {

    UICollectionReusableView *reusableview = nil;
    if (kind == UICollectionElementKindSectionHeader) {
        if (indexPath.section == 0) {
        WJUserHeadAndOrderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"WJUserHeadAndOrderView" forIndexPath:indexPath];
           return headerView;
    }
        else
        {
            return nil;
        }
    }
    if (kind == UICollectionElementKindSectionFooter) {
        if (indexPath.section == 0 || indexPath.section == 1 || indexPath.section == 2) {
            UICollectionReusableView *footview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"UICollectionReusableView" forIndexPath:indexPath];
            footview.backgroundColor = [RegularExpressionsMethod ColorWithHexString:kMSVCBackgroundColor];
            reusableview = footview;
        }
    }
    return reusableview;
}

#pragma mark - item宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 ) {//属性
        return CGSizeMake(kMSScreenWith/5 , 80);
    }
    if (indexPath.section == 1) {//属性
        return CGSizeMake(kMSScreenWith/4, 80);
    }
    if (indexPath.section == 2) {//猜你喜欢
        return CGSizeMake(kMSScreenWith, 44);
    }
    return CGSizeZero;
}
#pragma mark - head宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {

    return (section == 0) ? CGSizeMake(kMSScreenWith, 200) : CGSizeZero;
}

#pragma mark - foot宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {

    return  CGSizeMake(kMSScreenWith, 10);
}

#pragma mark - X间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return  0;
}
#pragma mark - Y间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return  0;
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
