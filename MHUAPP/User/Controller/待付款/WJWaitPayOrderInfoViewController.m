//
//  WJWaitPayOrderInfoViewController.m
//  MHUAPP
//
//  Created by jinri on 2018/5/3.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import "WJWaitPayOrderInfoViewController.h"
#import "WJShopAddressTableViewCell.h"
#import "WJWriteListTableCell.h"
#import "UIView+UIViewFrame.h"
#import "AppDelegate.h"
#import "WJCartGoodsModel.h"
#import "WJWaitPayThridTableCell.h"
#import "PayViewController.h"


@interface WJWaitPayOrderInfoViewController ()
@property (strong,nonatomic)UITableView *myTableView;
@property (strong,nonatomic) NSMutableArray <WJCartGoodsModel *> *arr_dataList;

@property (strong, nonatomic) UIView *view_foot;
@end

@implementation WJWaitPayOrderInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [RegularExpressionsMethod ColorWithHexString:kMSVCBackgroundColor];
    [self initSendReplyWithTitle:@"待付款" andLeftButtonName:@"ic_back.png" andRightButtonName:nil andTitleLeftOrRight:YES];
    [self getOrderWaitPayInfo];
    [self.view addSubview:self.myTableView];

    // Do any additional setup after loading the view.
}

-(void)getOrderWaitPayInfo
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *uid = [[userDefaults objectForKey:@"userList"] objectForKey:@"uid" ];
    [self requestGetAPIWithServe:[NSString stringWithFormat:@"%@/%@/%@?order_sn=%@&user_id=%@",kMSBaseMiYoMeiPortURL,kMSappVersionCode,kMSDetailedPay,_str_orderId,uid]];
}

-(void)getProcessData
{
    if([[self.results objectForKey:@"code"] integerValue] == 200)
    {
        [self.arr_dataList removeAllObjects];
        NSArray *data =[self.results objectForKey:@"data"];
        if (data.count>0) {
            id arr_data = [[data objectAtIndex:0] objectForKey:@"order_info"];;
            if ([arr_data isKindOfClass:[NSArray class]]) {
                _arr_dataList = [WJCartGoodsModel mj_objectArrayWithKeyValuesArray:arr_data];
            }
            [_myTableView reloadData];
        }
        else
        {
            [SVProgressHUD showErrorWithStatus:@"获取数据失败！"];
        }

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
        _myTableView.tableFooterView = self.view_foot;
    }
    return _myTableView;
}
-(UIView *)view_foot
{
    if (!_view_foot) {
        _view_foot = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kMSScreenWith, 88)];
        _view_foot.backgroundColor = kMSCellBackColor;

        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(20, 20, kMSScreenWith-40, 48);
        [btn setBackgroundColor:[UIColor redColor]];
        [btn setTitle:@"立即支付" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.layer.cornerRadius = 5.0;
        btn.titleLabel.font = PFR18Font;
        [btn addTarget:self action:@selector(gotoPayNew:) forControlEvents:UIControlEventTouchUpInside];
        [_view_foot addSubview:btn];
    }
    return _view_foot;
}
-(void)gotoPayNew:(UIButton *)sender
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *uid = [[userDefaults objectForKey:@"userList"] objectForKey:@"uid" ];
    NSMutableDictionary *infos = [NSMutableDictionary dictionary];
    [infos setObject:uid forKey:@"user_id"];
    [infos setObject:_str_orderId forKey:@"id"];
    [self requestAPIWithServe:[kMSBaseMiYoMeiPortURL stringByAppendingString:kMSMiYoMeiAffirmPay] andInfos:infos];
}
-(void)processData
{
    if([[self.results objectForKey:@"code"] integerValue] == 200)
    {
        PayViewController *pay = [[PayViewController alloc]init];
        pay.orderNo = self.results[@"data"][@"order_sn"];
        pay.oPrice = self.results[@"data"][@"oPrice"];
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:pay animated:YES];
    }
    else
    {
        [SVProgressHUD showErrorWithStatus:[self.results objectForKey:@"msg"]];
        return;
    }
}

-(void)countPrice {
    double totlePrice = 0.0;

    for (WJCartGoodsModel *model in _arr_dataList) {

        double price = [model.count_price doubleValue];

        totlePrice += price * model.goods_number;
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
        return 120;
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
        WJWaitPayThridTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WJWaitPayThridTableCell"];
        if (cell == nil) {
            cell = [[WJWaitPayThridTableCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"WJWaitPayThridTableCell"];
        }
        NSString *addTime = [[[self.results objectForKey:@"data"] objectAtIndex:0] objectForKey:@"add_time"];
        NSDateFormatter *stampFormatter = [[NSDateFormatter alloc] init]; [stampFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
        NSDate *stampDate2 = [NSDate dateWithTimeIntervalSince1970:[addTime doubleValue]];
        cell.lab_time.text = [stampFormatter stringFromDate:stampDate2];
        cell.str_orderNo = _str_orderId;

        cell.totalPayPrice.text = [NSString stringWithFormat:@"共%ld件商品 合计：￥%@",_arr_dataList.count,[[[self.results objectForKey:@"data"] objectAtIndex:0] objectForKey:@"goods_amount"]];
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
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

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
