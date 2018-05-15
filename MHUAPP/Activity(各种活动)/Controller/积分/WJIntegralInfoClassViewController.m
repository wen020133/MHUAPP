//
//  WJIntegralInfoClassViewController.m
//  MHUAPP
//
//  Created by jinri on 2018/5/14.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import "WJIntegralInfoClassViewController.h"
#import "WJIntegralShufflingHeadView.h"
#import "WJIntegralCollectionListCell.h"
#import <WebKit/WebKit.h>
#import "UIView+UIViewFrame.h"


@interface WJIntegralInfoClassViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UIWebViewDelegate>
/* 商品轮播图 */
@property (copy , nonatomic)NSArray *shufflingArray;

@property (strong, nonatomic) UIScrollView *scrollerView;
@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) UIWebView *webView;

@property NSInteger serverType;

@end

@implementation WJIntegralInfoClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSendReplyWithTitle:@"积分详情" andLeftButtonName:@"ic_back.png" andRightButtonName:nil andTitleLeftOrRight:YES];
    self.view.backgroundColor = [RegularExpressionsMethod ColorWithHexString:kMSVCBackgroundColor];
     [self setUpInit];

    [self getGoodsInfoItem];
    // Do any additional setup after loading the view.
}

-(void)getGoodsInfoItem
{
    _serverType = 1;
    [self requestGetAPIWithServe:[NSString stringWithFormat:@"%@/%@/%@?id=%@",kMSBaseMiYoMeiPortURL,kMSappVersionCode,kMSGetDetailed,_str_supplierId]];
}

-(void)getGoodsDescData
{
    _serverType = 2;
    [self requestGetAPIWithServe:[NSString stringWithFormat:@"%@/%@/%@?id=%@",kMSBaseMiYoMeiPortURL,kMSappVersionCode,kMSGetGoodsDesc,_str_supplierId]];
}
-(void)getProcessData
{
    if([[self.results objectForKey:@"code"] integerValue] == 200)
    {

        switch (_serverType) {
            case 1:
            {
                _shufflingArray = self.results[@"data"][@"gallery"];
                [_collectionView reloadData];
            }
                break;
            case 2:
            {


            }
                break;
            default:
                break;
        }


    }
    else
    {
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
        _collectionView.frame = CGRectMake(0, 0, kMSScreenWith, kMSScreenHeight/2+44*4+40);
        _collectionView.showsVerticalScrollIndicator = NO;
        [self.scrollerView addSubview:_collectionView];

        //注册header
        [_collectionView registerClass:[WJIntegralShufflingHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"WJIntegralShufflingHeadView"];

        //注册Cell
        [_collectionView registerClass:[WJIntegralCollectionListCell class] forCellWithReuseIdentifier:@"WJIntegralCollectionListCell"];

        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"UICollectionElementKindSectionFooter"];

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
}
#pragma mark - <UICollectionViewDataSource>
- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 3;
}
#pragma mark - <UICollectionViewDelegate>
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    WJIntegralCollectionListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WJIntegralCollectionListCell" forIndexPath:indexPath];
    switch (indexPath.row) {
        case 0:
            cell.lab_content.text = [NSString stringWithFormat:@"消耗积分：%@",_str_integral];
            break;
        case 1:
            cell.lab_content.text = [NSString stringWithFormat:@"商品货号：%@",_str_integral];
            break;
        case 2:
            cell.lab_content.text = [NSString stringWithFormat:@"商品库存：%@",_str_integral];
            break;
        default:
            break;
    }

    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {

    UICollectionReusableView *reusableview = nil;
    if (kind == UICollectionElementKindSectionHeader){
        WJIntegralShufflingHeadView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"WJIntegralShufflingHeadView" forIndexPath:indexPath];
        headerView.shufflingArray = _shufflingArray;
        headerView.str_title = _str_title;
        reusableview = headerView;

    }else if (kind == UICollectionElementKindSectionFooter){
        UICollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"UICollectionElementKindSectionFooter" forIndexPath:indexPath];
        footerView.backgroundColor = self.view.backgroundColor;

        UIButton *btnBuyNew = [UIButton buttonWithType:UIButtonTypeCustom];
        btnBuyNew.frame = CGRectMake(DCMargin, 2, kMSScreenWith-DCMargin*2, 40);
        [btnBuyNew setBackgroundColor:[RegularExpressionsMethod ColorWithHexString:BASEPINK]];
        btnBuyNew.layer.cornerRadius = 3;
        btnBuyNew.layer.masksToBounds = YES;//设置圆角
        [btnBuyNew setTitle:@"立即兑换" forState:UIControlStateNormal];
        [btnBuyNew setTitleColor:kMSCellBackColor forState:UIControlStateNormal];
        [btnBuyNew addTarget:self action:@selector(goTobtnBuyNew) forControlEvents:UIControlEventTouchUpInside];
        btnBuyNew.titleLabel.font = Font(16);
        [footerView addSubview:btnBuyNew];
        reusableview = footerView;
    }
    return reusableview;
}
-(void)goTobtnBuyNew
{
   
}

#pragma mark - item宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(kMSScreenWith, 44);

}
#pragma mark - head宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {

     return  CGSizeMake(kMSScreenWith, kMSScreenWith/2+44);
}
#pragma mark - foot宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeMake(kMSScreenWith, 44);
}


- (UIWebView *)webView {
    if (!_webView)
    { _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, _collectionView.Bottom, kMSScreenWith,kMSScreenHeight)];
        _webView.delegate = self;
        _webView.scrollView.bounces = NO;
        _webView.scrollView.showsHorizontalScrollIndicator = NO;
        _webView.scrollView.scrollEnabled = NO;
        _webView.scalesPageToFit = YES;
        [self.scrollerView addSubview:_webView];
        [self.webView.scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
    }
    return _webView;

}
// 修改webview的frame
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"contentSize"]) {
        CGSize resize = [self.webView sizeThatFits:CGSizeZero];
        self.webView.frame = CGRectMake(0, 0, kMSScreenWith, resize.height);

    }

}
// 移除监听
-(void)dealloc {
    [self.webView.scrollView removeObserver:self forKeyPath:@"contentSize"];

}


- (void)webViewDidStartLoad:(UIWebView *)webView {


}


- (void)webViewDidFinishLoad:(UIWebView *)webView {


}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    NSLog(@"商品详情web错误 %@", error);

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
