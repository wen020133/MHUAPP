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

-(void)viewWillAppear:(BOOL)animated
{
    [self.collectionView reloadData];
    [super viewWillAppear:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [RegularExpressionsMethod ColorWithHexString:kMSVCBackgroundColor];
     [self initSendReplyWithTitle:@"个人中心" andLeftButtonName:nil andRightButtonName:@"user_set.png" andTitleLeftOrRight:YES];
    self.collectionView.backgroundColor = self.view.backgroundColor;
    self.automaticallyAdjustsScrollViewInsets = NO;
     [self setUpData];
    [self.view addSubview:_collectionView];

    _refreshControl = [[UIRefreshControl alloc] init];
    [_refreshControl addTarget:self action:@selector(refreshClick:) forControlEvents:UIControlEventValueChanged];
    [self.collectionView addSubview:_refreshControl];
    // Do any additional setup after loading the view.
}
-(void)showright
{
    WJUserSettingMainViewController *userSettingVC = [[WJUserSettingMainViewController alloc]init];
    userSettingVC.str_name = @"userName";
    userSettingVC.str_profile = @"用户简介";
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

            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            NSLog(@"userlist=%@",[userDefaults objectForKey:@"userList"] );
            NSString *loginState = [userDefaults objectForKey:@"loginState"];
            NSString *str_logo_img = [[userDefaults objectForKey:@"userList"] objectForKey:@"user_icon"];
            NSString *str_nickname = [[userDefaults objectForKey:@"userList"] objectForKey:@"nickname"];
            NSString *str_username = [[userDefaults objectForKey:@"userList"] objectForKey:@"username"];
            if([loginState isEqualToString:@"1"])
            {
                if (str_logo_img&&str_logo_img.length>10) {
                    //以便在block中使用
                    __block UIImage *image = [[UIImage alloc] init];
                    //图片下载链接
                    NSURL *imageDownloadURL = [NSURL URLWithString:str_logo_img];

                    //将图片下载在异步线程进行
                    //创建异步线程执行队列
                    dispatch_queue_t asynchronousQueue = dispatch_queue_create("imageDownloadQueue", NULL);
                    //创建异步线程
                    dispatch_async(asynchronousQueue, ^{
                        //网络下载图片  NSData格式
                        NSError *error;
                        NSData *imageData = [NSData dataWithContentsOfURL:imageDownloadURL options:NSDataReadingMappedIfSafe error:&error];
                        if (imageData) {
                            image = [UIImage imageWithData:imageData];
                        }
                        //回到主线程更新UI
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [headerView.headImageView setImage:image];

                        });
                    });
                }
                else
                {
                    [headerView.headImageView setImage:[UIImage imageNamed:@"ic_no_heardPic.png"]];
                }


               headerView.userNameLabel.text = str_username;
                if (str_nickname.length>0) {

                    headerView.profileLabel.text = str_nickname;
                }
                else
                {
                     headerView.profileLabel.text = @"";
                }
            }
            else
            {
                [headerView.headImageView setImage:[UIImage imageNamed:@"ic_no_heardPic.png"] ];
                headerView.userNameLabel.text = @"请登录";
                headerView.profileLabel.text = @"";
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
- (void)setupRefresh {
    NSLog(@"setupRefresh -- 下拉刷新");
    [self refreshClick:_refreshControl];
}
// 下拉刷新触发，在此获取数据
- (void)refreshClick:(UIRefreshControl *)refreshControl {
    NSLog(@"refreshClick: -- 刷新触发");
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
        [self jxt_showActionSheetWithTitle:@"选择图片" message:@"" appearanceProcess:^(JXTAlertController * _Nonnull alertMaker) {
            alertMaker.
            addActionCancelTitle(@"取消").
            addActionDestructiveTitle(@"相册选取").
            addActionDefaultTitle(@"拍照");
        } actionsBlock:^(NSInteger buttonIndex, UIAlertAction * _Nonnull action, JXTAlertController * _Nonnull alertSelf) {

            if ([action.title isEqualToString:@"取消"]) {
                NSLog(@"cancel");
            }
            else if ([action.title isEqualToString:@"相册选取"]) {
                if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
                {
                    NSUInteger sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    UIImagePickerController *picker=[[UIImagePickerController alloc] init];
                    picker.delegate=self;
                    picker.allowsEditing=NO;
                    sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    picker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
                    [self presentViewController:picker animated:YES completion:^{}];
                }
                else
                {
                    [SVProgressHUD showErrorWithStatus:@"请在设置-隐私-照片对APP授权"];
                }
            }
            else if ([action.title isEqualToString:@"拍照"]) {
                NSLog(@"拍照");
                UIImagePickerController *picker=[[UIImagePickerController alloc] init];
                picker.delegate=self;
                picker.allowsEditing=NO;
                NSUInteger sourceType = UIImagePickerControllerSourceTypeCamera;
                // 判断是否支持相机
                if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
                {
                    sourceType = UIImagePickerControllerSourceTypeCamera;
                    picker.sourceType=UIImagePickerControllerSourceTypeCamera;
                    [self presentViewController:picker animated:YES completion:^{}];
                }
                else
                {
                    [SVProgressHUD showErrorWithStatus:@"请在设置-隐私-照片对APP授权"];
                }
            }

        }];

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
    NSLog(@"跳转到订单");
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
