//
//  WJIntegralOrderListViewController.m
//  MHUAPP
//
//  Created by wenchengjun on 2018/5/19.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import "WJIntegralOrderListViewController.h"
#import "WJOrderListCell.h"
#import "WJOrderFooter.h"

#import "WJOrderGoodListModel.h"
#import "WJOrderShangJiaHeadModel.h"

#import "AppDelegate.h"
#import "UIView+UIViewFrame.h"

#import "WJLogisticsViewController.h"

@interface WJIntegralOrderListViewController ()

@property (strong , nonatomic) NSMutableArray *arr_data;

@end

@implementation WJIntegralOrderListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSendReplyWithTitle:@"积分纪录" andLeftButtonName:@"ic_back.png" andRightButtonName:nil andTitleLeftOrRight:YES];
    self.view.backgroundColor = [RegularExpressionsMethod ColorWithHexString:kMSVCBackgroundColor];
    [self loadData];
    [self.view addSubview:self.mainTableView];
    // Do any additional setup after loading the view.
}
-(UITableView *)mainTableView
{
    if (!_mainTableView) {

        self.mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kMSScreenWith, kMSScreenHeight-kMSNaviHight) style:UITableViewStyleGrouped];
        self.mainTableView.backgroundColor = [UIColor clearColor];
        self.mainTableView.delegate = self;
        self.mainTableView.dataSource = self;
        [self.mainTableView registerClass:[WJOrderListCell class] forCellReuseIdentifier:@"WJOrderListCell"];
        [self.mainTableView registerClass:[WJOrderFooter class] forHeaderFooterViewReuseIdentifier:@"WJOrderFooter"];

//        // 下拉刷新
//        self.mainTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRereshing)];
//        [self.mainTableView.mj_header beginRefreshing];
//
//        // 上拉刷新
//        self.mainTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRereshing)];
    }
    return _mainTableView;
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

    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *uid = [[userDefaults objectForKey:@"userList"] objectForKey:@"uid" ];
    [self requestGetAPIWithServe:[NSString stringWithFormat:@"%@/%@/%@?user_id=%@",kMSBaseMiYoMeiPortURL,kMSappVersionCode,kMSGetOrderIntegral,uid]];

}
-(void)getProcessData
{
    if([[self.results objectForKey:@"code"] integerValue] == 200)
    {

        [self.arr_data removeAllObjects];
        id arr_data = [self.results objectForKey:@"data"];
        if ([arr_data isKindOfClass:[NSArray class]]) {
            NSArray *dataArr = arr_data;
            if ([dataArr  count]<1 ) {
                [self noOrderListData];
                [self.mainTableView reloadData];
                return;
            }

            for (int aa=0; aa<dataArr.count; aa++) {
                NSArray *arr_goods = [[dataArr objectAtIndex:aa] objectForKey:@"order_info"];
                if (arr_goods&&arr_goods.count>0) {
                    WJOrderShangJiaHeadModel *model = [[WJOrderShangJiaHeadModel alloc]init];
                    model.supplier_id = [[dataArr objectAtIndex:aa] objectForKey:@"supplier_id"];
                    model.referer = [[dataArr objectAtIndex:aa] objectForKey:@"referer"];
                    model.order_id = [[dataArr objectAtIndex:aa] objectForKey:@"order_id"];
                     model.is_group_buy = [[dataArr objectAtIndex:aa] objectForKey:@"is_group_buy"];
                    model.order_sn = [[dataArr objectAtIndex:aa] objectForKey:@"order_sn"];
                    model.pay_status = [[dataArr objectAtIndex:aa] objectForKey:@"pay_status"];
                    model.shipping_status = [[dataArr objectAtIndex:aa] objectForKey:@"shipping_status"];
                    model.goods_amount = [[dataArr objectAtIndex:aa] objectForKey:@"goods_amount"];
                    model.address = [[dataArr objectAtIndex:aa] objectForKey:@"address"];
                    model.consignee = [[dataArr objectAtIndex:aa] objectForKey:@"consignee"];
                    model.mobile = [[dataArr objectAtIndex:aa] objectForKey:@"mobile"];
                    [model configGoodsArrayWithArray:arr_goods];

                    [self.arr_data addObject:model];

                }

                UIView *view = [self.view viewWithTag:1000];
                [view removeFromSuperview];
                [self.mainTableView reloadData];
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
        return;
    }
}




#pragma mark --- UITableViewDataSource & UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

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
    WJOrderShangJiaHeadModel *shopModel = self.arr_data[indexPath.section];
    WJOrderGoodListModel *model = [shopModel.goodsArray objectAtIndex:indexPath.row];
    model.is_group_buy = shopModel.is_group_buy;
    cell.listModel = model;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

//    WJOrderShangJiaHeadModel *shopModel = self.arr_data[indexPath.section];
//            waitPayInfoVC.str_orderId = shopModel.order_sn;
//            waitPayInfoVC.str_Name = shopModel.referer;
//            waitPayInfoVC.str_telephone = shopModel.mobile;
//            waitPayInfoVC.str_address = shopModel.address;
//            waitPayInfoVC.hidesBottomBarWhenPushed = YES;

}


- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    WJOrderFooter *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"WJOrderFooter"];
    WJOrderShangJiaHeadModel *model = [self.arr_data objectAtIndex:section];
    view.totalPayPrice.text = [NSString stringWithFormat:@"共%ld件商品 合计：%@积分",model.goodsArray.count,model.goods_amount];

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

    view.ClickStateForStrBlock = ^(NSString *stateStr) {
        WEAKSELF
    if ([stateStr isEqualToString:@"查看物流"]) {
        WJLogisticsViewController *waitPayInfoVC = [[WJLogisticsViewController alloc]init];
        waitPayInfoVC.invoice_no = model.invoice_no;
        waitPayInfoVC.shipping_name = model.shipping_name;
        waitPayInfoVC.hidesBottomBarWhenPushed = YES;
        [weakSelf.navigationController pushViewController:waitPayInfoVC animated:YES];
    }
    };
    return view;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, kMSScreenWith, 1)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 62;
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
