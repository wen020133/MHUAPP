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
#import "WJHongBaoIntroductionCell.h"
#import "WJDetailPartCommentCell.h"
#import "WJFeatureSelectionViewController.h"
#import "WJDetailOverFooterView.h"
#import "WJLoginClassViewController.h"

#import "XWDrawerAnimator.h"
#import "UIViewController+XWTransition.h"
#import <MJRefresh.h>
#import <SVProgressHUD.h>
#import "DCLIRLButton.h"
#import <WebKit/WebKit.h>

#import "WJWirteOrderClassViewController.h"


@interface WJGoodBaseViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) UIScrollView *scrollerView;
@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) WKWebView *webView;

/* 滚回顶部按钮 */
@property (strong , nonatomic) UIButton *backTopButton;
/* 通知 */
@property (weak ,nonatomic) id dcObj;

@property NSInteger PostCount;
@end

static NSString *lastNum_;
static NSArray *lastSeleArray_;
static NSArray *lastSeleIDArray_;


@implementation WJGoodBaseViewController

- (void)viewDidLoad {

    [super viewDidLoad];

    [self setUpInit];
    [self setUpGoodsWKWebView];
    [self setUpSuspendView];
    [self setUpViewScroller];
   
    lastNum_ = @"1";
    [self acceptanceNote];
    [self getGoodsDescData];
//    self.is_use_bonus = @"1";
//    self.bonus_tips = @"sadkdhklasdhsaldaskjdhsajhdjkashdkashdkashdha;flkakshakjh";

    // Do any additional setup after loading the view.
}
-(void)getGoodsDescData
{
     _PostCount =0;
    [self requestGetAPIWithServe:[NSString stringWithFormat:@"%@/%@/%@?id=%@",kMSBaseMiYoMeiPortURL,kMSappVersionCode,kMSGetGoodsDesc,self.goods_id]];
}

-(void)toGetGoodNum
{
    _PostCount = 1;
    [self requestGetAPIWithServe:[NSString stringWithFormat:@"%@/%@/%@?id=%@",kMSBaseMiYoMeiPortURL,kMSappVersionCode,kMSMiYoMeiGetNum,_goods_id]];
}

-(void)getProcessData
{
    if([[self.results objectForKey:@"code"] integerValue] == 200)
    {
        if (self.PostCount==0) {
            NSString *goods_desc = [[self.results objectForKey:@"data"] objectForKey:@"goods_desc"];
            
            NSString *str1 = [RegularExpressionsMethod htmlEntityDecode:goods_desc];
            [_webView loadHTMLString:str1 baseURL:nil];
            [self toGetGoodNum];
        }
        else
        {
          _soldNum = [self.results objectForKey:@"data"];
          [_collectionView reloadData];
        }
    }
    else
    {
//        [SVProgressHUD showErrorWithStatus:[self.results objectForKey:@"data"]];
        return;
    }
}

#pragma mark - LifeCyle
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
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
        _collectionView.frame = CGRectMake(0, 0, kMSScreenWith, kMSScreenHeight  - 50-kMSNaviHight);
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
         [_collectionView registerClass:[WJHongBaoIntroductionCell class] forCellWithReuseIdentifier:@"WJHongBaoIntroductionCell"];

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
    }];

    //父类加入购物车，立即购买通知
    _dcObj = [[NSNotificationCenter defaultCenter]addObserverForName:@"ClikAddOrBuy" object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {

            if ([note.userInfo[@"buttonTag"] isEqualToString:@"3"]) { //加入购物车（父类）

                [weakSelf isSelectAlretOrGetData:100];

            }else if ([note.userInfo[@"buttonTag"] isEqualToString:@"4"]){//立即购买（父类）
               [weakSelf isSelectAlretOrGetData:3000];
            }
    }];

    //选择Item通知
    _dcObj = [[NSNotificationCenter defaultCenter]addObserverForName:@"itemSelectBack" object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {

        NSArray *selectArray = note.userInfo[@"Array"];
         NSArray *selectIDArray = note.userInfo[@"ArrayID"];
        NSString *num = note.userInfo[@"Num"];
        NSString *buttonTag = note.userInfo[@"Tag"];

        lastNum_ = num;
        lastSeleArray_ = selectArray;
        lastSeleIDArray_ = selectIDArray;
        [weakSelf.collectionView reloadData];

        if ([buttonTag isEqualToString:@"0"]) { //加入购物车

            [weakSelf isSelectAlretOrGetData:100];

        }else if ([buttonTag isEqualToString:@"1"]) { //立即购买
            [weakSelf isSelectAlretOrGetData:3000];
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
//    [self dismissViewControllerAnimated:YES completion:nil]; //以防有控制未退出
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
    int kk = 2;
    if (_commentArray&&_commentArray.count>0) {
        kk++;
    }
//    else if (_attributeArray&&_attributeArray.count>0)
//    {
//        kk++;
//    }
    return kk;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 3;
            break;
        case 1:
        {
//          if(_attributeArray&&_attributeArray.count>0)
//          {
             return 1;
//          }
//            else
//            {
//                if (_commentArray.count>1) {
//                    return 2;
//                }
//                else
//                    return 1;
//            }
        }
            break;
            case 2:
        {
            if (_commentArray.count>1) {
                return 2;
            }
            else
                return 1;
        }
            break;
        default:
            return 0;
            break;
    }
}

#pragma mark - <UICollectionViewDelegate>
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *gridcell = nil;
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            WJDetailGoodReferralCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WJDetailGoodReferralCell" forIndexPath:indexPath];
            cell.goodTitle = _goodTitle;
            cell.goodPrice = _goodPrice;
            cell.oldPrice = _oldPrice;
            cell.soldNum = _soldNum;
            [cell assignmentAllLabel];
            gridcell = cell;
        }else if (indexPath.row == 1){
            WJShowTypeCouponCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WJShowTypeCouponCell" forIndexPath:indexPath];

            gridcell = cell;
        }
        else
        {
            WJHongBaoIntroductionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WJHongBaoIntroductionCell" forIndexPath:indexPath];
            cell.str_bonus_tips = _bonus_tips;
            gridcell = cell;
        }

    }
   else if (indexPath.section == 1)
   {
       if(_attributeArray.count>0){
            WJShowTypeGoodsPropertyCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WJShowTypeGoodsPropertyCell" forIndexPath:indexPath];

            NSString *result = [NSString stringWithFormat:@"%@ %@件",[lastSeleArray_ componentsJoinedByString:@"，"],lastNum_];

            cell.leftTitleLable.text =  @"商品属性";

            cell.contentLabel.text = (lastSeleArray_.count == 0) ? @"请选择该商品属性" : result;

           return cell;

        }
       else
       {
           WJShowTypeGoodsPropertyCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WJShowTypeGoodsPropertyCell" forIndexPath:indexPath];

           NSString *result = [NSString stringWithFormat:@"%@件",lastNum_];

           cell.leftTitleLable.text =  @"商品数量";
           cell.contentLabel.text = (lastNum_.length <1) ? @"请选择该商品数量" : result;
           return cell;

       }
//       else if (_commentArray.count>0){
//           WJDetailPartCommentCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WJDetailPartCommentCell" forIndexPath:indexPath];
//           cell.model = _commentArray[indexPath.row];
//           return cell;
//       }
//       else {
//
//           return gridcell;
//       }
   }
    else if (indexPath.section == 2){
        WJDetailPartCommentCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WJDetailPartCommentCell" forIndexPath:indexPath];
        cell.model = _commentArray[indexPath.row];
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
       else if (indexPath.section == 1) {
//         if(_attributeArray.count<1&&_commentArray.count>0){
//                 WJDetailPartCommentHeadView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"WJDetailPartCommentHeadView" forIndexPath:indexPath];
//             headerView.moreClickBlock = ^{
//                 dispatch_sync(dispatch_get_global_queue(0, 0), ^{
//                     [[NSNotificationCenter defaultCenter]postNotificationName:@"scrollToCommentsPage" object:nil];
//                 });
//             };
//                 reusableview = headerView;
//            }

        }
        else if (indexPath.section == 2){
            WJDetailPartCommentHeadView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"WJDetailPartCommentHeadView" forIndexPath:indexPath];
            headerView.moreClickBlock = ^{
                dispatch_sync(dispatch_get_global_queue(0, 0), ^{
                    [[NSNotificationCenter defaultCenter]postNotificationName:@"scrollToCommentsPage" object:nil];
                });
            };
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
}

#pragma mark - item宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) { //商品详情
        if (indexPath.row == 0)
            return  CGSizeMake(kMSScreenWith, [RegularExpressionsMethod dc_calculateTextSizeWithText:_goodTitle WithTextFont:16 WithMaxW:kMSScreenWith - DCMargin * 2].height + 40);
        else if(indexPath.row==1)
           return CGSizeMake(kMSScreenWith, 35);
        else
        {
            if([_is_use_bonus integerValue]==1)
            {
                return CGSizeMake(kMSScreenWith,  [RegularExpressionsMethod contentCellHeightWithText:_bonus_tips font:Font(12) width:kMSScreenWith-56]+12);
            }
            else
            {
                 return CGSizeZero;
            }
            
        }
    }

   else  if(indexPath.section == 1)
   {
//        if (_attributeArray>0)
        return CGSizeMake(kMSScreenWith, 60);
//      else
//          return CGSizeMake(kMSScreenWith, 80);
    }
    else if(indexPath.section == 2)
    {

            return CGSizeMake(kMSScreenWith, 80);
    }
        return CGSizeZero;
}


#pragma mark - head宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (section ==0) {
        return  CGSizeMake(kMSScreenWith, kMSScreenHeight * 0.55);
    }
//   else  if (section ==1){
//       if(_attributeArray.count<1&&_commentArray.count>0)
//            return  CGSizeMake(kMSScreenWith, 40);
//     }
    else if (section ==2)
    {
       return  CGSizeMake(kMSScreenWith, 40);
    }
    return CGSizeZero;
}

#pragma mark - foot宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
//    if (_attributeArray.count>0) {
        return (section == 2) ? CGSizeMake(kMSScreenWith, 35) : CGSizeMake(kMSScreenWith, DCMargin);
//    }
//    else
//    {
//       return (section == 1) ? CGSizeMake(kMSScreenWith, 35) : CGSizeMake(kMSScreenWith, DCMargin);
//    }

}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 0) {
        [self scrollToDetailsPage]; //滚动到详情页面
    }
//    else if (indexPath.section == 2 && indexPath.row == 0) {
//        [self chageUserAdress]; //跟换地址
//    }
//    else if (_attributeArray.count>0&&indexPath.section == 1){ //属性选择
    else if (indexPath.section == 1){ //属性选择
        WJFeatureSelectionViewController *dcFeaVc = [WJFeatureSelectionViewController new];
        dcFeaVc.lastNum = lastNum_;
        dcFeaVc.lastSeleArray = [NSMutableArray arrayWithArray:lastSeleArray_];
        dcFeaVc.lastSeleIDArray = [NSMutableArray arrayWithArray:lastSeleIDArray_];
        dcFeaVc.arr_fuckData = _attributeArray;
        dcFeaVc.arr_goodImage = _shufflingArray;
        dcFeaVc.goods_number = _goods_number;
        dcFeaVc.goodPrice = _goodPrice;
        dcFeaVc.goodImageView = _goodImageView;
        WEAKSELF
        [weakSelf setUpAlterViewControllerWith:dcFeaVc WithDistance:kMSScreenHeight * 0.8 WithDirection:XWDrawerAnimatorDirectionBottom WithParallaxEnable:YES WithFlipEnable:YES];
    }
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
- (WKWebView *)webView
{
    if (!_webView) {
        _webView = [[WKWebView alloc] initWithFrame:CGRectZero];
        _webView.frame = CGRectMake(0,kMSScreenHeight , kMSScreenWith, kMSScreenHeight - 50-kMSNaviHight);
        _webView.scrollView.contentInset = UIEdgeInsetsMake(kMSNaviHight, 0, 0, 0);
        _webView.scrollView.scrollIndicatorInsets = _webView.scrollView.contentInset;
        [self.scrollerView addSubview:_webView];
    }
    return _webView;
}
#pragma mark - 记载图文详情
- (void)setUpGoodsWKWebView
{
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
}


#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //判断回到顶部按钮是否隐藏
    _backTopButton.hidden = (scrollView.contentOffset.y > kMSScreenHeight) ? NO : YES;
}
-(void)isSelectAlretOrGetData:(NSInteger)tagSender
{
    WEAKSELF

    if (_attributeArray.count>0) {
        if (lastSeleArray_.count >0) {

            [weakSelf setUpWithAddSuccess:tagSender];
        }
        else {
            WJFeatureSelectionViewController *dcFeaVc = [WJFeatureSelectionViewController new];
            dcFeaVc.lastNum = lastNum_;
            dcFeaVc.lastSeleArray = [NSMutableArray arrayWithArray:lastSeleArray_];
            dcFeaVc.arr_fuckData = _attributeArray;
            dcFeaVc.arr_goodImage = _shufflingArray;
            dcFeaVc.goodPrice = _goodPrice;
            dcFeaVc.goodImageView = _goodImageView;
            [weakSelf setUpAlterViewControllerWith:dcFeaVc WithDistance:kMSScreenHeight * 0.8 WithDirection:XWDrawerAnimatorDirectionBottom WithParallaxEnable:YES WithFlipEnable:YES];
        }
    }
    else
    {
          [weakSelf setUpWithAddSuccess:tagSender];
    }
}


#pragma mark - 加入购物车成功
- (void)setUpWithAddSuccess :(NSInteger)tagSender
{
    NSString *result ;
    NSString *resultID ;
    WEAKSELF
    if (_attributeArray.count>0) {
        result  = [NSString stringWithFormat:@"%@",[lastSeleArray_ componentsJoinedByString:@","]];
        resultID = [NSString stringWithFormat:@"%@",[lastSeleIDArray_ componentsJoinedByString:@","]];
    }
    else
    {
        result = @"";
        resultID = @"0";
    }
    if (tagSender==100) {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        NSString *uid = [[userDefaults objectForKey:@"userList"] objectForKey:@"uid" ];

        NSMutableDictionary *infos = [NSMutableDictionary dictionary];
        [infos setObject:uid forKey:@"user_id"];
        [infos setObject:_goods_id forKey:@"goods_id"];
        [infos setObject:_goodPrice forKey:@"price"];
        [infos setObject:lastNum_ forKey:@"num"];
        [infos setObject:result forKey:@"norms"];
        [infos setObject:resultID forKey:@"goods_attr_id"];
        [weakSelf requestAPIWithServe:[kMSBaseMiYoMeiPortURL stringByAppendingString:kMSPostCart] andInfos:infos];
    }
    else
    {
        
        WJWirteOrderClassViewController *newBuyVC = [[WJWirteOrderClassViewController alloc]init];
        newBuyVC.is_cart = @"0";
        newBuyVC.goods_id = _goods_id;
        newBuyVC.goods_attr_id = resultID;
        newBuyVC.goods_number = lastNum_;
        newBuyVC.hidesBottomBarWhenPushed = YES;
        [weakSelf.navigationController pushViewController:newBuyVC animated:YES];
        weakSelf.hidesBottomBarWhenPushed = YES;
    }
    

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
    NSLog(@"goodBase 销毁");
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
