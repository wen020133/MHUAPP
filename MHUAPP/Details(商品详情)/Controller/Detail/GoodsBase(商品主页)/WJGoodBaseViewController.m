//
//  WJGoodBaseViewController.m
//  MHUAPP
//
//  Created by jinri on 2017/12/4.
//  Copyright © 2017年 wenchengjun. All rights reserved.
//

#import "WJGoodBaseViewController.h"
#import "UIView+UIViewFrame.h"
#import "WJDetailShufflingHeadView.h"
//#import "WJDeatilCustomHeadView.h"
#import "WJDetailPartCommentHeadView.h"

#import "WJDetailGoodReferralCell.h"
#import "WJShowTypeCouponCell.h"
#import "WJShowTypeGoodsPropertyCell.h"
//#import "WJShowTypeAddressCell.h"
#import "WJShowTypeFreightCell.h"
#import "WJDetailPartCommentCell.h"
#import "WJFeatureSelectionViewController.h"
#import "WJDetailOverFooterView.h"

#import "XWDrawerAnimator.h"
#import "UIViewController+XWTransition.h"

#import <SVProgressHUD.h>
#import "DCLIRLButton.h"
#import <MJRefresh.h>


@interface WJGoodBaseViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) UIScrollView *scrollerView;
@property (strong, nonatomic) UICollectionView *collectionView;

//省市县
@property (strong , nonatomic) NSArray *arr_siteList;
/* 滚回顶部按钮 */
@property (strong , nonatomic)UIButton *backTopButton;
/* 通知 */
@property (weak ,nonatomic) id dcObj;

@end

static NSString *lastNum_;
static NSArray *lastSeleArray_;

@implementation WJGoodBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpInit];

    [self setUpViewScroller];

    [self setUpSuspendView];


    [self acceptanceNote];

    [self.view addSubview:_scrollerView];
    // Do any additional setup after loading the view.
}
#pragma mark - LazyLoad
- (UIScrollView *)scrollerView
{
    if (!_scrollerView) {
        _scrollerView = [[UIScrollView alloc] initWithFrame:CGRectZero];
        _scrollerView.frame = self.view.bounds;
        _scrollerView.contentSize = CGSizeMake(kMSScreenWith, (kMSScreenHeight - 50) * 2);
        _scrollerView.pagingEnabled = YES;
        _scrollerView.scrollEnabled = NO;

    }
    return _scrollerView;
}

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.minimumLineSpacing = 0; //Y
        layout.minimumInteritemSpacing = 0; //X
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.frame = CGRectMake(0, 0, kMSScreenWith, kMSScreenHeight  - 50);
        _collectionView.showsVerticalScrollIndicator = NO;
        [self.scrollerView addSubview:_collectionView];

        //注册header
        [_collectionView registerClass:[WJDetailShufflingHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"WJDetailShufflingHeadView"];
        [_collectionView registerClass:[WJDetailPartCommentHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"WJDetailPartCommentHeadView"];

        //注册Cell
        [_collectionView registerClass:[WJDetailGoodReferralCell class] forCellWithReuseIdentifier:@"WJDetailGoodReferralCell"];
        [_collectionView registerClass:[WJShowTypeCouponCell class] forCellWithReuseIdentifier:@"WJShowTypeCouponCell"];
        [_collectionView registerClass:[WJShowTypeGoodsPropertyCell class] forCellWithReuseIdentifier:@"WJShowTypeGoodsPropertyCell"];
//        [_collectionView registerClass:[WJShowTypeAddressCell class] forCellWithReuseIdentifier:@"WJShowTypeAddressCell"];
        [_collectionView registerClass:[WJShowTypeFreightCell class] forCellWithReuseIdentifier:@"WJShowTypeFreightCell"];
        [_collectionView registerClass:[WJDetailPartCommentCell class] forCellWithReuseIdentifier:@"WJDetailPartCommentCell"];

        //注册Footer
        [_collectionView registerClass:[WJDetailOverFooterView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"WJDetailOverFooterView"];

        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"UICollectionElementKindSectionFooter"]; //间隔

    }
    return _collectionView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - initialize
- (void)setUpInit
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [RegularExpressionsMethod ColorWithHexString:kMSVCBackgroundColor];
    self.collectionView.backgroundColor = self.view.backgroundColor;
    self.scrollerView.backgroundColor = self.view.backgroundColor;
    //初始化
    lastSeleArray_ = [NSArray array];
    lastNum_ = 0;
}
#pragma mark - 接受通知
- (void)acceptanceNote
{
    //分享通知
    WEAKSELF
    _dcObj = [[NSNotificationCenter defaultCenter]addObserverForName:@"shareAlterView" object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        [weakSelf selfAlterViewback];
//        [weakSelf setUpAlterViewControllerWith:[DCShareToViewController new] WithDistance:300 WithDirection:XWDrawerAnimatorDirectionBottom WithParallaxEnable:NO WithFlipEnable:NO];
    }];


    //父类加入购物车，立即购买通知
    _dcObj = [[NSNotificationCenter defaultCenter]addObserverForName:@"ClikAddOrBuy" object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {

        if (lastSeleArray_.count != 0) {
            if ([note.userInfo[@"buttonTag"] isEqualToString:@"2"]) { //加入购物车（父类）

                [weakSelf setUpWithAddSuccess];

            }else if ([note.userInfo[@"buttonTag"] isEqualToString:@"3"]){//立即购买（父类）

//                DCFillinOrderViewController *dcFillVc = [DCFillinOrderViewController new];
//                [weakSelf.navigationController pushViewController:dcFillVc animated:YES];
            }

        }else {
            WJFeatureSelectionViewController *dcFeaVc = [WJFeatureSelectionViewController new];
            dcFeaVc.lastNum = lastNum_;
            dcFeaVc.lastSeleArray = [NSMutableArray arrayWithArray:lastSeleArray_];
            dcFeaVc.arr_fuckData = self.attributeArray;
            dcFeaVc.goodImageView = _goodImageView;
            [self setUpAlterViewControllerWith:dcFeaVc WithDistance:kMSScreenHeight * 0.8 WithDirection:XWDrawerAnimatorDirectionBottom WithParallaxEnable:YES WithFlipEnable:YES];
        }
    }];

    //选择Item通知
    _dcObj = [[NSNotificationCenter defaultCenter]addObserverForName:@"itemSelectBack" object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {

        NSArray *selectArray = note.userInfo[@"Array"];
        NSString *num = note.userInfo[@"Num"];
        NSString *buttonTag = note.userInfo[@"Tag"];

        lastNum_ = num;
        lastSeleArray_ = selectArray;

        [weakSelf.collectionView reloadData];

        if ([buttonTag isEqualToString:@"0"]) { //加入购物车

            [weakSelf setUpWithAddSuccess];

        }else if ([buttonTag isEqualToString:@"1"]) { //立即购买

//            DCFillinOrderViewController *dcFillVc = [DCFillinOrderViewController new];
//            [weakSelf.navigationController pushViewController:dcFillVc animated:YES];
        }

    }];
}
#pragma mark - 悬浮按钮
- (void)setUpSuspendView
{
    _backTopButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:_backTopButton];
    [_backTopButton addTarget:self action:@selector(ScrollToTop) forControlEvents:UIControlEventTouchUpInside];
    [_backTopButton setImage:[UIImage imageNamed:@"btn_UpToTop"] forState:UIControlStateNormal];
    _backTopButton.hidden = YES;
    _backTopButton.frame = CGRectMake(kMSScreenWith - 50, kMSScreenHeight - 100, 40, 40);
}



#pragma mark - 转场动画弹出控制器
- (void)setUpAlterViewControllerWith:(UIViewController *)vc WithDistance:(CGFloat)distance WithDirection:(XWDrawerAnimatorDirection)vcDirection WithParallaxEnable:(BOOL)parallaxEnable WithFlipEnable:(BOOL)flipEnable
{
    [self dismissViewControllerAnimated:YES completion:nil]; //以防有控制未退出
    XWDrawerAnimatorDirection direction = vcDirection;
    XWDrawerAnimator *animator = [XWDrawerAnimator xw_animatorWithDirection:direction moveDistance:distance];
    animator.parallaxEnable = parallaxEnable;
    animator.flipEnable = flipEnable;
    [self xw_presentViewController:vc withAnimator:animator];
    WEAKSELF
    [animator xw_enableEdgeGestureAndBackTapWithConfig:^{
        [weakSelf selfAlterViewback];
    }];
}
#pragma mark - <UICollectionViewDataSource>
- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 3;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return (section == 0 || section == 2) ? 2 : 1;
}

#pragma mark - <UICollectionViewDelegate>
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *gridcell = nil;
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            WJDetailGoodReferralCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WJDetailGoodReferralCell" forIndexPath:indexPath];
            cell.goodTitle = self.goodTitle;
            cell.goodPrice = self.goodPrice;
            cell.oldPrice = self.oldPrice;
            [cell assignmentAllLabel];
            gridcell = cell;
        }else if (indexPath.row == 1){
            WJShowTypeCouponCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WJShowTypeCouponCell" forIndexPath:indexPath];

            gridcell = cell;
        }

    }else if (indexPath.section == 1 ){
            WJShowTypeGoodsPropertyCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WJShowTypeGoodsPropertyCell" forIndexPath:indexPath];

            NSString *result = [NSString stringWithFormat:@"%@ %@件",[lastSeleArray_ componentsJoinedByString:@"，"],lastNum_];

            cell.leftTitleLable.text =  @"规格选择";
            cell.contentLabel.text = (lastSeleArray_.count == 0) ? @"请选择该商品属性" : result;

            gridcell = cell;

//            if (indexPath.row == 0) {
//                WJShowTypeAddressCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WJShowTypeAddressCell" forIndexPath:indexPath];
//                NSString *address;
//                if (self.str_provinceName.length>1) {
//                    address= [NSString stringWithFormat:@"%@ %@ %@",self.str_provinceName,self.str_cityName,self.str_district];
//                }
//                else
//                {
//                    address = @"请选择收货地址";
//                }
//
//                cell.contentLabel.text = address; //地址
//                gridcell = cell;
//            }else{
//             if (indexPath.row == 0)
//             {
//                WJShowTypeFreightCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WJShowTypeFreightCell" forIndexPath:indexPath];
//                gridcell = cell;
//            }
        }
    else if (indexPath.section == 2){
        WJDetailPartCommentCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WJDetailPartCommentCell" forIndexPath:indexPath];
        gridcell = cell;
    }

    return gridcell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {

    UICollectionReusableView *reusableview = nil;
    if (kind == UICollectionElementKindSectionHeader){
        if (indexPath.section == 0) {
            WJDetailShufflingHeadView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"WJDetailShufflingHeadView" forIndexPath:indexPath];
            headerView.shufflingArray = _shufflingArray;
            reusableview = headerView;
        }
        else if (indexPath.section == 2){
            WJDetailPartCommentHeadView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"WJDetailPartCommentHeadView" forIndexPath:indexPath];
            reusableview = headerView;
        }
    }else if (kind == UICollectionElementKindSectionFooter){
        if (indexPath.section == 2) {
            WJDetailOverFooterView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"WJDetailOverFooterView" forIndexPath:indexPath];
            reusableview = footerView;
        }else{
            UICollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"UICollectionElementKindSectionFooter" forIndexPath:indexPath];
            footerView.backgroundColor = self.view.backgroundColor;
            reusableview = footerView;
        }
    }
    return reusableview;

    ;
}

#pragma mark - item宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) { //商品详情
        return (indexPath.row == 0) ? CGSizeMake(kMSScreenWith, [RegularExpressionsMethod dc_calculateTextSizeWithText:_goodTitle WithTextFont:16 WithMaxW:kMSScreenWith - DCMargin * 2].height + 40) : CGSizeMake(kMSScreenWith, 35);
    }else if (indexPath.section == 1){//商品属性选择
        return CGSizeMake(kMSScreenWith, 60);
    }
//    else if (indexPath.section == 2){//商品快递信息
//        return CGSizeMake(kMSScreenWith, 60);
//    }
//     else if (indexPath.section == 3){//商品保价
//        return CGSizeMake(kMSScreenWith / 2, 60);
//    }
    else if (indexPath.section == 2){//商品评价部分展示
        return CGSizeMake(kMSScreenWith, 80);
    }
//    else if (indexPath.section == 3){//商品猜你喜欢
//        return CGSizeMake(kMSScreenWith, (kMSScreenWith / 3 + 60) * 2 + 20);
//    }
    else{
        return CGSizeZero;
    }
}


#pragma mark - head宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return (section == 0) ?  CGSizeMake(kMSScreenWith, kMSScreenWith * 0.55) : ( section == 2) ? CGSizeMake(kMSScreenWith, 40) : CGSizeZero;
}

#pragma mark - foot宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return (section == 2) ? CGSizeMake(kMSScreenWith, 35) : CGSizeMake(kMSScreenWith, DCMargin);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 0) {
        [self scrollToDetailsPage]; //滚动到详情页面
    }
//    else if (indexPath.section == 2 && indexPath.row == 0) {
//        [self chageUserAdress]; //跟换地址
//    }
    else if (indexPath.section == 1){ //属性选择
        WJFeatureSelectionViewController *dcFeaVc = [WJFeatureSelectionViewController new];
        dcFeaVc.lastNum = lastNum_;
        dcFeaVc.lastSeleArray = [NSMutableArray arrayWithArray:lastSeleArray_];
        dcFeaVc.arr_fuckData = self.attributeArray;
        dcFeaVc.goodImageView = _goodImageView;
        [self setUpAlterViewControllerWith:dcFeaVc WithDistance:kMSScreenHeight * 0.8 WithDirection:XWDrawerAnimatorDirectionBottom WithParallaxEnable:YES WithFlipEnable:YES];
    }
}

- (void)chageUserAdress
{
    _pickerView = [[WJMYPickerView alloc]initWithFrame:CGRectMake(0, 0, kMSScreenWith, kMSScreenHeight)];
    _pickerView.delegate = self;
    [_pickerView initView];
    _pickerView.allProvinces = self.arr_siteList;
    [[UIApplication sharedApplication].keyWindow addSubview:self.pickerView];

}




-(void) selectPickerViewRow:(NSString *)province provinceID:(NSString *)provinceID city:(NSString *)city cityID:(NSString *)cityID area:(NSString *)area areaID:(NSString *)areaID
{
    self.str_provinceName = province;
    self.str_provinceId = provinceID;
    self.str_cityName = city;
    self.str_cityId = cityID;
    self.str_district = area;
    self.str_districtId = areaID;
    NSLog(@"%@ %@ %@",province,city,area);
    [self.collectionView reloadData];
}

#pragma mark - 滚动到详情页面
- (void)scrollToDetailsPage
{
    dispatch_sync(dispatch_get_global_queue(0, 0), ^{
        [[NSNotificationCenter defaultCenter]postNotificationName:@"scrollToDetailsPage" object:nil];
    });
}

#pragma mark - collectionView滚回顶部
- (void)ScrollToTop
{
    if (self.scrollerView.contentOffset.y > kMSScreenHeight) {
        [self.collectionView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
    }else{
        WEAKSELF
        [UIView animateWithDuration:0.5 animations:^{
            weakSelf.scrollerView.contentOffset = CGPointMake(0, 0);
        } completion:^(BOOL finished) {
            [weakSelf.collectionView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
        }];
    }
    !_changeTitleBlock ? : _changeTitleBlock(NO);
}
#pragma mark - 视图滚动
- (void)setUpViewScroller{
    WEAKSELF
    self.collectionView.mj_footer = [MJRefreshBackFooter footerWithRefreshingBlock:^{
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
            !weakSelf.changeTitleBlock ? : weakSelf.changeTitleBlock(YES);
//            weakSelf.scrollerView.contentOffset = CGPointMake(0, kMSScreenHeight);
        } completion:^(BOOL finished) {
            [weakSelf.collectionView.mj_footer endRefreshing];
        }];
    }];
}

#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //判断回到顶部按钮是否隐藏
    _backTopButton.hidden = (scrollView.contentOffset.y > kMSScreenHeight) ? NO : YES;
}
#pragma mark - 加入购物车成功
- (void)setUpWithAddSuccess
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *uid = [[userDefaults objectForKey:@"userList"] objectForKey:@"uid" ];


     NSString *result = [NSString stringWithFormat:@"%@",[lastSeleArray_ componentsJoinedByString:@"，"]];

    NSMutableDictionary *infos = [NSMutableDictionary dictionary];
    [infos setObject:uid forKey:@"user_id"];
    [infos setObject:self.goods_id forKey:@"goods_id"];
     [infos setObject:self.goodPrice forKey:@"price"];
     [infos setObject:lastNum_ forKey:@"num"];
     [infos setObject:result forKey:@"norms"];
     [infos setObject:self.supplier_id forKey:@"supplier_id"];
    [self requestAPIWithServe:[kMSBaseLargeCollectionPortURL stringByAppendingString:kMSPostCart] andInfos:infos];

}
-(void)processData
{
    if([[self.results objectForKey:@"code"] integerValue] == 200)
    {
        [SVProgressHUD showSuccessWithStatus:@"加入购物车成功~"];
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        [SVProgressHUD dismissWithDelay:1.0];

    }
    else
    {
       [SVProgressHUD showErrorWithStatus:[self.results objectForKey:@"msg"]];
        return;
    }
}
#pragma 退出界面
- (void)selfAlterViewback
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:_dcObj];
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
