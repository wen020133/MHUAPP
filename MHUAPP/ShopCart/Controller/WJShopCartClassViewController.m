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

#define  TAG_CartEmptyView 100
static NSInteger lz_CartRowHeight = 100;

@interface WJShopCartClassViewController ()


@property (strong,nonatomic)NSMutableArray *dataArray;
@property (strong,nonatomic)NSMutableArray *selectedArray;
@property (strong,nonatomic)UITableView *myTableView;
@property (strong,nonatomic)UIButton *allSellectedButton;
@property (strong,nonatomic)UILabel *totlePriceLabel;

@end

@implementation WJShopCartClassViewController

#pragma mark - viewController life cicle
- (void)viewWillAppear:(BOOL)animated {

    //当进入购物车的时候判断是否有已选择的商品,有就清空
    //主要是提交订单后再返回到购物车,如果不清空,还会显示
    if (self.selectedArray.count > 0) {
        for (WJCartGoodsModel *model in self.selectedArray) {
            model.select = NO;//这个其实有点多余,提交订单后的数据源不会包含这些,保险起见,加上了
        }
        [self.selectedArray removeAllObjects];
    }

    //初始化显示状态
    _allSellectedButton.selected = NO;
    _totlePriceLabel.attributedText = [self LZSetString:@"￥0.00"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [RegularExpressionsMethod ColorWithHexString:kMSVCBackgroundColor];

    [self performSelector:@selector(loadData) withObject:nil afterDelay:1];
    self.selectedState = NO;

    [self setupCustomNavigationBar];
    if (self.dataArray.count > 0) {

        [self setupCartView];
    } else {
        [self setupCartEmptyView];
    }
    // Do any additional setup after loading the view.
}
- (void)loadData {
    [self creatData];
    [self changeView];
}
-(void)creatData {

    NSString *path = [[NSBundle mainBundle] pathForResource:@"ShopCarNew" ofType:@"plist" inDirectory:nil];

    NSDictionary *dic = [[NSDictionary alloc]initWithContentsOfFile:path];
    NSLog(@"%@",dic);
    NSArray *array = [dic objectForKey:@"data"];
    if (array.count > 0) {
        for (NSDictionary *dic in array) {
            WJCartShopModel *model = [[WJCartShopModel alloc]init];
            model.shopID = [dic objectForKey:@"id"];
            model.shopName = [dic objectForKey:@"shopName"];
            model.sID = [dic objectForKey:@"sid"];
            [model configGoodsArrayWithArray:[dic objectForKey:@"items"]];

            [self.dataArray addObject:model];
        }
    }
}

-(void)countPrice {
    double totlePrice = 0.0;

    for (WJCartGoodsModel *model in self.selectedArray) {

        double price = [model.price doubleValue];

        totlePrice += price * model.count;
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

- (NSMutableArray *)selectedArray {
    if (_selectedArray == nil) {
        _selectedArray = [NSMutableArray arrayWithCapacity:0];
    }

    return _selectedArray;
}

#pragma mark - 布局页面视图
#pragma mark -- 自定义导航
- (void)setupCustomNavigationBar {

    if (self.isHasTabBarController) {
         [self initSendReplyWithTitle:@"购物车" andLeftButtonName:nil andRightButtonName:@"编辑" andTitleLeftOrRight:NO];
    }
    else
    {
        [self initSendReplyWithTitle:@"购物车" andLeftButtonName:@"ic_back.png" andRightButtonName:@"编辑" andTitleLeftOrRight:NO];
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

    if(self.isHasTabBarController)
    {
        if(self.selectedState)
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
        if(self.selectedState)
        {
            [self initSendReplyWithTitle:@"购物车" andLeftButtonName:nil andRightButtonName:@"编辑" andTitleLeftOrRight:NO];
        }
        else
        {
            [self initSendReplyWithTitle:@"购物车" andLeftButtonName:nil andRightButtonName:@"完成" andTitleLeftOrRight:NO];
        }
    }

    [self.infoTableView reloadData];
}
#pragma mark -- 自定义底部视图
- (void)setupCustomBottomView {

    UIView *backgroundView = [[UIView alloc]init];
    backgroundView.backgroundColor = kMSCellBackColor;
    backgroundView.tag = TAG_CartEmptyView + 1;
    [self.view addSubview:backgroundView];

    //当有tabBarController时,在tabBar的上面
    if (_isHasTabBarController == YES) {
        backgroundView.frame = CGRectMake(0, kMSScreenHeight -  2*49-kMSNaviHight, kMSScreenWith, 49);
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
        if (view != nil) {
            [view removeFromSuperview];
        }

        [self setupCartView];
    } else {
        UIView *bottomView = [self.view viewWithTag:TAG_CartEmptyView + 1];
        [bottomView removeFromSuperview];

        [self.myTableView removeFromSuperview];
        self.myTableView = nil;
        [self setupCartEmptyView];
    }
}

- (void)setupCartEmptyView {
    //默认视图背景
    UIView *backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, kMSNaviHight, kMSScreenWith, kMSScreenHeight - kMSNaviHight)];
    backgroundView.tag = TAG_CartEmptyView;
    [self.view addSubview:backgroundView];

    //默认图片
    UIImageView *img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"cart_default_bg"]];
    img.center = CGPointMake(kMSScreenWith/2.0, kMSScreenHeight/2.0 - 120);
    img.bounds = CGRectMake(0, 0, 247.0/187 * 100, 100);
    [backgroundView addSubview:img];

    UILabel *warnLabel = [[UILabel alloc]init];
    warnLabel.center = CGPointMake(kMSScreenWith/2.0, kMSScreenHeight/2.0 - 10);
    warnLabel.bounds = CGRectMake(0, 0, kMSScreenWith, 30);
    warnLabel.textAlignment = NSTextAlignmentCenter;
    warnLabel.text = @"购物车为空!";
    warnLabel.font = [UIFont systemFontOfSize:15];
    warnLabel.textColor = [RegularExpressionsMethod ColorWithHexString:@"706F6F"];
    [backgroundView addSubview:warnLabel];
}
#pragma mark -- 购物车有商品时的视图
- (void)setupCartView {
    //创建底部视图
    [self setupCustomBottomView];

    UITableView *table = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];

    table.delegate = self;
    table.dataSource = self;

    table.rowHeight = lz_CartRowHeight;
    table.separatorStyle = UITableViewCellSeparatorStyleNone;
    table.backgroundColor = kMSColorFromRGB(245, 246, 248);
    [self.view addSubview:table];
    self.myTableView = table;

    if (_isHasTabBarController) {
        table.frame = CGRectMake(0, 0, kMSScreenWith, kMSScreenHeight - kMSNaviHight - 2*49);
    } else {
        table.frame = CGRectMake(0, 0, kMSScreenWith, kMSScreenHeight - kMSNaviHight - 49);
    }

    [table registerClass:[WJCartTableHeaderView class] forHeaderFooterViewReuseIdentifier:@"WJCartTableHeaderView"];
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

    __block typeof(cell)wsCell = cell;

    [cell numberAddWithBlock:^(NSInteger number) {
        wsCell.lzNumber = number;
        model.count = number;

        [shopModel.goodsArray replaceObjectAtIndex:indexPath.row withObject:model];
        if ([self.selectedArray containsObject:model]) {
            [self.selectedArray removeObject:model];
            [self.selectedArray addObject:model];
            [self countPrice];
        }
    }];

    [cell numberCutWithBlock:^(NSInteger number) {

        wsCell.lzNumber = number;
        model.count = number;

        [shopModel.goodsArray replaceObjectAtIndex:indexPath.row withObject:model];

        //判断已选择数组里有无该对象,有就删除  重新添加
        if ([self.selectedArray containsObject:model]) {
            [self.selectedArray removeObject:model];
            [self.selectedArray addObject:model];
            [self countPrice];
        }
    }];

    [cell cellSelectedWithBlock:^(BOOL select) {

        model.select = select;
        if (select) {
            [self.selectedArray addObject:model];
        } else {
            [self.selectedArray removeObject:model];
        }

        [self verityAllSelectState];
        [self verityGroupSelectState:indexPath.section];

        [self countPrice];
    }];

    [cell reloadDataWithModel:model];
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    WJCartTableHeaderView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"WJCartTableHeaderView"];
    WJCartShopModel *model = [self.dataArray objectAtIndex:section];
    NSLog(@">>>>>>%d", model.select);
    view.title = model.shopName;
    view.select = model.select;
    view.WJClickBlock  = ^(BOOL select) {
        model.select = select;
        if (select) {

            for (WJCartGoodsModel *good in model.goodsArray) {
                good.select = YES;
                if (![self.selectedArray containsObject:good]) {

                    [self.selectedArray addObject:good];
                }
            }

        } else {
            for (WJCartGoodsModel *good in model.goodsArray) {
                good.select = NO;
                if ([self.selectedArray containsObject:good]) {

                    [self.selectedArray removeObject:good];
                }
            }
        }

        [self verityAllSelectState];

        [tableView reloadData];
        [self countPrice];
    };

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

    if (editingStyle == UITableViewCellEditingStyleDelete) {

        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定要删除该商品?删除后无法恢复!" preferredStyle:1];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

            WJCartShopModel *shop = [self.dataArray objectAtIndex:indexPath.section];
            WJCartGoodsModel *model = [shop.goodsArray objectAtIndex:indexPath.row];

            [shop.goodsArray removeObjectAtIndex:indexPath.row];
            //    删除
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];

            if (shop.goodsArray.count == 0) {
                [self.dataArray removeObjectAtIndex:indexPath.section];
            }

            //判断删除的商品是否已选择
            if ([self.selectedArray containsObject:model]) {
                //从已选中删除,重新计算价格
                [self.selectedArray removeObject:model];
                [self countPrice];
            }

            NSInteger count = 0;
            for (WJCartShopModel *shop in self.dataArray) {
                count += shop.goodsArray.count;
            }

            if (self.selectedArray.count == count) {
                _allSellectedButton.selected = YES;
            } else {
                _allSellectedButton.selected = NO;
            }

            if (count == 0) {
                [self changeView];
            }

            //如果删除的时候数据紊乱,可延迟0.5s刷新一下
            [self performSelector:@selector(reloadTable) withObject:nil afterDelay:0.5];

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
    for (WJCartGoodsModel *model in self.selectedArray) {
        model.select = NO;
    }

    [self.selectedArray removeAllObjects];

    if (button.selected) {

        for (WJCartShopModel *shop in self.dataArray) {
            shop.select = YES;
            for (WJCartGoodsModel *model in shop.goodsArray) {
                model.select = YES;
                [self.selectedArray addObject:model];
            }
        }

    } else {
        for (WJCartShopModel *shop in self.dataArray) {
            shop.select = NO;
        }
    }

    [self.myTableView reloadData];
    [self countPrice];
}
#pragma mark --- 确认选择,提交订单按钮点击事件
- (void)goToPayButtonClick:(UIButton*)button {
    if (self.selectedArray.count > 0) {
        for (WJCartGoodsModel *model in self.selectedArray) {
            NSLog(@"选择的商品>>%@>>>%ld",model,(long)model.count);
        }
    } else {
        NSLog(@"你还没有选择任何商品");
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

    if (self.selectedArray.count == count) {
        _allSellectedButton.selected = YES;
    } else {
        _allSellectedButton.selected = NO;
    }
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
