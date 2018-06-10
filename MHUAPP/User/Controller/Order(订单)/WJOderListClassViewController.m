//
//  WJOderListClassViewController.m
//  MHUAPP
//
//  Created by jinri on 2017/12/19.
//  Copyright © 2017年 wenchengjun. All rights reserved.
//

#import "WJOderListClassViewController.h"
#import "MJRefresh.h"
#import "WJOrderListCell.h"
#import "WJOrderHeader.h"
#import "WJOrderFooter.h"

#import "WJOrderGoodListModel.h"
#import "WJOrderShangJiaHeadModel.h"
#import "WJOrderWaitPingjiaAndSuccessItem.h"


#import "AppDelegate.h"
#import "UIView+UIViewFrame.h"

#import <UIImageView+WebCache.h>
#import "WJWaitPayOrderInfoViewController.h"
#import "WJLogisticsViewController.h"
#import "WJGoodDetailViewController.h"
#import "WJWaitForGoodInfoViewController.h"
#import "WJPostBackOrderViewController.h"
#import "WJDetailedDeliveryInfoViewController.h"
#import "WJWaitCommitInfoViewController.h"
#import "WJCommitViewController.h"
#import "WJOrderSuccessViewController.h"


@interface WJOderListClassViewController ()

@property (strong , nonatomic) NSMutableArray *arr_data;
@property (strong , nonatomic) NSString *order_status;
@property (strong , nonatomic) NSString *pay_status;
@property (strong , nonatomic) NSString *shipping_status;

@property NSInteger  page_data;

@end

@implementation WJOderListClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   [self.view addSubview:self.mainTableView];
    // Do any additional setup after loading the view.
}

-(UITableView *)mainTableView
{
    if (!_mainTableView) {

        self.mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kMSScreenWith, kMSScreenHeight-kMSNaviHight-44) style:UITableViewStyleGrouped];
        self.mainTableView.backgroundColor = [UIColor clearColor];
        self.mainTableView.delegate = self;
        self.mainTableView.dataSource = self;
        [self.mainTableView registerClass:[WJOrderHeader class] forHeaderFooterViewReuseIdentifier:@"WJOrderHeader"];
        [self.mainTableView registerClass:[WJOrderListCell class] forCellReuseIdentifier:@"WJOrderListCell"];
        [self.mainTableView registerClass:[WJOrderFooter class] forHeaderFooterViewReuseIdentifier:@"WJOrderFooter"];
        self.mainTableView.alwaysBounceVertical = YES;

        // 下拉刷新
        self.mainTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRereshing)];
        [self.mainTableView.mj_header beginRefreshing];

        // 上拉刷新
        self.mainTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRereshing)];
    }
    return _mainTableView;
}
#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    [self.mainTableView.mj_header endRefreshing];
    [self.mainTableView.mj_footer endRefreshing];
    _page_data = 1;
    [self loadData];
}
-(void)noOrderListData
{
    UIView *backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kMSScreenWith, kMSScreenHeight - kMSNaviHight)];
    backgroundView.tag = 1000;
    [self.mainTableView addSubview:backgroundView];

    //默认图片
    UIImageView *img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"cart_default_bg"]];
    img.center = CGPointMake(kMSScreenWith/2.0, backgroundView.height/2.0 - 140);
    img.bounds = CGRectMake(0, 0, 247.0/187 * 100, 100);
    [backgroundView addSubview:img];

    UILabel *warnLabel = [[UILabel alloc]init];
    warnLabel.center = CGPointMake(kMSScreenWith/2.0, backgroundView.height/2.0 - 70);
    warnLabel.bounds = CGRectMake(0, 0, kMSScreenWith, 30);
    warnLabel.textAlignment = NSTextAlignmentCenter;
    warnLabel.text = @"您还没有相关订单";
    warnLabel.font = [UIFont systemFontOfSize:16];
    warnLabel.textColor = [RegularExpressionsMethod ColorWithHexString:@"706F6F"];
    [backgroundView addSubview:warnLabel];
}
- (void)footerRereshing
{
     _page_data ++;
    [self loadData];
}
#pragma mark - 初始化数组
- (NSMutableArray *)arr_data {
    if (_arr_data == nil) {
        _arr_data = [NSMutableArray arrayWithCapacity:0];
    }

    return _arr_data;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//加载数据
- (void)loadData
{
    switch (_serverType) {
        case KGetOrderServerwholeOrder:
            {
                _pay_status = @"10";
                _shipping_status= @"10";
                _order_status = @"10";
            }
            break;
         case KGetOrderListWaitPay:
        {
            _pay_status = @"0";
            _shipping_status= @"0";
            _order_status = @"1";
        }
            break;
        case KGetOrderListWaitFahuo:
        {
            _pay_status = @"2";
            _shipping_status= @"0";
            _order_status = @"1";
        }
            break;
        case KGetOrderListWaitShouhuo:
        {
            _pay_status = @"2";
            _shipping_status= @"1";
            _order_status = @"1";
        }
            break;
            case KGetOrderListTuiKuanTuihuo:
        {
               [self requestGetAPIWithServe:[NSString stringWithFormat:@"%@/%@/%@?user_id=%@",kMSBaseMiYoMeiPortURL,kMSappVersionCode,kMSGetBackGoods,[AppDelegate shareAppDelegate].user_id]];
            return;
        }
            break;
        case KGetOrderListWaitPingjia:
        {
             [self requestGetAPIWithServe:[NSString stringWithFormat:@"%@/%@/%@?user_id=%@&id=0",kMSBaseMiYoMeiPortURL,kMSappVersionCode,kMSCommentList,[AppDelegate shareAppDelegate].user_id]];
            return;
        }
            break;
            case KGetOrderListJiaoyiSuccess:
        {
            [self requestGetAPIWithServe:[NSString stringWithFormat:@"%@/%@/%@?user_id=%@&id=1",kMSBaseMiYoMeiPortURL,kMSappVersionCode,kMSCommentList,[AppDelegate shareAppDelegate].user_id]];
            return;
        }
            break;
        default:
            break;
    }
 [self requestGetAPIWithServe:[NSString stringWithFormat:@"%@/%@/%@?order_status=%@&id=%ld&pay_status=%@&shipping_status=%@&user_id=%@",kMSBaseMiYoMeiPortURL,kMSappVersionCode,kMSGetOrderStatus,_order_status,_page_data,_pay_status,_shipping_status,[AppDelegate shareAppDelegate].user_id]];

}
-(void)getProcessData
{
    [_mainTableView.mj_header endRefreshing];
    [_mainTableView.mj_footer endRefreshing];
    if([[self.results objectForKey:@"code"] integerValue] == 200)
    {

        id arr_data = [self.results objectForKey:@"data"];
        if ([arr_data isKindOfClass:[NSArray class]]) {
                    NSArray *dataArr = arr_data;
            if ([dataArr  count]<1 ) {
                        [self noOrderListData];
                        [_mainTableView.mj_footer endRefreshingWithNoMoreData];
                        return;
                }
        [_arr_data removeAllObjects];
        for (int aa=0; aa<dataArr.count; aa++) {

        if (_serverType==KGetOrderListTuiKuanTuihuo)
        {
        NSArray *arr_goods = [[dataArr objectAtIndex:aa] objectForKey:@"backGoods"];
        if (arr_goods&&arr_goods.count>0) {
                                WJOrderShangJiaHeadModel *model = [[WJOrderShangJiaHeadModel alloc]init];
                                model.supplier_name = [[dataArr objectAtIndex:aa] objectForKey:@"supplier_name"];
                                model.order_id = [[dataArr objectAtIndex:aa] objectForKey:@"order_id"];
                                model.order_sn = [[dataArr objectAtIndex:aa] objectForKey:@"order_sn"];
                                model.address = [[dataArr objectAtIndex:aa] objectForKey:@"address"];
                                model.consignee = [[dataArr objectAtIndex:aa] objectForKey:@"consignee"];
                                model.mobile = [[dataArr objectAtIndex:aa] objectForKey:@"mobile"];
                                [model configGoodsArrayWithArray:arr_goods];

                                [self.arr_data addObject:model];

                            }

        }
        else if (_serverType==KGetOrderListWaitPingjia||_serverType == KGetOrderListJiaoyiSuccess) {
        WJOrderWaitPingjiaAndSuccessItem *model = [[WJOrderWaitPingjiaAndSuccessItem alloc]init];
        model.supplier_name = [[dataArr objectAtIndex:aa] objectForKey:@"supplier_name"];
                                model.order_id = [[dataArr objectAtIndex:aa] objectForKey:@"order_id"];
                                model.supplier_id = [[dataArr objectAtIndex:aa] objectForKey:@"supplier_id"];
                                model.goods_name = [[dataArr objectAtIndex:aa] objectForKey:@"goods_name"];
                                model.goods_attr = [[dataArr objectAtIndex:aa] objectForKey:@"goods_attr"];
            model.market_price = [[dataArr objectAtIndex:aa] objectForKey:@"market_price"];
            model.count_price = [[dataArr objectAtIndex:aa] objectForKey:@"count_price"];
            model.goods_number = [NSString stringWithFormat:@"%@",[[dataArr objectAtIndex:aa] objectForKey:@"goods_number"]];
            model.img = [NSString stringWithFormat:@"%@",[[dataArr objectAtIndex:aa] objectForKey:@"img"]];
            model.goods_id = [NSString stringWithFormat:@"%@",[[dataArr objectAtIndex:aa] objectForKey:@"goods_id"]];
            model.rec_id = [NSString stringWithFormat:@"%@",[[dataArr objectAtIndex:aa] objectForKey:@"rec_id"]];
            [self.arr_data addObject:model];
            }


        }
            UIView *view = [self.view viewWithTag:1000];
            [view removeFromSuperview];
            [_mainTableView reloadData];
            [_mainTableView.mj_header endRefreshing];
            [_mainTableView.mj_footer endRefreshing];
            [_mainTableView.mj_footer endRefreshingWithNoMoreData];
                }
        else  if ([arr_data isKindOfClass:[NSDictionary class]])
        {
            NSArray *dataArr = [arr_data objectForKey:@"data"];
            if ([dataArr  count]<1 ) {
                [self noOrderListData];
                [_mainTableView.mj_footer endRefreshingWithNoMoreData];
                return;
            }
            NSMutableArray *arr_Datalist = [NSMutableArray array];
            for (int aa=0; aa<dataArr.count; aa++) {

             NSArray *arr_goods = [[dataArr objectAtIndex:aa] objectForKey:@"order_info"];
            if (arr_goods&&arr_goods.count>0) {
                WJOrderShangJiaHeadModel *model = [[WJOrderShangJiaHeadModel alloc]init];
                model.supplier_id = [[dataArr objectAtIndex:aa] objectForKey:@"supplier_id"];
                model.is_group_buy = [[dataArr objectAtIndex:aa] objectForKey:@"is_group_buy"];
                model.referer = [[dataArr objectAtIndex:aa] objectForKey:@"referer"];
                model.order_id = [[dataArr objectAtIndex:aa] objectForKey:@"order_id"];
                model.order_sn = [[dataArr objectAtIndex:aa] objectForKey:@"order_sn"];
                model.pay_status = [[dataArr objectAtIndex:aa] objectForKey:@"pay_status"];
                model.shipping_status = [[dataArr objectAtIndex:aa] objectForKey:@"shipping_status"];
                model.goods_amount = [[dataArr objectAtIndex:aa] objectForKey:@"goods_amount"];
                model.address = [[dataArr objectAtIndex:aa] objectForKey:@"address"];
                model.consignee = [[dataArr objectAtIndex:aa] objectForKey:@"consignee"];
                model.mobile = [[dataArr objectAtIndex:aa] objectForKey:@"mobile"];
                [model configGoodsArrayWithArray:arr_goods];

                [arr_Datalist addObject:model];
               }
            }
            if(_page_data==1)
            {
                [_arr_data removeAllObjects];
                _arr_data= arr_Datalist;
            }else
            {
                [_arr_data addObjectsFromArray:arr_Datalist];
            }

                UIView *view = [self.view viewWithTag:1000];
                [view removeFromSuperview];
                [self.mainTableView reloadData];
                [self.mainTableView.mj_header endRefreshing];
                if(dataArr.count<[kMSPULLtableViewCellNumber integerValue])
                {
                    [_mainTableView.mj_footer endRefreshingWithNoMoreData];
                }
                else{
                    _mainTableView.mj_footer.hidden = NO;
                }

            }
            else
            {
                [self noOrderListData];
                [self.mainTableView reloadData];
                return;
            }

    }
    else
    {
        [self.mainTableView.mj_header endRefreshing];
        return;
    }
}




#pragma mark --- UITableViewDataSource & UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if(_serverType ==KGetOrderListWaitPingjia||_serverType == KGetOrderListJiaoyiSuccess)
    {
        return 1;
    }
    WJOrderShangJiaHeadModel *model = [self.arr_data objectAtIndex:section];
    return model.goodsArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return self.arr_data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WJOrderListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WJOrderListCell"];
    if (cell == nil) {
        cell = [[WJOrderListCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"WJOrderListCell"];
    }
    if(indexPath.row==0)
    {
        cell.imageLine.hidden = YES;
    }
    else
    {
        cell.imageLine.hidden = NO;
    }

    if(_serverType ==KGetOrderListTuiKuanTuihuo)
    {
        WJOrderShangJiaHeadModel *shopModel = self.arr_data[indexPath.section];
        WJOrderGoodListModel *model = [shopModel.goodsArray objectAtIndex:indexPath.row];
        [cell.contentImg sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:[UIImage imageNamed:@"home_banner_img.png"] completed:nil];
        NSString * price = [NSString stringWithFormat:@"￥%@",model.back_goods_price];

        CGFloat width = [RegularExpressionsMethod widthOfString:price font:Font(14) height:23];
        cell.price.frame = CGRectMake(kMSScreenWith-width-10, 5, width, 23);
        cell.price.text = price;


        cell.title.text = model.goods_name;
        cell.title.frame = CGRectMake(TAG_Height+DCMargin, 5, kMSScreenWith- DCMargin * 4-TAG_Height-width, 40);

        NSString *saleCount = [NSString stringWithFormat:@"%@",model.goods_attr];
        cell.type.text  = saleCount;
        cell.type.frame = CGRectMake(TAG_Height+DCMargin, cell.title.Bottom+5, cell.title.width, 20);

        cell.Num.frame =CGRectMake(kMSScreenWith-width-10, cell.oldprice.Bottom+5, width, 20);
        cell.Num.text =  [NSString stringWithFormat:@"x%@",model.back_goods_number];
    }
   else if(_serverType ==KGetOrderListWaitPingjia||_serverType == KGetOrderListJiaoyiSuccess)
    {
        WJOrderWaitPingjiaAndSuccessItem *item = self.arr_data[indexPath.section];
         cell.item = item;
    }
    else
    {
        WJOrderShangJiaHeadModel *shopModel = self.arr_data[indexPath.section];
        WJOrderGoodListModel *model = [shopModel.goodsArray objectAtIndex:indexPath.row];
        model.is_group_buy = shopModel.is_group_buy;
        cell.listModel = model;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    if(_serverType ==KGetOrderListTuiKuanTuihuo)
    {

    }
    else if(_serverType ==KGetOrderListWaitPingjia)
    {
         WJOrderWaitPingjiaAndSuccessItem *model = [_arr_data objectAtIndex:indexPath.section];
        WJWaitCommitInfoViewController *waitCommit = [[WJWaitCommitInfoViewController alloc]init];
        waitCommit.supplier_name = model.supplier_name;
        waitCommit.img = model.img;
        waitCommit.order_id = model.order_id;;
        waitCommit.supplier_id = model.supplier_id;
        waitCommit.goods_name = model.goods_name;
        waitCommit.goods_attr = model.goods_attr;
        waitCommit.market_price = model.market_price;
        waitCommit.count_price = model.count_price;
        waitCommit.goods_number = [NSString stringWithFormat:@"%@",model.goods_number];
        waitCommit.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:waitCommit animated:YES];
        self.hidesBottomBarWhenPushed = YES;
    }
    else if(_serverType ==KGetOrderListJiaoyiSuccess)
    {
        WJOrderWaitPingjiaAndSuccessItem *model = [_arr_data objectAtIndex:indexPath.section];
        WJOrderSuccessViewController *waitCommit = [[WJOrderSuccessViewController alloc]init];
        waitCommit.supplier_name = model.supplier_name;
        waitCommit.img = model.img;
        waitCommit.order_id = model.order_id;;
        waitCommit.supplier_id = model.supplier_id;
        waitCommit.goods_name = model.goods_name;
        waitCommit.goods_attr = model.goods_attr;
        waitCommit.market_price = model.market_price;
        waitCommit.count_price = model.count_price;
        waitCommit.goods_number = [NSString stringWithFormat:@"%@",model.goods_number];
        waitCommit.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:waitCommit animated:YES];
        self.hidesBottomBarWhenPushed = YES;
    }
    else
    {
         WJOrderShangJiaHeadModel *model = [self.arr_data objectAtIndex:indexPath.section];
    NSInteger paySt = [model.pay_status integerValue];
    switch (paySt) {
        case 0:
        {
            WJWaitPayOrderInfoViewController *waitPayInfoVC = [[WJWaitPayOrderInfoViewController alloc]init];
            WJOrderShangJiaHeadModel *shopModel = self.arr_data[indexPath.section];
            waitPayInfoVC.str_orderId = shopModel.order_sn;
            waitPayInfoVC.str_Name = shopModel.consignee;
            waitPayInfoVC.str_telephone = shopModel.mobile;
            waitPayInfoVC.str_address = shopModel.address;
            waitPayInfoVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:waitPayInfoVC animated:YES];
            self.hidesBottomBarWhenPushed = YES;
        }
            break;
        case 1:
        {

        }
            break;
        case 2:
        {
            NSInteger shipSt = [model.shipping_status integerValue];
            switch (shipSt) {
                case 0:
                {
//                    view.state.text = @"未发货";
                    WJDetailedDeliveryInfoViewController *waitPayInfoVC = [[WJDetailedDeliveryInfoViewController alloc]init];
                    WJOrderShangJiaHeadModel *shopModel = self.arr_data[indexPath.section];
                    waitPayInfoVC.str_orderId = shopModel.order_sn;
                    waitPayInfoVC.str_Name = shopModel.consignee;
                    waitPayInfoVC.str_telephone = shopModel.mobile;
                    waitPayInfoVC.str_address = shopModel.address;
                    waitPayInfoVC.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:waitPayInfoVC animated:YES];
                    self.hidesBottomBarWhenPushed = YES;
                }
                    break;
                case 1:
                {
                    WJWaitForGoodInfoViewController *waitPayInfoVC = [[WJWaitForGoodInfoViewController alloc]init];
                    WJOrderShangJiaHeadModel *shopModel = self.arr_data[indexPath.section];
                    waitPayInfoVC.str_orderId = shopModel.order_sn;
                    waitPayInfoVC.str_Name = shopModel.consignee;
                    waitPayInfoVC.str_telephone = shopModel.mobile;
                    waitPayInfoVC.str_address = shopModel.address;
                    waitPayInfoVC.shipping_name = shopModel.shipping_name;
                    waitPayInfoVC.invoice_no = shopModel.invoice_no;
                    waitPayInfoVC.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:waitPayInfoVC animated:YES];
                    self.hidesBottomBarWhenPushed = YES;
                }
                    break;
                case 2:
                {
//                    view.state.text = @"已收货";
                }
                    break;
                case 3:
                {
//                    view.state.text = @"退货";
                }
                    break;
                default:
                    break;
            }
        }
            break;

        default:
            break;
    }
    }

}



- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    WJOrderHeader *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"WJOrderHeader"];

    if(_serverType ==KGetOrderListTuiKuanTuihuo)
    {
         WJOrderShangJiaHeadModel *shopmodel = [_arr_data objectAtIndex:section];
          WJOrderGoodListModel *model = [shopmodel.goodsArray objectAtIndex:0];
        view.shangjiaTitle =  [NSString stringWithFormat:@"%@ >",ConvertNullString(shopmodel.supplier_name)];
        NSInteger status_refund = [model.status_refund integerValue];
        switch (status_refund) {
            case 1:
            {
                view.state.text = @"已退款";
            }
                break;

            case 0:
            {
                NSInteger shipSt = [model.status_back integerValue];
                switch (shipSt) {
                    case 0:
                    {
                        view.state.text = @"审核通过";
                    }
                        break;
                    case 1:
                    {
                        view.state.text = @"收到寄回商品";
                    }
                        break;
                    case 2:
                    {
                        view.state.text = @"换回商品已寄出";
                    }
                        break;
                    case 3:
                    {
                        view.state.text = @"完成退货/返修";
                    }
                        break;
                    case 4:
                    {
                        view.state.text = @"退款(无需退货)";
                    }
                        break;
                    case 5:
                    {
                        view.state.text = @"审核中";
                    }
                        break;
                    case 6:
                    {
                        view.state.text = @"申请被拒绝";
                    }
                        break;
                    case 7:
                    {
                        view.state.text = @"管理员取消";
                    }
                        break;
                    case 8:
                    {
                        view.state.text = @"用户自己取消";
                    }
                        break;
                    default:
                        break;
                }
            }
                break;

            default:
                break;
        }
    }
    else if(_serverType ==KGetOrderListWaitPingjia||_serverType == KGetOrderListJiaoyiSuccess)
    {

        if(_serverType ==KGetOrderListWaitPingjia)
        {
        WJOrderWaitPingjiaAndSuccessItem *item = _arr_data[section];
          view.shangjiaTitle = item.supplier_name;
           view.state.text = @"待评价";
        }
        else
           view.state.text = @"已完成";
    }
    else
    {
         WJOrderShangJiaHeadModel *shopmodel = [_arr_data objectAtIndex:section];
    view.shangjiaTitle =  [NSString stringWithFormat:@"%@ >",ConvertNullString(shopmodel.referer)];
    NSInteger paySt = [shopmodel.pay_status integerValue];
    switch (paySt) {
        case 0:
            {
                view.state.text = @"待付款";
            }
            break;
        case 1:
        {
            view.state.text = @"付款中";
        }
            break;
        case 2:
        {
            NSInteger shipSt = [shopmodel.shipping_status integerValue];
            switch (shipSt) {
                case 0:
                    {
                       view.state.text = @"未发货";
                    }
                    break;
                case 1:
                {
                    view.state.text = @"已发货";
                }
                    break;
                case 2:
                {
                    view.state.text = @"已收货";
                }
                    break;
                case 4:
                {
                    view.state.text = @"退货";
                }
                    break;
                default:
                    break;
            }
        }
            break;

        default:
            break;
    }
    }
    return view;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    WJOrderFooter *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"WJOrderFooter"];

    if(_serverType ==KGetOrderListTuiKuanTuihuo)
    {
        WJOrderShangJiaHeadModel *model = [self.arr_data objectAtIndex:section];
        WJOrderGoodListModel *listmodel = [model.goodsArray objectAtIndex:0];
        view.totalPayPrice.text = [NSString stringWithFormat:@"共%ld件商品 合计：￥%@",model.goodsArray.count,listmodel.back_goods_price];
        view.orderType = 8;
    }
    else if(_serverType ==KGetOrderListWaitPingjia||_serverType == KGetOrderListJiaoyiSuccess)
    {
        WJOrderWaitPingjiaAndSuccessItem *item = self.arr_data[section];
        view.totalPayPrice.text = [NSString stringWithFormat:@"共%@件商品 合计：￥%@",@"1",item.count_price];
        if(_serverType ==KGetOrderListWaitPingjia)
            view.orderType = 6;
        else
            view.orderType = 7;

        view.ClickStateForStrBlock = ^(NSString *stateStr) {
            WEAKSELF
            if ([stateStr isEqualToString:@"去评价"]) {
                WJCommitViewController *waitPayInfoVC = [[WJCommitViewController alloc]init];
                waitPayInfoVC.goods_id = item.goods_id;
                waitPayInfoVC.rec_id = item.rec_id;
                waitPayInfoVC.hidesBottomBarWhenPushed = YES;
                [weakSelf.navigationController pushViewController:waitPayInfoVC animated:YES];
                weakSelf.hidesBottomBarWhenPushed = YES;
            }
        };
    }
    else
    {
        WJOrderShangJiaHeadModel *model = [self.arr_data objectAtIndex:section];
        WJOrderGoodListModel *listmodel = [model.goodsArray objectAtIndex:0];
      view.totalPayPrice.text = [NSString stringWithFormat:@"共%ld件商品 合计：￥%@",model.goodsArray.count,model.goods_amount];
    NSInteger paySt = [model.pay_status integerValue];
    switch (paySt) {
        case 0:
        {
            view.orderType = 0;
        }
            break;
        case 1:
        {
            view.orderType = 0;
        }
            break;
        case 2:
        {
            NSInteger shipSt = [model.shipping_status integerValue];
            switch (shipSt) {
                case 0:
                {
                   view.orderType = 1;
                }
                    break;
                case 1:
                {
                    view.orderType = 2;
                }
                    break;
                case 2:
                {
                    view.orderType = 3;
                }
                    break;
                case 3:
                {
                    view.orderType = 4;
                }
                    break;
                default:
                    break;
            }
        }
            break;

        default:
            break;
    }
        view.ClickStateForStrBlock = ^(NSString *stateStr) {
            WEAKSELF
            if ([stateStr isEqualToString:@"查看物流"]) {
                WJLogisticsViewController *waitPayInfoVC = [[WJLogisticsViewController alloc]init];
                waitPayInfoVC.invoice_no = model.invoice_no;
                waitPayInfoVC.shipping_name = model.shipping_name;
                waitPayInfoVC.hidesBottomBarWhenPushed = YES;
                [weakSelf.navigationController pushViewController:waitPayInfoVC animated:YES];
            }
            else  if ([stateStr isEqualToString:@"立即支付"]) {
                WJWaitPayOrderInfoViewController *waitPayInfoVC = [[WJWaitPayOrderInfoViewController alloc]init];
                waitPayInfoVC.str_Name = model.consignee;
                waitPayInfoVC.str_address = model.address;
                waitPayInfoVC.str_telephone = model.mobile;
                waitPayInfoVC.str_orderId = model.order_sn;
                waitPayInfoVC.hidesBottomBarWhenPushed = YES;
                [weakSelf.navigationController pushViewController:waitPayInfoVC animated:YES];
            }
            else  if ([stateStr isEqualToString:@"再次购买"]) {
                WJGoodDetailViewController *waitPayInfoVC = [[WJGoodDetailViewController alloc]init];
                waitPayInfoVC.goods_id = listmodel.goods_id;
                waitPayInfoVC.hidesBottomBarWhenPushed = YES;
                [weakSelf.navigationController pushViewController:waitPayInfoVC animated:YES];
            }
            else  if ([stateStr isEqualToString:@"我要催单"]) {
                [self jxt_showAlertWithTitle:@"已通知卖家发货" message:@"请耐心等待" appearanceProcess:^(JXTAlertController * _Nonnull alertMaker) {
                    alertMaker.
                    addActionCancelTitle(@"确认");
                } actionsBlock:^(NSInteger buttonIndex, UIAlertAction * _Nonnull action, JXTAlertController * _Nonnull alertSelf) {
                    if (buttonIndex == 0) {
                        NSLog(@"cancel");
                    }
                }];
            }
            else  if ([stateStr isEqualToString:@"我要退款"]) {
                WJPostBackOrderViewController *waitPayInfoVC = [[WJPostBackOrderViewController alloc]init];
                waitPayInfoVC.str_goodsId = listmodel.rec_id;
                waitPayInfoVC.str_price = listmodel.count_price;
                waitPayInfoVC.str_oldprice = listmodel.market_price;
                waitPayInfoVC.str_title = listmodel.goods_name;
                waitPayInfoVC.str_Num = [NSString stringWithFormat:@"%ld",listmodel.goods_number];
                waitPayInfoVC.str_contentImg = listmodel.img;
                waitPayInfoVC.str_order_id = listmodel.order_id;
                waitPayInfoVC.str_type = listmodel.goods_attr;
                waitPayInfoVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:waitPayInfoVC animated:YES];
            }
            else  if ([stateStr isEqualToString:@"确认收货"]) {
                [self jxt_showAlertWithTitle:nil message:@"已收到货？" appearanceProcess:^(JXTAlertController * _Nonnull alertMaker) {
                    alertMaker.
                    addActionCancelTitle(@"取消").
                    addActionDestructiveTitle(@"已收货");
                } actionsBlock:^(NSInteger buttonIndex, UIAlertAction * _Nonnull action, JXTAlertController * _Nonnull alertSelf) {
                    if ([action.title isEqualToString:@"取消"]) {
                        NSLog(@"cancel");
                    }
                    else if ([action.title isEqualToString:@"已收货"]) {
                        [self postbackOderData:model.order_sn];
                    }
                }];
            }
             };
    }



    return view;
}

-(void)postbackOderData:(NSString *)order_sn
{
    NSMutableDictionary *infos = [NSMutableDictionary dictionary];
    [infos setValue:[AppDelegate shareAppDelegate].user_id forKey:@"user_id"];
    [infos setValue:order_sn forKey:@"id"];
    [self requestAPIWithServe:[kMSBaseMiYoMeiPortURL stringByAppendingString:kMSMiYoMeiAffirmGoods] andInfos:infos];
}

-(void)processData
{
    if([[self.results objectForKey:@"code"] integerValue] == 200)
    {
        [SVProgressHUD showSuccessWithStatus:@"收货成功~"];
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        [SVProgressHUD dismissWithDelay:1.0];
        [self performSelector:@selector(delayMethod) withObject:nil/*可传任意类型参数*/ afterDelay:2.0];

    }
    else
    {
        [self requestFailed:@"确认收货失败"];
    }
}
-(void)delayMethod
{
    _page_data = 1;
    [self loadData];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return 45;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 62;
}

- (void)firstLoadViewRefresh
{
    [self.mainTableView.mj_footer endRefreshing];
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
