//
//  WJShopCartClassViewController.m
//  MHUAPP
//
//  Created by wenchengjun on 2017/11/28.
//  Copyright © 2017年 wenchengjun. All rights reserved.
//

#import "WJShopCartClassViewController.h"
#import "WJCartTableViewCell.h"
#import "WJCartGoodsModel.h"
#import "WJCartShopModel.h"
#import "WJCartTableHeaderView.h"
#import "WJHomeRefreshGifHeader.h"
#import "UIView+UIViewFrame.h"
#import "WJLoginClassViewController.h"
#import "WJWirteOrderClassViewController.h"
#import "WJGoodDetailViewController.h"
#import "WJStoreInfoClassViewController.h"
#import <UIImageView+WebCache.h>
#import "WJUnLoginStateTypeView.h"

#define  TAG_CartEmptyView 100
static NSInteger lz_CartRowHeight = 100;

@interface WJShopCartClassViewController ()


@property (strong,nonatomic)NSMutableArray *dataArray;
@property (strong,nonatomic)NSMutableArray *selectedArray;
@property (strong,nonatomic)UITableView *myTableView;
@property (strong,nonatomic)UIButton *allSellectedButton;
@property (strong,nonatomic)UILabel *totlePriceLabel;

@property (strong, nonatomic) WJUnLoginStateTypeView *unLoginView;

@property BOOL isFirstInitClass;
@end

@implementation WJShopCartClassViewController

#pragma mark - viewController life cicle
- (void)viewWillAppear:(BOOL)animated {

    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    NSString *loginState = [userDefaults objectForKey:@"loginState"];
    if(![loginState isEqualToString:@"1"])
    {
         [self setupCustomNavigationBar];
        _myTableView.hidden = YES;
        UIView *view = [self.view viewWithTag:TAG_CartEmptyView];
        [view removeFromSuperview];
        UIView *bottomView = [self.view viewWithTag:TAG_CartEmptyView + 1];
        [bottomView removeFromSuperview];

        WEAKSELF
        if (_isFirstInitClass) {
            [self.unLoginView hide];
            self.unLoginView = [[WJUnLoginStateTypeView alloc]initWithFrame:CGRectMake(0, 0, kMSScreenWith, kMSScreenHeight-kMSNaviHight-kTabBarHeight) withContent:@"去登录" withImage:@"noMore_bg.png"];
            self.unLoginView.jumpToLoginPage = ^{
                WJLoginClassViewController *land = [[WJLoginClassViewController alloc]init];
                UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:land];
                [nav.navigationBar setIsMSNavigationBar];
                [weakSelf presentViewController:nav animated:YES completion:^{
                }];
            };
            [self.view addSubview:self.unLoginView];
            return;
        }
        _isFirstInitClass = YES;
        WJLoginClassViewController *land = [[WJLoginClassViewController alloc]init];
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:land];
        [nav.navigationBar setIsMSNavigationBar];
        [self presentViewController:nav animated:YES completion:^{
        }];
    }
    else
    {
        [self.unLoginView hide];
        _myTableView.hidden = NO;
        [self getGoodsInfoCreatData];

    }
   
    
    for (WJCartGoodsModel *model in _selectedArray) {
        model.select = NO;
    }

    [_selectedArray removeAllObjects];


    for (WJCartShopModel *shop in self.dataArray) {
        shop.select = NO;
    }


    [self.myTableView reloadData];
    [self countPrice];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [RegularExpressionsMethod ColorWithHexString:kMSVCBackgroundColor];
    _selectedArray = [NSMutableArray array];
    [self.view addSubview:self.myTableView];

    // Do any additional setup after loading the view.
}
-(UITableView *)myTableView
{
    if (!_myTableView) {
        _myTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];

        _myTableView.delegate = self;
        _myTableView.dataSource = self;

        _myTableView.rowHeight = lz_CartRowHeight;
        _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _myTableView.backgroundColor = kMSColorFromRGB(245, 246, 248);

         [self.myTableView registerClass:[WJCartTableHeaderView class] forHeaderFooterViewReuseIdentifier:@"WJCartTableHeaderView"];
        if (_isHasTabBarController) {
            self.myTableView.frame = CGRectMake(0, 0, kMSScreenWith, kMSScreenHeight - kMSNaviHight -kTabBarHeight -49);
        } else {
            self.myTableView.frame = CGRectMake(0, 0, kMSScreenWith, kMSScreenHeight - kMSNaviHight - 49);
        }
        self.myTableView.mj_header = [WJHomeRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(getGoodsInfoCreatData)];
    }
    return _myTableView;
}

-(void)getGoodsInfoCreatData
{
    [self.myTableView.mj_header endRefreshing];
    _serverType = 1;
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *uid = [[userDefaults objectForKey:@"userList"] objectForKey:@"uid" ];
    [self requestGetAPIWithServe:[NSString stringWithFormat:@"%@/%@/%@?user_id=%@",kMSBaseMiYoMeiPortURL,kMSappVersionCode,kMSGetCartList,uid]];
//    [self changeView];
}
-(void)getProcessData
{
    if([[self.results objectForKey:@"code"] integerValue] == 200)
    {

        switch (_serverType) {
            case KGetShopCartListClass:
            {
                 [self.dataArray removeAllObjects];
                id arr_data = [self.results objectForKey:@"data"];
                if ([arr_data isKindOfClass:[NSArray class]]) {
                    NSArray *dataArr = arr_data;
                    if ([dataArr  count]<1 ) {
                        [self changeView];
                        [self.myTableView reloadData];
                        [self setupCustomNavigationBar];
                        return;
                    }

                    for (int aa=0; aa<dataArr.count; aa++) {
                        NSArray *arr_goods = [[dataArr objectAtIndex:aa] objectForKey:@"goods"];
                        if (arr_goods&&arr_goods.count>0) {
                            WJCartShopModel *model = [[WJCartShopModel alloc]init];
                            model.supplier_id = [[dataArr objectAtIndex:aa] objectForKey:@"supplier_id"];
                            model.supplier_name = [[dataArr objectAtIndex:aa] objectForKey:@"supplier_name"];
                            model.supplier_logo = [[dataArr objectAtIndex:aa] objectForKey:@"logo"];
                            [model configGoodsArrayWithArray:arr_goods];

                            [self.dataArray addObject:model];

                        }

                        [self changeView];
                        [self.myTableView reloadData];
                        [self.myTableView.mj_header endRefreshing];
                        [self setupCustomNavigationBar];
                    }

                }
                else
                {
                    [self changeView];
                    [self.myTableView reloadData];
                    return;
                }


            }
                break;
            case KGetGoodNumChange:
            {

            }
                break;
            default:
                break;
        }


    }
    else
    {
         [self.myTableView.mj_header endRefreshing];
        [self requestFailed:[self.results objectForKey:@"msg"]];
        return;
    }
}


-(void)countPrice {
    double totlePrice = 0.0;

    for (WJCartGoodsModel *model in _selectedArray) {

        double price = [model.goods_price doubleValue];

        totlePrice += price * model.goods_number;
    }
    NSString *string = [NSString stringWithFormat:@"￥%.2f",totlePrice];
    self.totlePriceLabel.attributedText = [self LZSetString:string];
}
#pragma mark - 初始化数组
- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray arrayWithCapacity:0];
    }

    return _dataArray;
}


#pragma mark - 布局页面视图
#pragma mark -- 自定义导航
- (void)setupCustomNavigationBar {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *uid =[NSString stringWithFormat:@"%@", [[userDefaults objectForKey:@"userList"] objectForKey:@"uid" ]];
    if (self.isHasTabBarController) {
        if (uid.length>1&&self.dataArray.count > 0) {
             [self initSendReplyWithTitle:@"购物车" andLeftButtonName:nil andRightButtonName: @"编辑" andTitleLeftOrRight:NO];
        }
        else
        {
             [self initSendReplyWithTitle:@"购物车" andLeftButtonName:nil andRightButtonName:nil andTitleLeftOrRight:NO];
        }

    }
    else
    {
        if (uid.length>1&&self.dataArray.count > 0) {
              [self initSendReplyWithTitle:@"购物车" andLeftButtonName:@"ic_back.png" andRightButtonName:@"编辑" andTitleLeftOrRight:NO];
        }
        else
        {
             [self initSendReplyWithTitle:@"购物车" andLeftButtonName:@"ic_back.png" andRightButtonName:nil andTitleLeftOrRight:NO];
        }
    }
}
-(void)showright
{
    if(self.selectedState)
    {
        self.selectedState = NO;
    }
    else
        self.selectedState = YES;

    if(!self.isHasTabBarController)
    {
        if(!self.selectedState)
        {
            [self initSendReplyWithTitle:@"购物车" andLeftButtonName:@"ic_back.png" andRightButtonName:@"编辑" andTitleLeftOrRight:NO];
        }
        else
        {
            [self initSendReplyWithTitle:@"购物车" andLeftButtonName:@"ic_back.png" andRightButtonName:@"完成" andTitleLeftOrRight:NO];
        }
    }
    else
    {
        if(!self.selectedState)
        {
            [self initSendReplyWithTitle:@"购物车" andLeftButtonName:nil andRightButtonName:@"编辑" andTitleLeftOrRight:NO];
        }
        else
        {
            [self initSendReplyWithTitle:@"购物车" andLeftButtonName:nil andRightButtonName:@"完成" andTitleLeftOrRight:NO];
        }
    }
    [self changeView];

    //点击全选时,把之前已选择的全部删除
    for (WJCartGoodsModel *model in _selectedArray) {
        model.select = NO;
    }

    [_selectedArray removeAllObjects];


    for (WJCartShopModel *shop in self.dataArray) {
            shop.select = NO;
    }


    [self.myTableView reloadData];
    [self countPrice];

}
#pragma mark -- 自定义底部视图
- (void)setupCustomBottomView {

    UIView *backgroundView = [[UIView alloc]init];
    backgroundView.backgroundColor = kMSCellBackColor;
    backgroundView.tag = TAG_CartEmptyView + 1;
    [self.view addSubview:backgroundView];

    //当有tabBarController时,在tabBar的上面
    if (_isHasTabBarController == YES) {
        backgroundView.frame = CGRectMake(0, kMSScreenHeight - kTabBarHeight -49-kMSNaviHight, kMSScreenWith, 49);
    } else {
        backgroundView.frame = CGRectMake(0, kMSScreenHeight -  49-kMSNaviHight, kMSScreenWith, 49);
    }

    //全选按钮
    UIButton *selectAll = [UIButton buttonWithType:UIButtonTypeCustom];
    selectAll.titleLabel.font = [UIFont systemFontOfSize:16];
    selectAll.frame = CGRectMake(10, 5, 80, 49 - 10);
    [selectAll setTitle:@" 全选" forState:UIControlStateNormal];
    [selectAll setImage:[UIImage imageNamed:@"user_weigouxuan"] forState:UIControlStateNormal];
    [selectAll setImage:[UIImage imageNamed:@"shipcart_seleHigh"] forState:UIControlStateSelected];
    [selectAll setTitleColor:[RegularExpressionsMethod ColorWithHexString:@"666666"] forState:UIControlStateNormal];
    [selectAll addTarget:self action:@selector(selectAllBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [backgroundView addSubview:selectAll];
    self.allSellectedButton = selectAll;
    if(self.selectedState)
    {
        //删除按钮
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = kMSCellBackColor;
        btn.layer.borderColor = [[RegularExpressionsMethod ColorWithHexString:BASEPINK] CGColor];
        btn.layer.borderWidth = 1.0f;
        btn.layer.cornerRadius = 3;
        btn.layer.masksToBounds = YES;//设置圆角
        btn.frame = CGRectMake(kMSScreenWith - 90, 5, 70, 35);
        [btn setTitle:@"删除" forState:UIControlStateNormal];
        [btn setTitleColor:[RegularExpressionsMethod ColorWithHexString:BASEPINK] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(deleteGoodsInCart:) forControlEvents:UIControlEventTouchUpInside];
        [backgroundView addSubview:btn];
    }
    else
    {
    //结算按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [RegularExpressionsMethod ColorWithHexString:BASEPINK];
    btn.frame = CGRectMake(kMSScreenWith - 80, 0, 80, 49);
    [btn setTitle:@"去结算" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(goToPayButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [backgroundView addSubview:btn];

    //合计
    UILabel *label = [[UILabel alloc]init];
    label.font = [UIFont systemFontOfSize:16];
    label.textColor = [RegularExpressionsMethod ColorWithHexString:BASEPINK];
    [backgroundView addSubview:label];

    label.attributedText = [self LZSetString:@"¥0.00"];
    CGFloat maxWidth = kMSScreenWith - selectAll.bounds.size.width - btn.bounds.size.width - 30;
//    CGSize size = [label sizeThatFits:CGSizeMake(maxWidth, 49)];
    label.frame = CGRectMake(selectAll.bounds.size.width + 20, 0, maxWidth - 10, 49);
    self.totlePriceLabel = label;
    }
}
- (NSMutableAttributedString*)LZSetString:(NSString*)string {

    NSString *text = [NSString stringWithFormat:@"合计:%@",string];
    NSMutableAttributedString *LZString = [[NSMutableAttributedString alloc]initWithString:text];
    NSRange rang = [text rangeOfString:@"合计:"];
    [LZString addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:rang];
    [LZString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:rang];
    return LZString;
}

#pragma mark -- 购物车为空时的默认视图
- (void)changeView {
    if (self.dataArray.count > 0) {
        UIView *view = [self.view viewWithTag:TAG_CartEmptyView];
        UIView *bottomView = [self.view viewWithTag:TAG_CartEmptyView + 1];
         [bottomView removeFromSuperview];
        if (view != nil) {
            [view removeFromSuperview];
        }

        [self setupCustomBottomView];
    } else {
         UIView *view = [self.view viewWithTag:TAG_CartEmptyView];
        [view removeFromSuperview];
        UIView *bottomView = [self.view viewWithTag:TAG_CartEmptyView + 1];
        [bottomView removeFromSuperview];

        [self setupCartEmptyView];
    }
}

- (void)setupCartEmptyView {
    //默认视图背景
    UIView *backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kMSScreenWith, kMSScreenHeight - kMSNaviHight)];
    backgroundView.tag = TAG_CartEmptyView;
    [self.myTableView addSubview:backgroundView];

    //默认图片
    UIImageView *img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"cart_default_bg"]];
    img.center = CGPointMake(kMSScreenWith/2.0, backgroundView.height/2.0 - 140);
    img.bounds = CGRectMake(0, 0, 247.0/187 * 100, 100);
    [backgroundView addSubview:img];

    UILabel *warnLabel = [[UILabel alloc]init];
    warnLabel.center = CGPointMake(kMSScreenWith/2.0, backgroundView.height/2.0 - 70);
    warnLabel.bounds = CGRectMake(0, 0, kMSScreenWith, 30);
    warnLabel.textAlignment = NSTextAlignmentCenter;
    warnLabel.text = @"亲，您这里还没有任何商品！";
    warnLabel.font = [UIFont systemFontOfSize:16];
    warnLabel.textColor = [RegularExpressionsMethod ColorWithHexString:@"706F6F"];
    [backgroundView addSubview:warnLabel];

    UIButton *goShoppingButton = [[UIButton alloc] init];
    goShoppingButton.center = CGPointMake(kMSScreenWith/2.0, backgroundView.height/2.0 - 10);
    goShoppingButton.bounds = CGRectMake(0, 0, 120, 44);
    [goShoppingButton setTitle:@"去逛逛" forState:UIControlStateNormal];
    [goShoppingButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    goShoppingButton.backgroundColor = [RegularExpressionsMethod ColorWithHexString:BASEPINK];
    goShoppingButton.layer.cornerRadius = 5;
    goShoppingButton.clipsToBounds = YES;
    [goShoppingButton addTarget:self action:@selector(goShoppingBtn) forControlEvents:UIControlEventTouchUpInside];
    [backgroundView addSubview:goShoppingButton];
}
-(void)goShoppingBtn
{
    self.tabBarController.selectedIndex = 1;
}
#pragma mark --- UITableViewDataSource & UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    WJCartShopModel *model = [self.dataArray objectAtIndex:section];
    return model.goodsArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WJCartTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WJCartTableViewCell"];
    if (cell == nil) {
        cell = [[WJCartTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"WJCartTableViewCell"];
    }
   if(indexPath.row==0)
   {
       cell.imageLine.hidden = YES;
   }
    else
    {
        cell.imageLine.hidden = NO;
    }
    WJCartShopModel *shopModel = self.dataArray[indexPath.section];
    WJCartGoodsModel *model = [shopModel.goodsArray objectAtIndex:indexPath.row];

    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *uid = [[userDefaults objectForKey:@"userList"] objectForKey:@"uid" ];
    __block typeof(cell)wsCell = cell;

    [cell numberAddWithBlock:^(NSInteger number) {
        wsCell.lzNumber = number;
        model.goods_number = number;

        [shopModel.goodsArray replaceObjectAtIndex:indexPath.row withObject:model];
        if ([_selectedArray containsObject:model]) {
            [_selectedArray removeObject:model];
            [_selectedArray addObject:model];
        }
       NSMutableDictionary *infos = [NSMutableDictionary dictionary];
        [infos setObject:uid forKey:@"user_id"];
        [infos setObject:@"plus" forKey:@"op"];
        [infos setObject:@"1" forKey:@"num"];
        [infos setObject:model.rec_id forKey:@"rec_id"];
        [self changeGoodsNumberWithServer:infos];
         [self countPrice];
    }];

    [cell numberCutWithBlock:^(NSInteger number) {

        wsCell.lzNumber = number;
        model.goods_number = number;

        [shopModel.goodsArray replaceObjectAtIndex:indexPath.row withObject:model];

        //判断已选择数组里有无该对象,有就删除  重新添加
        if ([_selectedArray containsObject:model]) {
            [_selectedArray removeObject:model];
            [_selectedArray addObject:model];
            [self countPrice];
        }
        NSMutableDictionary *infos = [NSMutableDictionary dictionary];
        [infos setObject:uid forKey:@"user_id"];
        [infos setObject:@"minus" forKey:@"op"];
        [infos setObject:@"1" forKey:@"num"];
        [infos setObject:model.rec_id forKey:@"rec_id"];
        [self changeGoodsNumberWithServer:infos];
         [self countPrice];
    }];

    [cell cellSelectedWithBlock:^(BOOL select) {

        model.select = select;
        if (select) {
            [_selectedArray addObject:model];
        } else {
            [_selectedArray removeObject:model];
        }

        [self verityAllSelectState];
        [self verityGroupSelectState:indexPath.section];

        [self countPrice];
    }];

    [cell reloadDataWithModel:model];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WJGoodDetailViewController *dcVc = [[WJGoodDetailViewController alloc] init];
    WJCartShopModel *shopModel = self.dataArray[indexPath.section];
    WJCartGoodsModel *model = [shopModel.goodsArray objectAtIndex:indexPath.row];
    dcVc.goods_id = model.goods_id;
    dcVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:dcVc animated:YES];
}
-(void)processData
{
    if([[self.results objectForKey:@"code"] integerValue] == 200)
    {

    }
    else
    {
        [SVProgressHUD showErrorWithStatus:[self.results objectForKey:@"msg"]];
        [self getGoodsInfoCreatData];
        return;
    }
}
-(void)changeGoodsNumberWithServer:(NSMutableDictionary *)infos
{
    [self requestAPIWithServe:[kMSBaseMiYoMeiPortURL stringByAppendingString:kMSUpdateCartNum] andInfos:infos];
}
-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    WJCartTableHeaderView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"WJCartTableHeaderView"];
    WJCartShopModel *model = [self.dataArray objectAtIndex:section];
    NSLog(@">>>>>>%d", model.select);
    view.title = ConvertNullString(model.supplier_name);
    view.select = model.select;
    view.WJClickBlock  = ^(BOOL select) {
        model.select = select;
        if (select) {

            for (WJCartGoodsModel *good in model.goodsArray) {
                good.select = YES;
                if (![_selectedArray containsObject:good]) {

                    [_selectedArray addObject:good];
                }
            }

        } else {
            for (WJCartGoodsModel *good in model.goodsArray) {
                good.select = NO;
                if ([_selectedArray containsObject:good]) {

                    [_selectedArray removeObject:good];
                }
            }
        }

        [self verityAllSelectState];

        [tableView reloadData];
        [self countPrice];
    };
    WEAKSELF
    view.numberSelectBlock = ^{
        WJStoreInfoClassViewController *storeInfo = [[WJStoreInfoClassViewController alloc]init];
        storeInfo.storeId = model.supplier_id;
        storeInfo.storeLogo = model.supplier_logo;
        storeInfo.storeName = model.supplier_name;
        storeInfo.hidesBottomBarWhenPushed = YES;
        [weakSelf.navigationController pushViewController:storeInfo animated:YES];
        weakSelf.hidesBottomBarWhenPushed = NO;
    };
    [view.img_shopIcon sd_setImageWithURL:[NSURL URLWithString:model.supplier_logo] placeholderImage:[UIImage imageNamed:@"shop_default"] completed:nil];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return 40;
}

//section底部间距
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 5;

}
//section底部视图
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, kMSScreenWith, 5)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *uid = [[userDefaults objectForKey:@"userList"] objectForKey:@"uid" ];
    if (editingStyle == UITableViewCellEditingStyleDelete) {

        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定要删除该商品?删除后无法恢复!" preferredStyle:1];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

            WJCartShopModel *shop = [self.dataArray objectAtIndex:indexPath.section];
            WJCartGoodsModel *model = [shop.goodsArray objectAtIndex:indexPath.row];


            NSString *attString =  model.rec_id;
            [self requestDeleteAPIWithServe:[NSString stringWithFormat:@"%@/%@/%@?user_id=%@&rec_id=%@",kMSBaseMiYoMeiPortURL,kMSappVersionCode,kMSDeleteCart,uid,attString]];

            [shop.goodsArray removeObjectAtIndex:indexPath.row];
            //    删除
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];


            if (shop.goodsArray.count == 0) {
                [self.dataArray removeObjectAtIndex:indexPath.section];
                //    删除
                [tableView deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationFade];
            }

            //判断删除的商品是否已选择
            if ([_selectedArray containsObject:model]) {
                //从已选中删除,重新计算价格
                [_selectedArray removeObject:model];
                [self countPrice];
            }

            NSInteger count = 0;
            for (WJCartShopModel *shop in self.dataArray) {
                count += shop.goodsArray.count;
            }

            if (_selectedArray.count == count) {
                _allSellectedButton.selected = YES;
            } else {
                _allSellectedButton.selected = NO;
            }

            if (count == 0) {
                [self changeView];
            }
//            //如果删除的时候数据紊乱,可延迟0.5s刷新一下
//            [self performSelector:@selector(reloadTable) withObject:nil afterDelay:0.5];

        }];

        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];

        [alert addAction:okAction];
        [alert addAction:cancel];
        [self presentViewController:alert animated:YES completion:nil];
    }

}
- (void)reloadTable {
    [self.myTableView reloadData];
}
#pragma mark -- 页面按钮点击事件
#pragma mark --- 返回按钮点击事件
- (void)backButtonClick:(UIButton*)button {
    if (_isHasNavitationController == NO) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
#pragma mark --- 全选按钮点击事件
- (void)selectAllBtnClick:(UIButton*)button {
    button.selected = !button.selected;

    //点击全选时,把之前已选择的全部删除
    for (WJCartGoodsModel *model in _selectedArray) {
        model.select = NO;
    }

    [_selectedArray removeAllObjects];

    if (button.selected) {

        for (WJCartShopModel *shop in self.dataArray) {
            shop.select = YES;
            for (WJCartGoodsModel *model in shop.goodsArray) {
                model.select = YES;
                [_selectedArray addObject:model];
            }
        }

    } else {
        for (WJCartShopModel *shop in self.dataArray) {
            shop.select = NO;
            for (WJCartGoodsModel *model in shop.goodsArray) {
                model.select = NO;
            }
        }
    }

    [self.myTableView reloadData];
    [self countPrice];
}
#pragma mark --- 确认选择,提交订单按钮点击事件
- (void)goToPayButtonClick:(UIButton*)button {
    if (_selectedArray.count > 0) {
        for (WJCartGoodsModel *model in _selectedArray) {
            NSLog(@"选择的商品>>%@>>>%ld",model,(long)model.goods_number);
        }
        WJWirteOrderClassViewController *writeVC = [[WJWirteOrderClassViewController alloc]init];
        writeVC.dataArray = _selectedArray;
        writeVC.is_cart = @"1";
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:writeVC animated:YES];
        self.hidesBottomBarWhenPushed = NO;
    } else {
        [SVProgressHUD showErrorWithStatus:@"你还没有选择任何商品"];
    }

}
-(void)deleteGoodsInCart:(UIButton *)sender
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *uid = [[userDefaults objectForKey:@"userList"] objectForKey:@"uid" ];
    if (_selectedArray.count > 0) {
        NSMutableArray *arr_recId = [NSMutableArray array];
        for (WJCartGoodsModel *model in _selectedArray) {
            NSLog(@"选择的商品>>%@>>>%ld",model,(long)model.goods_number);
            [arr_recId addObject:model.rec_id];
        }
         NSString *attString =  [arr_recId componentsJoinedByString:@","];

         [self requestDeleteAPIWithServe:[NSString stringWithFormat:@"%@/%@/%@?user_id=%@&rec_id=%@",kMSBaseMiYoMeiPortURL,kMSappVersionCode,kMSDeleteCart,uid,attString]];
        
    } else {
        [SVProgressHUD showErrorWithStatus:@"你还没有选择任何商品"];
    }
}
-(void)deleteProcessData
{
    if([[self.results objectForKey:@"code"] integerValue] == 200)
    {
          [self getGoodsInfoCreatData];
    }
    else
    {
        [SVProgressHUD showErrorWithStatus:[self.results objectForKey:@"msg"]];
        return;
    }
}

- (void)verityGroupSelectState:(NSInteger)section {

    // 判断某个区的商品是否全选
    WJCartShopModel *tempShop = self.dataArray[section];
    // 是否全选标示符
    BOOL isShopAllSelect = YES;
    for (WJCartGoodsModel *model in tempShop.goodsArray) {
        // 当有一个为NO的是时候,将标示符置为NO,并跳出循环
        if (model.select == NO) {
            isShopAllSelect = NO;
            break;
        }
    }

    WJCartTableHeaderView *header = (WJCartTableHeaderView *)[self.myTableView headerViewForSection:section];
    header.select = isShopAllSelect;
    tempShop.select = isShopAllSelect;
}

- (void)verityAllSelectState {

    NSInteger count = 0;
    for (WJCartShopModel *shop in self.dataArray) {
        count += shop.goodsArray.count;
    }

    if (_selectedArray.count == count) {
        _allSellectedButton.selected = YES;
    } else {
        _allSellectedButton.selected = NO;
    }
}


#pragma mark - 消失
- (void)dealloc
{
    NSLog(@"shopCart 销毁购物车");
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
