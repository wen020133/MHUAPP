//
//  WJDetailedDeliveryInfoViewController.m
//  MHUAPP
//
//  Created by jinri on 2018/6/1.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import "WJDetailedDeliveryInfoViewController.h"
#import "WJShopAddressTableViewCell.h"
#import "WJWriteListTableCell.h"
#import "UIView+UIViewFrame.h"
#import "WJCartGoodsModel.h"
#import "WJDetailedDeliveryThirdTableCell.h"
#import "WJPostBackOrderViewController.h"


@interface WJDetailedDeliveryInfoViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong,nonatomic)UITableView *myTableView;

@property (strong,nonatomic) NSMutableArray <WJCartGoodsModel *> *arr_dataList;
@property (strong,nonatomic) NSDictionary  *arr_reslut;

@property double totlePrice;

@end

@implementation WJDetailedDeliveryInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [RegularExpressionsMethod ColorWithHexString:kMSVCBackgroundColor];
    [self initSendReplyWithTitle:@"待发货" andLeftButtonName:@"ic_back.png" andRightButtonName:nil andTitleLeftOrRight:YES];


    [self getDetailedDeliveryInfo];
    [self.view addSubview:self.myTableView];

    // Do any additional setup after loading the view.
}


-(void)getDetailedDeliveryInfo
{
    [self requestGetAPIWithServe:[NSString stringWithFormat:@"%@/%@/%@?order_sn=%@&user_id=%@",kMSBaseMiYoMeiPortURL,kMSappVersionCode,kMSGetDetailedDelivery,_str_orderId,[AppDelegate shareAppDelegate].user_id]];
}


-(void)getProcessData
{
    if([[self.results objectForKey:@"code"] integerValue] == 200)
    {
        [self.arr_dataList removeAllObjects];
        _arr_reslut = self.results;
        id arr_data = [[[self.results objectForKey:@"data"] objectAtIndex:0] objectForKey:@"order_info"];
        if ([arr_data isKindOfClass:[NSArray class]]) {
            _arr_dataList = [WJCartGoodsModel mj_objectArrayWithKeyValuesArray:arr_data];
            [self countPrice];
        }
        [_myTableView reloadData];
    }
    else
    {
        [SVProgressHUD showErrorWithStatus:[self.results objectForKey:@"msg"]];
        return;
    }
}
-(UITableView *)myTableView
{
    if (!_myTableView) {
        _myTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];

        _myTableView.delegate = self;
        _myTableView.dataSource = self;

        _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _myTableView.backgroundColor = kMSColorFromRGB(245, 246, 248);
        self.myTableView.frame = CGRectMake(0, 0, kMSScreenWith, kMSScreenHeight - kMSNaviHight );
    }
    return _myTableView;
}


-(void)countPrice {

    for (WJCartGoodsModel *model in _arr_dataList) {

        double price = [model.count_price doubleValue];

        _totlePrice += price * model.goods_number;
    }
}



#pragma mark --- UITableViewDataSource & UITableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return (section==1)?self.arr_dataList.count:1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==0)
        return [RegularExpressionsMethod dc_calculateTextSizeWithText:_str_address WithTextFont:16 WithMaxW:kMSScreenWith-70].height+60;
    else if(indexPath.section ==1)
        return 100;
    else
        return 200;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
     if (indexPath.section==0) {
        WJShopAddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WJShopAddressTableViewCell"];
        if (cell == nil) {
            cell = [[WJShopAddressTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"WJShopAddressTableViewCell"];
        }
        cell.lab_Name.text = _str_Name;
        cell.lab_telephone.text = _str_telephone;
        cell.str_address = _str_address;
        cell.lab_address.text = _str_address;
        cell.actionImageView.hidden = YES;
        return cell;
    }
    else if (indexPath.section==1)
    {
        WJWriteListTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WJWriteListTableCell"];
        if (cell == nil) {
            cell = [[WJWriteListTableCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"WJWriteListTableCell"];
        }
        if(indexPath.row==0)
        {
            cell.imageLine.hidden = YES;
        }
        else
        {
            cell.imageLine.hidden = NO;
        }
        cell.listModel = _arr_dataList[indexPath.row];
        return cell;
    }
    else
    {
        WJDetailedDeliveryThirdTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WJDetailedDeliveryThirdTableCell"];
        if (cell == nil) {
            cell = [[WJDetailedDeliveryThirdTableCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"WJDetailedDeliveryThirdTableCell"];
        }
        cell.ClickdetailStateForStrBlock = ^(NSString *stateStr) {
            if ([stateStr isEqualToString:@"联系客服"]) {
            }
            else  if ([stateStr isEqualToString:@"申请退款"]) {
                WJPostBackOrderViewController *waitPayInfoVC = [[WJPostBackOrderViewController alloc]init];
                waitPayInfoVC.str_goodsId = _arr_dataList[0].rec_id;
                waitPayInfoVC.str_price = _arr_dataList[0].count_price;
                waitPayInfoVC.str_oldprice = _arr_dataList[0].market_price;
                waitPayInfoVC.str_title = _arr_dataList[0].goods_name;
                waitPayInfoVC.str_Num = [NSString stringWithFormat:@"%ld",_arr_dataList[0].goods_number];
                waitPayInfoVC.str_contentImg = _arr_dataList[0].img;
                waitPayInfoVC.str_order_id = _arr_dataList[0].order_id;
                waitPayInfoVC.str_type = _arr_dataList[0].goods_attr;
                waitPayInfoVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:waitPayInfoVC animated:YES];
            }
        };
        NSString *addTime = [[[self.results objectForKey:@"data"] objectAtIndex:0] objectForKey:@"add_time"];
        NSDateFormatter *stampFormatter = [[NSDateFormatter alloc] init]; [stampFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
        NSDate *stampDate = [NSDate dateWithTimeIntervalSince1970:[addTime doubleValue]];
        cell.lab_add_time.text =[NSString stringWithFormat:@"下单时间：%@",[stampFormatter stringFromDate:stampDate]];

        NSString *pay_time = [[[self.results objectForKey:@"data"] objectAtIndex:0] objectForKey:@"pay_time"];
        NSDate *stampDate2 = [NSDate dateWithTimeIntervalSince1970:[pay_time doubleValue]];
        cell.lab_payTime.text =[NSString stringWithFormat:@"付款时间：%@", [stampFormatter stringFromDate:stampDate2]];


        cell.str_orderNo = _str_orderId;
        NSString *payName = [[[_arr_reslut objectForKey:@"data"] objectAtIndex:0] objectForKey:@"pay_name"];
        if (payName&&payName.length>1) {
              cell.lab_pay_name.text =[NSString stringWithFormat:@"支付方式：%@", payName];
        }
        else
        {
            cell.lab_pay_name.text =[NSString stringWithFormat:@"支付方式：%@",  @"积分支付"];
        }

        cell.totalPayPrice.text = [NSString stringWithFormat:@"共%ld件商品 合计：￥%.2f",_arr_dataList.count,_totlePrice];
        return cell;
    }
}
//section头部间距
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 5;

}
//section头部视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, kMSScreenWith, 5)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
