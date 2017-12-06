//
//  WJGoodBaseViewController.m
//  MHUAPP
//
//  Created by jinri on 2017/12/4.
//  Copyright © 2017年 wenchengjun. All rights reserved.
//

#import "WJGoodBaseViewController.h"

#import "WJDetailShufflingHeadView.h"
#import "WJDeatilCustomHeadView.h"

#import "WJDetailGoodReferralCell.h"
#import "WJShowTypeCouponCell.h"
#import "WJShowTypeGoodsPropertyCell.h"
#import "WJShowTypeAddressCell.h"
#import "WJShowTypeFreightCell.h"
#import "WJDetailPartCommentCell.h"

#import "WJDetailOverFooterView.h"

#import "AddressPickerView.h"
#import "XWDrawerAnimator.h"
#import "UIViewController+XWTransition.h"
#import <WebKit/WebKit.h>
#import <SVProgressHUD.h>
#import "DCLIRLButton.h"
#import <MJRefresh.h>

@interface WJGoodBaseViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,WKNavigationDelegate>

@property (strong, nonatomic) UIScrollView *scrollerView;
@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) WKWebView *webView;
/* 选择地址弹框 */
@property (strong , nonatomic) AddressPickerView *adPickerView;
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

    [self setUpGoodsWKWebView];

    [self setUpSuspendView];


    [self acceptanceNote];
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
        [self.view addSubview:_scrollerView];
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
        [_collectionView registerClass:[WJDeatilCustomHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"WJDeatilCustomHeadView"];

        //注册Cell
        [_collectionView registerClass:[WJDetailGoodReferralCell class] forCellWithReuseIdentifier:@"WJDetailGoodReferralCell"];
        [_collectionView registerClass:[WJShowTypeCouponCell class] forCellWithReuseIdentifier:@"WJShowTypeCouponCell"];
        [_collectionView registerClass:[WJShowTypeGoodsPropertyCell class] forCellWithReuseIdentifier:@"WJShowTypeGoodsPropertyCell"];
        [_collectionView registerClass:[WJShowTypeAddressCell class] forCellWithReuseIdentifier:@"WJShowTypeAddressCell"];
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
- (WKWebView *)webView
{
    if (!_webView) {
        _webView = [[WKWebView alloc] initWithFrame:CGRectZero];
        _webView.frame = CGRectMake(0,kMSScreenHeight , kMSScreenWith, kMSScreenHeight - 50);
        _webView.scrollView.contentInset = UIEdgeInsetsMake(kMSNaviHight, 0, 0, 0);
        _webView.scrollView.scrollIndicatorInsets = _webView.scrollView.contentInset;
        [self.scrollerView addSubview:_webView];
    }
    return _webView;
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

//            DCFeatureSelectionViewController *dcNewFeaVc = [DCFeatureSelectionViewController new];
//            dcNewFeaVc.goodImageView = weakSelf.goodImageView;
//            [weakSelf setUpAlterViewControllerWith:dcNewFeaVc WithDistance:ScreenH * 0.8 WithDirection:XWDrawerAnimatorDirectionBottom WithParallaxEnable:YES WithFlipEnable:YES];
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

#pragma mark - 记载图文详情
- (void)setUpGoodsWKWebView
{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com/"]];
    [self.webView loadRequest:request];

    //下拉返回商品详情View
    UIView *topHitView = [[UIView alloc] init];
    topHitView.frame = CGRectMake(0, -35, kMSScreenWith, 35);
    DCLIRLButton *topHitButton = [DCLIRLButton buttonWithType:UIButtonTypeCustom];
    topHitButton.imageView.transform = CGAffineTransformRotate(topHitButton.imageView.transform, M_PI); //旋转
    [topHitButton setImage:[UIImage imageNamed:@"Details_Btn_Up"] forState:UIControlStateNormal];
    [topHitButton setTitle:@"下拉返回商品详情" forState:UIControlStateNormal];
    topHitButton.titleLabel.font = PFR12Font;
    [topHitButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [topHitView addSubview:topHitButton];
    topHitButton.frame = topHitView.bounds;

    [self.webView.scrollView addSubview:topHitView];
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
    return 4;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return (section == 0 ||section == 2 || section == 3) ? 2 : 1;
}

#pragma mark - <UICollectionViewDelegate>
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *gridcell = nil;
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            WJDetailGoodReferralCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WJDetailGoodReferralCell" forIndexPath:indexPath];
            cell.goodTitleLabel.text = _goodTitle;
            cell.goodPriceLabel.text = [NSString stringWithFormat:@"¥ %@",_goodPrice];
            cell.goodSubtitleLabel.text = _goodSubtitle;
//            [RegularExpressionsMethod dc_setUpLabel:cell.goodTitleLabel Content:_goodTitle IndentationFortheFirstLineWith:cell.goodPriceLabel.font.pointSize * 2];
            gridcell = cell;
        }else if (indexPath.row == 1){
            WJShowTypeCouponCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WJShowTypeCouponCell" forIndexPath:indexPath];

            gridcell = cell;
        }

    }else if (indexPath.section == 1 || indexPath.section == 2 ){
        if (indexPath.section == 1) {
            WJShowTypeGoodsPropertyCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WJShowTypeGoodsPropertyCell" forIndexPath:indexPath];

            NSString *result = [NSString stringWithFormat:@"%@ %@件",[lastSeleArray_ componentsJoinedByString:@"，"],lastNum_];

            cell.leftTitleLable.text = (lastSeleArray_.count == 0) ? @"点击" : @"已选";
            cell.contentLabel.text = (lastSeleArray_.count == 0) ? @"请选择该商品属性" : result;

            gridcell = cell;
        }else{
            if (indexPath.row == 0) {
                WJShowTypeAddressCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WJShowTypeAddressCell" forIndexPath:indexPath];
                cell.contentLabel.text = @"地址"; //地址
                gridcell = cell;
            }else{
                WJShowTypeFreightCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WJShowTypeFreightCell" forIndexPath:indexPath];
                gridcell = cell;
            }
        }
    }else if (indexPath.section == 3){
        WJDetailPartCommentCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WJDetailPartCommentCell" forIndexPath:indexPath];
        cell.backgroundColor = [UIColor orangeColor];
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
        }else if (indexPath.section == 3){
            WJDeatilCustomHeadView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"WJDeatilCustomHeadView" forIndexPath:indexPath];
            reusableview = headerView;
        }
    }else if (kind == UICollectionElementKindSectionFooter){
        if (indexPath.section == 3) {
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
        return (indexPath.row == 0) ? CGSizeMake(kMSScreenWith, [RegularExpressionsMethod dc_calculateTextSizeWithText:_goodTitle WithTextFont:16 WithMaxW:kMSScreenWith - DCMargin * 6].height + [RegularExpressionsMethod dc_calculateTextSizeWithText:_goodPrice WithTextFont:20 WithMaxW:kMSScreenWith - DCMargin * 6].height + [RegularExpressionsMethod dc_calculateTextSizeWithText:_goodSubtitle WithTextFont:12 WithMaxW:kMSScreenWith - DCMargin * 6].height + DCMargin * 4) : CGSizeMake(kMSScreenWith, 35);
    }else if (indexPath.section == 1){//商品属性选择
        return CGSizeMake(kMSScreenWith, 60);
    }else if (indexPath.section == 2){//商品快递信息
        return CGSizeMake(kMSScreenWith, 60);
    }else if (indexPath.section == 3){//商品保价
        return CGSizeMake(kMSScreenWith / 2, 60);
    }else if (indexPath.section == 4){//商品评价部分展示
        return CGSizeMake(kMSScreenWith, 270);
    }else if (indexPath.section == 5){//商品猜你喜欢
        return CGSizeMake(kMSScreenWith, (kMSScreenWith / 3 + 60) * 2 + 20);
    }else{
        return CGSizeZero;
    }
}


#pragma mark - head宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return (section == 0) ?  CGSizeMake(kMSScreenWith, kMSScreenWith * 0.55) : ( section == 5) ? CGSizeMake(kMSScreenWith, 30) : CGSizeZero;
}

#pragma mark - foot宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return (section == 5) ? CGSizeMake(kMSScreenWith, 35) : CGSizeMake(kMSScreenWith, DCMargin);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 0) {
        [self scrollToDetailsPage]; //滚动到详情页面
    }else if (indexPath.section == 2 && indexPath.row == 0) {
        [self chageUserAdress]; //跟换地址
    }else if (indexPath.section == 1){ //属性选择
//        DCFeatureSelectionViewController *dcFeaVc = [DCFeatureSelectionViewController new];
//        dcFeaVc.lastNum = lastNum_;
//        dcFeaVc.lastSeleArray = [NSMutableArray arrayWithArray:lastSeleArray_];
//        dcFeaVc.goodImageView = _goodImageView;
//        [self setUpAlterViewControllerWith:dcFeaVc WithDistance:ScreenH * 0.8 WithDirection:XWDrawerAnimatorDirectionBottom WithParallaxEnable:YES WithFlipEnable:YES];
    }
}

- (void)chageUserAdress
{
    _adPickerView = [AddressPickerView shareInstance];
    [_adPickerView showAddressPickView];
    [self.view addSubview:_adPickerView];

    WEAKSELF
    _adPickerView.block = ^(NSString *province,NSString *city,NSString *district) {
        [weakSelf.collectionView reloadData];
    };
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
            weakSelf.scrollerView.contentOffset = CGPointMake(0, kMSScreenHeight);
        } completion:^(BOOL finished) {
            [weakSelf.collectionView.mj_footer endRefreshing];
        }];
    }];

    self.webView.scrollView.mj_header = [MJRefreshHeader headerWithRefreshingBlock:^{
        [UIView animateWithDuration:0.8 animations:^{
            !weakSelf.changeTitleBlock ? : weakSelf.changeTitleBlock(NO);
            weakSelf.scrollerView.contentOffset = CGPointMake(0, 0);
        } completion:^(BOOL finished) {
            [weakSelf.webView.scrollView.mj_header endRefreshing];
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
    [SVProgressHUD showSuccessWithStatus:@"加入购物车成功~"];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD dismissWithDelay:1.0];
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
