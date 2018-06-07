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
#import "WJGoodDetailViewController.h"
#import "MJRefresh.h"

#import "WJGoodsListItem.h"

#import "WJHoverFlowLayout.h"
#import "WJSildeBarView.h"

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
     _str_type = @"1";
    _type_numb = @"2";
    [self.view addSubview:self.collectionView];

    [self setUpSuspendView];
    // Do any additional setup after loading the view.
}
-(void)initinfomationClassData
{
    NSMutableDictionary *infos = [NSMutableDictionary dictionary];
    [infos setValue:kMSPULLtableViewCellNumber forKey:@"numb"];
    [infos setValue:_category_id forKey:@"category_id"];
    [infos setValue:_str_type forKey:@"type"];
    [infos setValue:_type_numb forKey:@"type_numb"];
    [infos setValue:[NSString stringWithFormat:@"%ld",_page_Information] forKey:@"start"];
    [self requestAPIWithServe:[kMSBaseLargeCollectionPortURL stringByAppendingString:kMSPostGoodsList] andInfos:infos];
}

-(void)processData
{
    [_collectionView.mj_header endRefreshing];
    [_collectionView.mj_footer endRefreshing];
    if([[self.results objectForKey:@"code"] integerValue] == 200)
    {

        NSMutableArray *arr_Datalist = [NSMutableArray array];
                arr_Datalist = [self.results objectForKey:@"data"];
        NSMutableArray *entities = [NSMutableArray array];
                if (arr_Datalist&&arr_Datalist.count>0) {

                    entities = [WJGoodsListItem mj_objectArrayWithKeyValuesArray:arr_Datalist];
                    if(_page_Information==0)
                    {
                        _setItem= entities;
                    }else
                    {
                        [_setItem addObjectsFromArray:entities];
                    }
                    [_collectionView reloadData];
                    if(entities.count<[kMSPULLtableViewCellNumber integerValue])
                    {
                        [_collectionView.mj_footer endRefreshingWithNoMoreData];
                    }
                    else{
                        _collectionView.mj_footer.hidden = NO;
                    }
                }
        else
        {
            [_collectionView.mj_footer endRefreshingWithNoMoreData];
        }

    }
    else
    {
        [self requestFailed:@"获取数据失败"];
    }
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
        // 下拉刷新
        _collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRereshingCircle)];
        [_collectionView.mj_header beginRefreshing];
        // 上拉刷新
        _collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRereshingCircle)];
    }
    return _collectionView;
}
-(void)headerRereshingCircle
{
    [_collectionView.mj_header endRefreshing];
    [_collectionView.mj_footer endRefreshing];
    _page_Information = 0;
    [self initinfomationClassData];
}

-(void)footerRereshingCircle
{
    [_collectionView.mj_header endRefreshing];
    [_collectionView.mj_footer endRefreshing];
    _page_Information = _page_Information+10;
    [self initinfomationClassData];
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
        cell.goodsItem = self.setItem[indexPath.row];
        return cell;
    }
    else
    {
        WJSwitchGridCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"WJSwitchGridCell" forIndexPath:indexPath];
        cell.goodsItem = self.setItem[indexPath.row];
        return cell;

    }

}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {

    UICollectionReusableView *reusableview = nil;
    if (kind == UICollectionElementKindSectionHeader){

        WJCustionGoodsHeadView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"WJCustionGoodsHeadView" forIndexPath:indexPath];
        WEAKSELF
        headerView.filtrateClickBlock = ^(NSInteger selectTag){
            [weakSelf filtrateButtonClick:selectTag];
        };
        reusableview = headerView;
    }
    return reusableview;
}
#pragma mark - item宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return (_isSwitchGrid) ? CGSizeMake(kMSScreenWith, 100) : CGSizeMake((kMSScreenWith - 4)/2, (kMSScreenWith - 4)/2 + 50);//列表、网格Cell
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
    WJGoodDetailViewController *dcVc = [[WJGoodDetailViewController alloc] init];
    dcVc.goods_id = _setItem[indexPath.row].goods_id;
//    dcVc.goodTitle = _setItem[indexPath.row].main_title;
//    dcVc.goodPrice = _setItem[indexPath.row].price;
//    dcVc.goodSubtitle = _setItem[indexPath.row].goods_title;
//    dcVc.shufflingArray = _setItem[indexPath.row].images;
//    dcVc.goodImageView = _setItem[indexPath.row].image_url;
    dcVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:dcVc animated:YES];
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
        self.collectionView.frame = CGRectMake(0, 0, kMSScreenWith, kMSScreenHeight);
    }
}

#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //判断回到顶部按钮是否隐藏
    _backTopButton.hidden = (scrollView.contentOffset.y > kMSScreenHeight) ? NO : YES;
}
-(void)filtrateButtonClick:(NSInteger)tag
{

    switch (tag) {
        case 1000:
            {
                _page_Information = 0;
                _str_type = @"1";
                _type_numb = @"2";
            }
            break;
        case 1001:
        {
            _page_Information = 0;
            _str_type = @"2";
            _type_numb = @"2";
        }
            break;
        case 1002:
        {
            _page_Information = 0;
            _str_type = @"3";
            _type_numb = @"2";
        }
            break;
        case 1003:
        {
           [WJSildeBarView dc_showSildBarViewController];
        }
            break;
        case 1004:
        {
            _page_Information = 0;
            _str_type = @"2";
            _type_numb = @"1";
        }
            break;
        default:
            break;
    }
    [self initinfomationClassData];
    [self ScrollToTop];
}

#pragma 退出界面
- (void)selfAlterViewback{

    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)dealloc
{
    NSLog(@"销毁");
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
