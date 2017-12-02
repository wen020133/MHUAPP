//
//  WJGoodsSetViewController.m
//  MHUAPP
//
//  Created by jinri on 2017/12/1.
//  Copyright © 2017年 wenchengjun. All rights reserved.
//

#import "WJGoodsSetViewController.h"
#import "WJCustionGoodsHeadView.h"
#import "WJListGoodsCell.h"
#import "WJSwitchGridCell.h"

#import "WJGoodsListItem.h"

#import "WJHoverFlowLayout.h"

@interface WJGoodsSetViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (strong , nonatomic)UICollectionView *collectionView;

/* 切换视图按钮 */
@property (strong , nonatomic)UIButton *switchViewButton;
/* 自定义头部View */
@property (strong , nonatomic) WJCustionGoodsHeadView *custionHeadView;
/* 具体商品数据 */
@property (strong , nonatomic)NSMutableArray<WJGoodsListItem *> *setItem;

/**
 0：列表视图，1：格子视图
 */
@property (nonatomic, assign) BOOL isSwitchGrid;
/* 滚回顶部按钮 */
@property (strong , nonatomic)UIButton *backTopButton;
@end

static CGFloat _lastContentOffset;

@implementation WJGoodsSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [RegularExpressionsMethod ColorWithHexString:kMSVCBackgroundColor];

    [self initSendReplyWithTitle:self.goodTypeName andLeftButtonName:@"ic_back.png" andRightButtonName:@"nav_btn_jiugongge" andTitleLeftOrRight:YES];

    _isSwitchGrid = NO;
    _setItem = [WJGoodsListItem mj_objectArrayWithFilename:@"HomeHighGoods.plist"];
    [self.view addSubview:self.collectionView];

    [self setUpSuspendView];

    // Do any additional setup after loading the view.
}
#pragma mark - LazyLoad
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        WJHoverFlowLayout *layout = [WJHoverFlowLayout new];
        _collectionView = [[UICollectionView alloc]initWithFrame: CGRectMake(0, 0, kMSScreenWith, kMSScreenHeight - kMSNaviHight) collectionViewLayout:layout];
        _collectionView.backgroundColor = [RegularExpressionsMethod ColorWithHexString:kMSVCBackgroundColor];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;

        [_collectionView registerClass:[WJCustionGoodsHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"WJCustionGoodsHeadView"]; //头部View
        [_collectionView registerClass:[WJListGoodsCell class] forCellWithReuseIdentifier:@"WJListGoodsCell"];//cell
        [_collectionView registerClass:[WJSwitchGridCell class] forCellWithReuseIdentifier:@"WJSwitchGridCell"];//cell
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
}
#pragma mark - 切换Model
- (void)showright
{
    if (_isSwitchGrid) {
        [self initSendReplyWithTitle:self.goodTypeName andLeftButtonName:@"ic_back.png" andRightButtonName:@"nav_btn_list" andTitleLeftOrRight:YES];
        _isSwitchGrid = NO;
    }
   else
   {
       _isSwitchGrid = YES;
        [self initSendReplyWithTitle:self.goodTypeName andLeftButtonName:@"ic_back.png" andRightButtonName:@"nav_btn_jiugongge" andTitleLeftOrRight:YES];
   }
     [self.collectionView reloadData];
}

#pragma mark - 悬浮按钮
- (void)setUpSuspendView
{
    _backTopButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:_backTopButton];
    [_backTopButton addTarget:self action:@selector(ScrollToTop) forControlEvents:UIControlEventTouchUpInside];
    [_backTopButton setImage:[UIImage imageNamed:@"btn_UpToTop"] forState:UIControlStateNormal];
    _backTopButton.hidden = YES;
    _backTopButton.frame = CGRectMake(kMSScreenWith - 50, kMSScreenHeight - 60, 40, 40);
}
#pragma mark - <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _setItem.count;
}

#pragma mark - <UICollectionViewDelegate>
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (_isSwitchGrid) {
        WJListGoodsCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"WJListGoodsCell" forIndexPath:indexPath];
        return cell;
    }
    else
    {
        WJSwitchGridCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"WJSwitchGridCell" forIndexPath:indexPath];
        //        cell.model = self.headImageArr[indexPath.row];
        return cell;

    }

}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {

    UICollectionReusableView *reusableview = nil;
    if (kind == UICollectionElementKindSectionHeader){

        WJCustionGoodsHeadView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"WJCustionGoodsHeadView" forIndexPath:indexPath];
        headerView.filtrateClickBlock = ^{//点击了筛选
            [self filtrateButtonClick];
        };
        reusableview = headerView;
    }
    return reusableview;
}
#pragma mark - item宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return (_isSwitchGrid) ? CGSizeMake(kMSScreenWith, 120) : CGSizeMake((kMSScreenWith - 4)/2, (kMSScreenWith - 4)/2 + 60);//列表、网格Cell
}

#pragma mark - head宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(kMSScreenWith, 40); //头部
}

#pragma mark - 边间距属性默认为0
#pragma mark - X间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 4;

}
#pragma mark - Y间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return (_isSwitchGrid) ? 0 : 4;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"点击了商品第%zd",indexPath.row);
}


#pragma mark - collectionView滚回顶部
- (void)ScrollToTop
{
    [self.collectionView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 滑动代理
//开始滑动的时候记录位置
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{

    _lastContentOffset = scrollView.contentOffset.y;

}
-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{

    if(scrollView.contentOffset.y > _lastContentOffset){
        [self.navigationController setNavigationBarHidden:YES animated:YES];
        self.collectionView.frame = CGRectMake(0, 20, kMSScreenWith, kMSScreenHeight - 20);
    }else{
        [self.navigationController setNavigationBarHidden:NO animated:YES];
        self.collectionView.frame = CGRectMake(0, kMSNaviHight, kMSScreenWith, kMSScreenHeight-kMSNaviHight);
    }
}

#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //判断回到顶部按钮是否隐藏
    _backTopButton.hidden = (scrollView.contentOffset.y > kMSScreenHeight) ? NO : YES;
}
-(void)filtrateButtonClick
{

}

#pragma 退出界面
- (void)selfAlterViewback{

    [self dismissViewControllerAnimated:YES completion:nil];
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
