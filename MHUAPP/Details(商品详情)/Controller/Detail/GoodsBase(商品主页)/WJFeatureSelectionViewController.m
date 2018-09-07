//
//  WJFeatureSelectionViewController.m
//  MHUAPP
//
//  Created by jinri on 2018/1/8.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import "WJFeatureSelectionViewController.h"

#import "WJFeatureList.h"
#import "WJFeatureItem.h"
// Views
#import "PPNumberButton.h"
#import "WJFeatureItemCell.h"
#import "WJFeatureChoseTopCell.h"
#import "WJFeatureHeaderView.h"
#import "DCCollectionHeaderLayout.h"

// Vendors
#import <MJExtension.h>
#import <SVProgressHUD.h>
#import <UIImageView+WebCache.h>
#import "UIViewController+XWTransition.h"
#import "UIView+UIViewFrame.h"


#define NowScreenH kMSScreenHeight * 0.8

@interface WJFeatureSelectionViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,HorizontalCollectionLayoutDelegate,PPNumberButtonDelegate,UITableViewDelegate,UITableViewDataSource>

/* contionView */
@property (strong , nonatomic)UICollectionView *collectionView;
/* tableView */
@property (strong , nonatomic)UITableView *tableView;
/* 数据 */
@property (strong , nonatomic) NSMutableArray <WJFeatureItem *>  *featureAttr;
/* 选择属性 */
@property (strong , nonatomic)NSMutableArray *seleArray;

/* 商品选择结果Cell */
@property (weak , nonatomic) WJFeatureChoseTopCell *cell;


@end

static NSInteger num_;

@implementation WJFeatureSelectionViewController

#pragma mark - LazyLoad
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        DCCollectionHeaderLayout *layout = [DCCollectionHeaderLayout new];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        //自定义layout初始化
        layout.delegate = self;
        layout.lineSpacing = 8.0;
        layout.interitemSpacing = DCMargin;
        layout.headerViewHeight = 35;
        layout.footerViewHeight = 5;
        layout.itemInset = UIEdgeInsetsMake(0, DCMargin, 0, DCMargin);

        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.alwaysBounceVertical = YES;

        [_collectionView registerClass:[WJFeatureItemCell class] forCellWithReuseIdentifier:@"WJFeatureItemCell"];//cell
        [_collectionView registerClass:[WJFeatureHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"WJFeatureHeaderView"]; //头部
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"UICollectionElementKindSectionFooter"]; //尾部

        [self.view addSubview:_collectionView];
    }
    return _collectionView;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.scrollEnabled = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
        [_tableView registerClass:[WJFeatureChoseTopCell class] forCellReuseIdentifier:@"WJFeatureChoseTopCell"];
    }
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    [self setUpFeatureAlterView];

    [self setUpBase];

    [self setUpBottonView];
    self.attrPrice = @"0";
    // Do any additional setup after loading the view.
}

#pragma mark - initialize
- (void)setUpBase
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.collectionView.backgroundColor = self.view.backgroundColor;
    self.automaticallyAdjustsScrollViewInsets = NO;
    _featureAttr = [WJFeatureItem mj_objectArrayWithKeyValuesArray:self.arr_fuckData];
    self.tableView.frame = CGRectMake(0, 0, kMSScreenWith, 100);
    self.tableView.rowHeight = 100;
    self.collectionView.frame = CGRectMake(0, self.tableView.Bottom ,kMSScreenWith , NowScreenH - 200);

    if (_lastSeleArray.count == 0) return;
    for (NSString *str in _lastSeleArray) {//反向遍历（赋值）
        for (NSInteger i = 0; i < _featureAttr.count; i++) {
            for (NSInteger j = 0; j < _featureAttr[i].list.count; j++) {
                if ([_featureAttr[i].list[j].attr_value isEqualToString:str]) {
                    _featureAttr[i].list[j].isSelect = YES;
                    [self.collectionView reloadData];
                }
            }
        }
    }
}

#pragma mark - 底部按钮
- (void)setUpBottonView
{
    NSMutableArray *titles = [NSMutableArray array];
    if ([_str_IsmiaoshaPT isEqualToString:@"秒杀拼团"]) {
        titles = [NSMutableArray arrayWithObjects:@"立即购买", nil];
    }
    else
    {
        titles = [NSMutableArray arrayWithObjects:@"加入购物车",@"立即购买", nil];
    }
    CGFloat buttonH = 50;
    CGFloat buttonW = kMSScreenWith / titles.count;
    CGFloat buttonY = NowScreenH - buttonH;
    for (NSInteger i = 0; i < titles.count; i++) {
        UIButton *buttton = [UIButton buttonWithType:UIButtonTypeCustom];
        [buttton setTitle:titles[i] forState:0];
        buttton.backgroundColor = (i == 0) ? [UIColor redColor] : [UIColor orangeColor];
        CGFloat buttonX = buttonW * i;
        buttton.tag = i;
        buttton.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        [self.view addSubview:buttton];
        [buttton addTarget:self action:@selector(buttomButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }

    UILabel *numLabel = [UILabel new];
    numLabel.text = @"数量";
    numLabel.font = PFR14Font;
    [self.view addSubview:numLabel];
    numLabel.frame = CGRectMake(DCMargin, NowScreenH - 90, 50, 35);

    PPNumberButton *numberButton = [PPNumberButton numberButtonWithFrame:CGRectMake(CGRectGetMaxX(numLabel.frame), numLabel.y, 210, numLabel.height)];
    numberButton.shakeAnimation = YES;
    numberButton.minValue = 1;
    numberButton.inputFieldFont = 20;
    numberButton.increaseTitle = @"＋";
    numberButton.decreaseTitle = @"－";
    num_ = (_lastNum == 0) ?  1 : [_lastNum integerValue];
    numberButton.currentNumber = num_;
    numberButton.delegate = self;

    numberButton.resultBlock = ^(NSInteger num ,BOOL increaseStatus){
        if (num<=_goods_number) {
            num_ = num;
        }
        else
        {
            [SVProgressHUD showSuccessWithStatus:@"库存不足"];
            [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
            [SVProgressHUD dismissWithDelay:1.0];
            return ;
        }
    };
    [self.view addSubview:numberButton];
}

#pragma mark - 底部按钮点击
- (void)buttomButtonClick:(UIButton *)button
{
    if (_seleArray.count != _featureAttr.count && _lastSeleArray.count != _featureAttr.count) {//未选择全属性警告
        [SVProgressHUD showInfoWithStatus:@"请选择全属性"];
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        [SVProgressHUD dismissWithDelay:1.0];
        return;
    }

    [self dismissFeatureViewControllerWithTag:button.tag];

}

#pragma mark - 弹出弹框
- (void)setUpFeatureAlterView
{
    XWInteractiveTransitionGestureDirection direction = XWInteractiveTransitionGestureDirectionDown;
    WEAKSELF
    [self xw_registerBackInteractiveTransitionWithDirection:direction transitonBlock:^(CGPoint startPoint){
        [weakSelf dismissViewControllerAnimated:YES completion:^{
            [weakSelf dismissFeatureViewControllerWithTag:100];
        }];
    } edgeSpacing:0];
}

#pragma mark - <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WJFeatureChoseTopCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WJFeatureChoseTopCell" forIndexPath:indexPath];
    _cell = cell;
   
    if(_featureAttr.count<1)
    {
        cell.chooseAttLabel.text = [NSString stringWithFormat:@"库存:%ld",_goods_number];
    }
    else if (_seleArray.count != _featureAttr.count && _lastSeleArray.count != _featureAttr.count) {
        cell.chooseAttLabel.textColor = [UIColor redColor];
        cell.chooseAttLabel.text = [NSString stringWithFormat:@"库存:%ld",_goods_number];
    }
    else {
         cell.chooseAttLabel.text = [NSString stringWithFormat:@"库存:%ld",_goods_number];
    }
    cell.goodPriceLabel.text = [NSString stringWithFormat:@"¥ %.2f",[self.goodPrice floatValue]+[self.attrPrice floatValue]];
    if (_attrImageUrl.length>24) {
        [cell.goodImageView sd_setImageWithURL:[NSURL URLWithString:_attrImageUrl]];
    }
    else
    {
        [cell.goodImageView sd_setImageWithURL:[NSURL URLWithString:_goodImageView]];
    }
    WEAKSELF
    cell.crossButtonClickBlock = ^{
        [weakSelf dismissFeatureViewControllerWithTag:100];
    };
    return cell;
}

#pragma mark - 退出当前界面
- (void)dismissFeatureViewControllerWithTag:(NSInteger)tag
{

    WEAKSELF
    [weakSelf dismissViewControllerAnimated:YES completion:^{
        if (![weakSelf.cell.chooseAttLabel.text isEqualToString:@"请选择"]) {//当选择全属性才传递出去
            dispatch_sync(dispatch_get_global_queue(0, 0), ^{
                if (_seleArray.count == 0) {
                    NSMutableArray *numArray = [NSMutableArray arrayWithArray:_lastSeleArray];
                    NSDictionary *paDict = @{
                                             @"Tag" : [NSString stringWithFormat:@"%zd",tag],
                                             @"Num" : [NSString stringWithFormat:@"%zd",num_],
                                             @"Array" : numArray,
                                             @"ArrayID" : numArray
                                             };
                    NSDictionary *dict = [[NSDictionary alloc] initWithDictionary:paDict];
                    [[NSNotificationCenter defaultCenter]postNotificationName:@"itemSelectBack" object:nil userInfo:dict];
                }else{
                    NSDictionary *paDict = @{
                                             @"Tag" : [NSString stringWithFormat:@"%zd",tag],
                                             @"Num" : [NSString stringWithFormat:@"%zd",num_],
                                             @"Array" : _seleArray,
                                             @"ArrayID" : _lastSeleIDArray
                                             };
                    NSDictionary *dict = [[NSDictionary alloc] initWithDictionary:paDict];
                    [[NSNotificationCenter defaultCenter]postNotificationName:@"itemSelectBack" object:nil userInfo:dict];
                }
            });
        }
    }];
}



#pragma mark - <UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return _featureAttr.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _featureAttr[section].list.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    WJFeatureItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WJFeatureItemCell" forIndexPath:indexPath];

     cell.content = _featureAttr[indexPath.section].list[indexPath.row];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {

    if ([kind  isEqualToString:UICollectionElementKindSectionHeader]) {
        WJFeatureHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"WJFeatureHeaderView" forIndexPath:indexPath];
         headerView.headTitle = _featureAttr[indexPath.section];
        return headerView;
    }else {

        UICollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"UICollectionElementKindSectionFooter" forIndexPath:indexPath];
        return footerView;
    }
}

#pragma mark - <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

    //限制每组内的Item只能选中一个(加入质数选择)
    if (_featureAttr[indexPath.section].list[indexPath.row].isSelect == NO) {
        for (NSInteger j = 0; j < _featureAttr[indexPath.section].list.count; j++) {
            _featureAttr[indexPath.section].list[j].isSelect = NO;
        }
    }
    _featureAttr[indexPath.section].list[indexPath.row].isSelect = !_featureAttr[indexPath.section].list[indexPath.row].isSelect;


    //section，item 循环讲选中的所有Item加入数组中 ，数组mutableCopy初始化
    _seleArray = [@[] mutableCopy];
    _lastSeleIDArray = [@[] mutableCopy];
    for (NSInteger i = 0; i < _featureAttr.count; i++) {
        for (NSInteger j = 0; j < _featureAttr[i].list.count; j++) {
            if (_featureAttr[i].list[j].isSelect == YES) {
                [_seleArray addObject:_featureAttr[i].list[j].attr_value];
                [_lastSeleIDArray addObject:_featureAttr[i].list[j].goods_attr_id];
                _attrPrice = _featureAttr[i].list[j].attr_price;
                _goods_number = [_featureAttr[i].list[j].product_number integerValue];
                _attrImageUrl = _featureAttr[i].list[j].thumb_url;
            }else{
                [_seleArray removeObject:_featureAttr[i].list[j].attr_value];
               [_lastSeleIDArray removeObject:_featureAttr[i].list[j].goods_attr_id];
                [_lastSeleArray removeAllObjects];
            }
        }
    }

    //刷新tableView和collectionView
    [self.collectionView reloadData];
    [self.tableView reloadData];
}


#pragma mark - <HorizontalCollectionLayoutDelegate>
#pragma mark - 自定义layout必须实现的方法
- (NSString *)collectionViewItemSizeWithIndexPath:(NSIndexPath *)indexPath {
    return _featureAttr[indexPath.section].list[indexPath.row].attr_value;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
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
