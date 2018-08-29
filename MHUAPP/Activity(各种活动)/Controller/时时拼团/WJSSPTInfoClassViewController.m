//
//  WJSSPTInfoClassViewController.m
//  MHUAPP
//
//  Created by jinri on 2018/5/21.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import "WJSSPTInfoClassViewController.h"
#import "UIView+UIViewFrame.h"
#import "WJDetailShufflingHeadView.h"
#import "WJDetailPartCommentHeadView.h"

#import "WJSSPTInfoCollectionCell.h"
#import "WJPTPriceCollectionCell.h"
#import "WJShowTypeCouponCell.h"
#import "WJShowTypeGoodsPropertyCell.h"
#import "WJShowTypeFreightCell.h"
#import "WJDetailPartCommentCell.h"
#import "WJFeatureSelectionViewController.h"
#import "WJDetailOverFooterView.h"
#import "WJLoginClassViewController.h"
#import <MJRefresh.h>

#import "XWDrawerAnimator.h"
#import "UIViewController+XWTransition.h"

#import <SVProgressHUD.h>
#import "DCLIRLButton.h"
#import "WJPTNewBuyViewController.h"


@interface WJSSPTInfoClassViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) UIScrollView *scrollerView;
@property (strong, nonatomic) UICollectionView *collectionView;
/* 销售数量 */
@property (strong , nonatomic) NSString *soldNum;
/* 滚回顶部按钮 */
@property (strong , nonatomic)UIButton *backTopButton;
/* 通知 */
@property (weak ,nonatomic) id dcObj;

@end

static NSString *lastNum_;
static NSArray *lastSeleArray_;

@implementation WJSSPTInfoClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setUpInit];

    [self setUpSuspendView];
    lastNum_ = @"1"; 
    [self acceptanceNote];
    [self toGetPTGoodNum];
    // Do any additional setup after loading the view.
}
-(void)toGetPTGoodNum
{
    [self requestGetAPIWithServe:[NSString stringWithFormat:@"%@/%@/%@?id=%@",kMSBaseMiYoMeiPortURL,kMSappVersionCode,kMSMiYoMeiGetNum,_goods_id]];
}

-(void)getProcessData
{
    if([[self.results objectForKey:@"code"] integerValue] == 200)
    {
        _soldNum = [self.results objectForKey:@"data"];
        [_collectionView reloadData];
    }
    else
    {
        [SVProgressHUD showErrorWithStatus:[self.results objectForKey:@"data"]];
        return;
    }
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
        [_collectionView registerClass:[WJSSPTInfoCollectionCell class] forCellWithReuseIdentifier:@"WJSSPTInfoCollectionCell"];
        //注册Cell
        [_collectionView registerClass:[WJPTPriceCollectionCell class] forCellWithReuseIdentifier:@"WJPTPriceCollectionCell"];
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
    }];

    //父类加入购物车，立即购买通知
    _dcObj = [[NSNotificationCenter defaultCenter]addObserverForName:@"PTAddMiaoshaClikAddOrBuy" object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
       if ([note.userInfo[@"buttonTag"] isEqualToString:@"3"]){//立即购买（父类）
              [weakSelf isSelectAlretOrGetData];
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

            [weakSelf isSelectAlretOrGetData];

        }else if ([buttonTag isEqualToString:@"1"]) { //立即购买
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
    if (section==0) {
        if ([_info_classType isEqualToString:@"秒杀"]) {
            return 2;
        }
        else
        return 3;
    }
    else if(section==1)
    {
//        if(_attributeArray&&_attributeArray.count>0)
//        {
            return 1;
//        }
//        else
//        {
//            if (_commentArray.count>1) {
//                return 2;
//            }
//            else
//                return 1;
//        }
    }
    else if(section==2)
    {
            if (_commentArray.count>1) {
                return 2;
            }
            else
                return 1;
    }
    return 0;
}

#pragma mark - <UICollectionViewDelegate>
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *gridcell = nil;
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            WJSSPTInfoCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WJSSPTInfoCollectionCell" forIndexPath:indexPath];
            cell.goodTitle = _goodTitle;
            if ([_info_classType isEqualToString:@"秒杀"]) {
                cell.goodPrice = _goodPrice;
            }
            else
            {
               cell.goodPrice = _group_price_one;
            }
            cell.endTimeStr = _endTimeStr;
            cell.soldNum = _soldNum;
            cell.oldPrice = _oldPrice;
            [cell assignmentAllLabel];
            gridcell = cell;
        }else if (indexPath.row == 1){
            WJShowTypeCouponCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WJShowTypeCouponCell" forIndexPath:indexPath];
            gridcell = cell;
        }
        else if (indexPath.row == 2){
            WJPTPriceCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WJPTPriceCollectionCell" forIndexPath:indexPath];
            cell.group_numb_one = _group_numb_one;
            cell.group_numb_two = _group_numb_two;
            cell.group_numb_three = _group_numb_three;
            cell.group_price_one = _group_price_one;
            cell.group_price_two = _group_price_two;
            cell.group_price_three = _group_price_three;
            [cell reloadDataAllLabel];
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
//        else if (_commentArray.count>0){
//            WJDetailPartCommentCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WJDetailPartCommentCell" forIndexPath:indexPath];
//            cell.model = _commentArray[indexPath.row];
//            return cell;
//        }
//        else {
//
//            return gridcell;
//        }
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
//        else if (indexPath.section == 1) {
//            if(_attributeArray.count<1&&_commentArray.count>0){
//                WJDetailPartCommentHeadView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"WJDetailPartCommentHeadView" forIndexPath:indexPath];
//                headerView.moreClickBlock = ^{
//                    dispatch_sync(dispatch_get_global_queue(0, 0), ^{
//                        [[NSNotificationCenter defaultCenter]postNotificationName:@"scrollToCommentsPage" object:nil];
//                    });
//                };
//                reusableview = headerView;
//            }
//
//        }
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

    ;
}

#pragma mark - item宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) { //商品详情
        switch (indexPath.row) {
            case 0:
                return CGSizeMake(kMSScreenWith, [RegularExpressionsMethod dc_calculateTextSizeWithText:_goodTitle WithTextFont:16 WithMaxW:kMSScreenWith - DCMargin * 2].height + 47);
                break;
            case 1:
              return  CGSizeMake(kMSScreenWith, 35);
                break;
            case 2:
                return  CGSizeMake(kMSScreenWith, 75);
                break;
            default:
                break;
        }
    }
    else  if(indexPath.section == 1)
    {
//        if (_attributeArray>0)
            return CGSizeMake(kMSScreenWith, 60);
//        else
//            return CGSizeMake(kMSScreenWith, 80);
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
//    else  if (section ==1){
//        if(_attributeArray.count<1&&_commentArray.count>0)
//            return  CGSizeMake(kMSScreenWith, 40);
//    }
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
//        return (section == 1) ? CGSizeMake(kMSScreenWith, 35) : CGSizeMake(kMSScreenWith, DCMargin);
//    }

}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
  if (indexPath.section == 1){ //属性选择
        WJFeatureSelectionViewController *dcFeaVc = [WJFeatureSelectionViewController new];
        dcFeaVc.lastNum = lastNum_;
    dcFeaVc.goods_number = _goods_number;
    dcFeaVc.str_IsmiaoshaPT = @"秒杀拼团";
        dcFeaVc.lastSeleArray = [NSMutableArray arrayWithArray:lastSeleArray_];
        dcFeaVc.arr_fuckData = _attributeArray;
        dcFeaVc.arr_goodImage = _shufflingArray;
        dcFeaVc.goodPrice = _goodPrice;
        dcFeaVc.goodImageView = _goodImageView;
        WEAKSELF
        [weakSelf setUpAlterViewControllerWith:dcFeaVc WithDistance:kMSScreenHeight * 0.8 WithDirection:XWDrawerAnimatorDirectionBottom WithParallaxEnable:YES WithFlipEnable:YES];
    }
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
#pragma mark - 视图滚动

#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //判断回到顶部按钮是否隐藏
    _backTopButton.hidden = (scrollView.contentOffset.y > kMSScreenHeight) ? NO : YES;
}
-(void)isSelectAlretOrGetData
{
    WEAKSELF

    if (_attributeArray.count>0) {
        if (lastSeleArray_.count >0) {

            [weakSelf setUpWithAddSuccess];
        }
        else {
            WJFeatureSelectionViewController *dcFeaVc = [WJFeatureSelectionViewController new];
            dcFeaVc.lastNum = lastNum_;
            dcFeaVc.goods_number = _goods_number;
            dcFeaVc.str_IsmiaoshaPT = @"秒杀拼团";
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
        [weakSelf setUpWithAddSuccess];
    }
}

- (void)setUpWithAddSuccess
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    NSString *loginState = [userDefaults objectForKey:@"loginState"];
    if(![loginState isEqualToString:@"1"])
    {
        WJLoginClassViewController *land = [[WJLoginClassViewController alloc]init];
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:land];
        [nav.navigationBar setIsMSNavigationBar];
        [self presentViewController:nav animated:YES completion:^{
        }];
        return;
    }
    if ([_info_classType isEqualToString:@"秒杀"]) {
        [self goToPTNEwBuyClassView];
    }
    else
    {
    [self jxt_showAlertWithTitle:@"批发规则" message:@" 1、批发买家支付呼模式：参与批发的买家需要先支付第一梯度对应的最高价格，批发结束后产生对应批发梯度价格， 卖家按照最后的批发达成价格获取相应收益；如果最后批发达成的梯度价格小于买家参与批发支付的价格，商城按差价额按支付途经原路返还买家多支出的费用。\n2、恶意批发：如果参与批发的买家最后不想参与批发，卖家没有发货，扣除买家参与批发支付费用的10%作为惩罚， 扣除金额归平台所有；如遇到卖家发货途中退货，以恶意批发处理，扣除参与批发支付费用的10%作为惩罚。扣除金额归商家所有\n3、成功参与批发的买家：参与拼在收到货物后，在不影响二次销售的情况下，享有平台的无理由退货权利，部分商品除外 （洗发/定型、染发/烫发、美妆/个户、美甲/纹绣）不在无理由退货的范围内的商品进行退货由商家和卖家自行沟通解决。 " appearanceProcess:^(JXTAlertController * _Nonnull alertMaker) {
        alertMaker.
        addActionCancelTitle(@"取消").
        addActionDestructiveTitle(@"立即购买");
    } actionsBlock:^(NSInteger buttonIndex, UIAlertAction * _Nonnull action, JXTAlertController * _Nonnull alertSelf) {
        if (buttonIndex == 0) {
            NSLog(@"cancel");
        }
        else
        {
            [self goToPTNEwBuyClassView];
        }
        
    }];
    }

}

-(void)goToPTNEwBuyClassView
{
    NSString *result ;
    if (_attributeArray.count>0) {
        result  = [NSString stringWithFormat:@"%@",[lastSeleArray_ componentsJoinedByString:@","]];
        
    }
    else
    {
        result = @"";
    }
    WJPTNewBuyViewController *newBuyVC = [[WJPTNewBuyViewController alloc]init];
    newBuyVC.str_contentImg = _goodImageView;
    newBuyVC.str_title = _goodTitle;
    newBuyVC.str_type = result;
    newBuyVC.str_Num = lastNum_;
    if ([_info_classType isEqualToString:@"秒杀"]) {
        newBuyVC.str_price = _goodPrice;
    }
    else
    {
        newBuyVC.str_price = _group_price_one;
    }
    newBuyVC.str_oldprice = _oldPrice;
    newBuyVC.str_goodsId = _goods_id;
    newBuyVC.info_classType = _info_classType;
    newBuyVC.str_group_info_id = _group_info_id;
    newBuyVC.str_info_id = _info_id;
    newBuyVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:newBuyVC animated:YES];
    self.hidesBottomBarWhenPushed = YES;
}

#pragma mark - 加入购物车成功
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
