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
#import "WJLoginClassViewController.h"
#import "JXTAlertController.h"
#import "WJOrderMainViewController.h"
#import "WJCouponsClassViewController.h"
#import "WJUserCollectionViewController.h"
#import "WJMyStoreViewController.h"

#import "WJMyFootprintViewController.h"
#import "WJMyFollowViewController.h"
#import <UIImageView+WebCache.h>

#import "RCDCustomerServiceViewController.h"

@interface WJPersonalCenterViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

/* collection */
@property (strong , nonatomic)UICollectionView *collectionView;
/* 购买流程属性 */
@property (strong , nonatomic)NSMutableArray<WJFlowItem *> *buyFlowItem;
/* 娱乐属性 */
@property (strong , nonatomic)NSMutableArray<WJFlowItem *> *recreationFlowItem;
/* table属性 */
@property (strong , nonatomic)NSMutableArray<WJFlowItem *> *tableFlowItem;

@property (strong, nonatomic) UIRefreshControl *refreshControl;
@end

@implementation WJPersonalCenterViewController

#pragma mark - LifeCyle
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.collectionView reloadData];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [RegularExpressionsMethod ColorWithHexString:kMSVCBackgroundColor];
    self.collectionView.backgroundColor = self.view.backgroundColor;
    self.automaticallyAdjustsScrollViewInsets = NO;
     [self setUpData];
    [self.view addSubview:_collectionView];

    _refreshControl = [[UIRefreshControl alloc] init];
    [_refreshControl addTarget:self action:@selector(refreshClick:) forControlEvents:UIControlEventValueChanged];
    [self.collectionView addSubview:_refreshControl];
    // Do any additional setup after loading the view.
}

#pragma mark - LazyLoad
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        if (@available(iOS 11.0, *)) {
            self.collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;

        }
        _collectionView.frame = CGRectMake(0, 0, kMSScreenWith, kMSScreenHeight - 49);
         _collectionView.alwaysBounceVertical = YES;
        //头部
        [_collectionView registerClass:[WJUserHeadAndOrderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"WJUserHeadAndOrderView"];
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
    if(section == 0)
        return 5;
    else if(section == 1)
        return 4;
    else if(section == 2)
        return 2;
    return 0;
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

            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            NSLog(@"userlist=%@",[userDefaults objectForKey:@"userList"] );
            NSString *loginState = [userDefaults objectForKey:@"loginState"];
            NSString *str_logo_img = [[userDefaults objectForKey:@"userList"] objectForKey:@"user_icon"];
            NSString *str_username = [[userDefaults objectForKey:@"userList"] objectForKey:@"username"];
            if([loginState isEqualToString:@"1"])
            {
                 [headerView.headImageView sd_setImageWithURL:[NSURL URLWithString:str_logo_img] placeholderImage:[UIImage imageNamed:@"ic_no_heardPic.png"]];


               headerView.userNameLabel.text = str_username;

            }
            else
            {
                [headerView.headImageView setImage:[UIImage imageNamed:@"ic_no_heardPic.png"] ];
                headerView.userNameLabel.text = @"请登录";
            }
            WEAKSELF
            headerView.touchClickBlock = ^{
                [weakSelf changeUserHeard];
            };
            headerView.goToOrderClickBlock  = ^{
                [weakSelf goToOrderVC];
            };
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

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if([AppDelegate shareAppDelegate].user_id.length<1)
    {
        WJLoginClassViewController *loginVC = [[WJLoginClassViewController alloc]init];
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:loginVC animated:YES];
        self.hidesBottomBarWhenPushed = NO;
        return;
    }
     if(indexPath.section==0)
     {
         WJOrderMainViewController *dcVc = [[WJOrderMainViewController alloc] init];
         dcVc.hidesBottomBarWhenPushed = YES;
         dcVc.serverType = indexPath.row+1;
         [self.navigationController pushViewController:dcVc animated:YES];
         self.hidesBottomBarWhenPushed = NO;
     }
    else if (indexPath.section ==1)
    {
        switch (indexPath.row) {
            case 0:
                {
                    [self jxt_showAlertWithTitle:@"消息提示" message:@"活动暂未开放。敬请期待！" appearanceProcess:^(JXTAlertController * _Nonnull alertMaker) {
                        alertMaker.
                        addActionCancelTitle(@"确定");
                    } actionsBlock:^(NSInteger buttonIndex, UIAlertAction * _Nonnull action, JXTAlertController * _Nonnull alertSelf) {
                        if (buttonIndex == 0) {
                            NSLog(@"cancel");
                        }

                        NSLog(@"%@--%@", action.title, action);
                    }];
//                    WJCouponsClassViewController *dcVc = [[WJCouponsClassViewController alloc] init];
//                    self.hidesBottomBarWhenPushed = YES;
//                    [self.navigationController pushViewController:dcVc animated:YES];
//                    self.hidesBottomBarWhenPushed = NO;
                }
                break;
            case 1:
            {
                WJUserCollectionViewController *dcVc = [[WJUserCollectionViewController alloc] init];
                self.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:dcVc animated:YES];
                self.hidesBottomBarWhenPushed = NO;
            }
                break;
            case 2:
            {
                WJMyFollowViewController *dcVc = [[WJMyFollowViewController alloc] init];
                self.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:dcVc animated:YES];
                self.hidesBottomBarWhenPushed = NO;
            }
                break;
            case 3:
            {
                RCDCustomerServiceViewController *chatService = [[RCDCustomerServiceViewController alloc] init];
                chatService.conversationType = ConversationType_CUSTOMERSERVICE;
                chatService.targetId = @"KEFU152176453929981";
                self.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:chatService animated:YES];
                self.hidesBottomBarWhenPushed = NO;
            }
                break;
            default:
                break;
        }

    }
    else if (indexPath.section ==2)
        switch (indexPath.row) {
            case 0:
            {
                [self jxt_showAlertWithTitle:@"消息提示" message:@"系统消息暂未开放" appearanceProcess:^(JXTAlertController * _Nonnull alertMaker) {
                    alertMaker.
                    addActionCancelTitle(@"确定");
                } actionsBlock:^(NSInteger buttonIndex, UIAlertAction * _Nonnull action, JXTAlertController * _Nonnull alertSelf) {
                    if (buttonIndex == 0) {
                        NSLog(@"cancel");
                    }
                    
                    NSLog(@"%@--%@", action.title, action);
                }];
            }
                break;
                case 1:
            {
                WJMyFootprintViewController *dcVc = [[WJMyFootprintViewController alloc] init];
                self.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:dcVc animated:YES];
                self.hidesBottomBarWhenPushed = NO;
            }
                break;
            default:
                break;
        }
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

    return (section == 0) ? CGSizeMake(kMSScreenWith, 240) : CGSizeZero;
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
- (void)setupRefresh {
    NSLog(@"setupRefresh -- 下拉刷新");
    [self refreshClick:_refreshControl];
}
// 下拉刷新触发，在此获取数据
- (void)refreshClick:(UIRefreshControl *)refreshControl {
    NSLog(@"refreshClick: -- 刷新触发");
    [self.collectionView reloadData];
    [refreshControl endRefreshing];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)changeUserHeard
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];

    NSString *loginState = [userDefaults objectForKey:@"loginState"];
    if([loginState isEqualToString:@"1"])
    {
        WJUserSettingMainViewController *userSettingVC = [[WJUserSettingMainViewController alloc]init];
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:userSettingVC animated:YES];
        self.hidesBottomBarWhenPushed = NO;
    }
    else
    {
        WJLoginClassViewController *loginVC = [[WJLoginClassViewController alloc]init];
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:loginVC animated:YES];
        self.hidesBottomBarWhenPushed = NO;

    }
}
-(void)goToOrderVC
{
    if([AppDelegate shareAppDelegate].user_id.length<1)
    {
        WJLoginClassViewController *loginVC = [[WJLoginClassViewController alloc]init];
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:loginVC animated:YES];
        self.hidesBottomBarWhenPushed = NO;
        return;
    }
    NSLog(@"跳转到订单");
    WJOrderMainViewController *dcVc = [[WJOrderMainViewController alloc] init];
    dcVc.hidesBottomBarWhenPushed = YES;
    dcVc.serverType = 0;
    [self.navigationController pushViewController:dcVc animated:YES];
    self.hidesBottomBarWhenPushed = NO;
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
