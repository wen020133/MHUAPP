//
//  WJWaitCommitInfoViewController.m
//  MHUAPP
//
//  Created by jinri on 2018/6/8.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import "WJWaitCommitInfoViewController.h"
#import "WJShopAddressTableViewCell.h"
#import "WJWriteListTableCell.h"
#import "UIView+UIViewFrame.h"
#import "WJWaitCommitItem.h"
#import "WJWAaitForGoodThridTableCell.h"
#import "WJWAaitForGoodLogistTableCell.h"
#import "WJLogisticsModel.h"
#import "WJLogisticsViewController.h"
#import "WJCommitViewController.h"
#import <UIImageView+WebCache.h>

@interface WJWaitCommitInfoViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong,nonatomic)UITableView *myTableView;
@property (strong,nonatomic) NSString *str_LogisticsDes;
@property (strong,nonatomic) NSMutableArray <WJWaitCommitItem *> *arr_dataList;
@property (strong,nonatomic) NSString *str_LogisticsTime;
@property double totlePrice;

@property (strong,nonatomic) NSString *shipping_name;
@property (strong,nonatomic) NSString *invoice_no;

@end

@implementation WJWaitCommitInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [RegularExpressionsMethod ColorWithHexString:kMSVCBackgroundColor];
    [self initSendReplyWithTitle:@"待评价" andLeftButtonName:@"ic_back.png" andRightButtonName:nil andTitleLeftOrRight:YES];

//    _shipping_name = @"中通速递";
//    _invoice_no = @"490850486931";
    _str_LogisticsDes = @"暂无物流信息";
    _str_LogisticsTime = @"";

    [self getDetailedReceiveInfo];

    [self.view addSubview:self.myTableView];

    [self setUpRightTwoButton];
    // Do any additional setup after loading the view.
}
#pragma mark - 加入购物车 立即购买
- (void)setUpRightTwoButton
{
    NSArray *titles = @[@"申请介入",@"评价"];
    CGFloat buttonW = kMSScreenWith/2;
    CGFloat buttonH = 50;
    CGFloat buttonY = kMSScreenHeight -kMSNaviHight- buttonH;
    for (NSInteger i = 0; i < titles.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.titleLabel.font = PFR16Font;
        [button setTitleColor:(i == 1) ? kMSCellBackColor : [RegularExpressionsMethod ColorWithHexString:BASEBLACKCOLOR] forState:UIControlStateNormal];
        button.tag = i + 2000;
        [button setTitle:titles[i] forState:UIControlStateNormal];
        button.backgroundColor = (i == 1) ? [UIColor redColor] : kMSCellBackColor;
        [button addTarget:self action:@selector(bottomButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        CGFloat buttonX =  (buttonW * i);
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);

        [self.view addSubview:button];
    }
}
-(void)bottomButtonClick:(UIButton *)sender
{
    switch (sender.tag) {
        case 2000:
        {

        }
            break;
        case 2001:
        {
            WJCommitViewController *waitPayInfoVC = [[WJCommitViewController alloc]init];
            waitPayInfoVC.goods_id = _goods_id;
            waitPayInfoVC.rec_id = _rec_id;
            waitPayInfoVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:waitPayInfoVC animated:YES];
        }
        default:
            break;
    }

}


-(void)processData
{
    if ([_shipping_name isEqualToString:@"顺丰速运"]||[_shipping_name isEqualToString:@"申通速递"]||[_shipping_name isEqualToString:@"百世快递"]) {
            NSArray *arr_Traces = [[self.results objectForKey:@"result"] objectForKey:@"list"];
            if (arr_Traces&&arr_Traces.count>0) {
                _str_LogisticsDes = [[arr_Traces objectAtIndex:arr_Traces.count-1] objectForKey:@"remark"];
                _str_LogisticsTime = [[arr_Traces objectAtIndex:arr_Traces.count-1] objectForKey:@"datetime"];
            }


            [_myTableView reloadData];
        }
        else
        {
            if([[self.results objectForKey:@"Success"] integerValue] == 1)
            {
                NSArray *arr_Traces = [self.results objectForKey:@"Traces"];
                if (arr_Traces&&arr_Traces.count>0) {
                    _str_LogisticsDes = [[arr_Traces objectAtIndex:arr_Traces.count-1] objectForKey:@"AcceptStation"];
                    _str_LogisticsTime = [[arr_Traces objectAtIndex:arr_Traces.count-1] objectForKey:@"AcceptTime"];
                }
            }
            [_myTableView reloadData];
        }

}


-(void)getDetailedReceiveInfo
{
    [self requestGetAPIWithServe:[NSString stringWithFormat:@"%@/%@/%@?id=%@&user_id=%@",kMSBaseMiYoMeiPortURL,kMSappVersionCode,kMSOrderInfo,_order_id,[AppDelegate shareAppDelegate].user_id]];
}
-(void)getMiYouMeiQuery
{
   if(_shipping_name.length>1)
    {
    NSMutableDictionary *infos = [NSMutableDictionary dictionary];
    [infos setObject:_shipping_name forKey:@"shipping_name"];
    [infos setObject:_invoice_no forKey:@"invoice_no"];
    [self requestAPIWithServe:[kMSBaseMiYoMeiPortURL stringByAppendingString:kMSMiYoMeiQuery] andInfos:infos];
    }
}


-(void)getProcessData
{
    if([[self.results objectForKey:@"code"] integerValue] == 200)
    {
        id arr_data = [self.results objectForKey:@"data"];
        if ([arr_data isKindOfClass:[NSArray class]]) {
            _arr_dataList = [WJWaitCommitItem mj_objectArrayWithKeyValuesArray:arr_data];
//            _shipping_name = _arr_dataList[0].shipping_name;
//            _invoice_no = _arr_dataList[0].invoice_no;

            [self getMiYouMeiQuery];
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





#pragma mark --- UITableViewDataSource & UITableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return (section==2)?self.arr_dataList.count:1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==0)
        return 60;
    else if(indexPath.section==1)

        return [RegularExpressionsMethod dc_calculateTextSizeWithText:_arr_dataList[indexPath.row].address WithTextFont:16 WithMaxW:kMSScreenWith-70].height+60;
    else if(indexPath.section ==2)
        return 100;
    else
        return 190;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
        WJWAaitForGoodLogistTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WJWAaitForGoodLogistTableCell"];
        if (cell == nil) {
            cell = [[WJWAaitForGoodLogistTableCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"WJWAaitForGoodLogistTableCell"];
        }
        cell.lab_Name.text = _str_LogisticsDes;
        cell.lab_time.text = _str_LogisticsTime;
        return cell;
    }
    else if (indexPath.section==1) {
        WJShopAddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WJShopAddressTableViewCell"];
        if (cell == nil) {
            cell = [[WJShopAddressTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"WJShopAddressTableViewCell"];
        }
        cell.lab_Name.text = _arr_dataList[0].consignee;
        cell.lab_telephone.text = _arr_dataList[0].mobile;
        cell.str_address = _arr_dataList[0].address;
        cell.lab_address.text = _arr_dataList[0].address;
        cell.actionImageView.hidden = YES;
        return cell;
    }
    else if (indexPath.section==2)
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
        [cell.contentImg sd_setImageWithURL:[NSURL URLWithString:_img] placeholderImage:[UIImage imageNamed:@"default_nomore.png"] completed:nil];

        NSString *price = [NSString stringWithFormat:@"￥%@",_count_price];
        CGFloat width = [RegularExpressionsMethod widthOfString:price font:Font(15) height:23];
        cell.price.frame = CGRectMake(kMSScreenWith-width-10, 5, width, 23);
        cell.price.text = price;

        NSString *oldprice = [NSString stringWithFormat:@"￥%@",_market_price];
        cell.oldprice.frame = CGRectMake(kMSScreenWith-width-10, cell.price.Bottom+5, width, 20);
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:oldprice
                                                                                    attributes:@{NSStrikethroughStyleAttributeName : @(NSUnderlineStyleSingle)}];
        cell.oldprice.attributedText = attrStr;

        cell.title.text = _goods_name;
        cell.title.frame = CGRectMake(TAG_Height+15, 5, kMSScreenWith- DCMargin * 4-TAG_Height-width, 40);

        NSString *saleCount = [NSString stringWithFormat:@"%@",_goods_attr];
        cell.type.text  = saleCount;
        cell.type.frame = CGRectMake(TAG_Height+15, cell.title.Bottom+5, cell.title.width, 20);

        cell.Num.frame =CGRectMake(kMSScreenWith-width-10, cell.oldprice.Bottom+5, width, 20);
        cell.Num.text =  [NSString stringWithFormat:@"x%@",_goods_number];
        return cell;
    }
    else
    {
        WJWAaitForGoodThridTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WJWAaitForGoodThridTableCell"];
        if (cell == nil) {
            cell = [[WJWAaitForGoodThridTableCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"WJWAaitForGoodThridTableCell"];
        }
        NSString *addTime = _arr_dataList[0].add_time;
        NSDateFormatter *stampFormatter = [[NSDateFormatter alloc] init]; [stampFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
        NSDate *stampDate = [NSDate dateWithTimeIntervalSince1970:[addTime doubleValue]];
        cell.lab_add_time.text =[NSString stringWithFormat:@"下单时间：%@",[stampFormatter stringFromDate:stampDate]];

        NSString *pay_time = _arr_dataList[0].pay_time;
        NSDate *stampDate2 = [NSDate dateWithTimeIntervalSince1970:[pay_time doubleValue]];
        cell.lab_payTime.text =[NSString stringWithFormat:@"付款时间：%@", [stampFormatter stringFromDate:stampDate2]];


        NSString *shipping_time = _arr_dataList[0].shipping_time;
        NSDate *stampDate3 = [NSDate dateWithTimeIntervalSince1970:[shipping_time doubleValue]];
        cell.lab_shipping_time.text =[NSString stringWithFormat:@"发货时间：%@", [stampFormatter stringFromDate:stampDate3]];


        cell.str_orderNo = _arr_dataList[0].order_sn;
        cell.lab_pay_name.text =[NSString stringWithFormat:@"支付方式：%@", _arr_dataList[0].pay_name];
        cell.totalPayPrice.text = [NSString stringWithFormat:@"共%ld件商品 合计：￥%@",_arr_dataList.count,_arr_dataList[0].goods_amount];
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
    if (indexPath.section==0) {
        WJLogisticsViewController *waitPayInfoVC = [[WJLogisticsViewController alloc]init];
        waitPayInfoVC.invoice_no = _invoice_no;
        waitPayInfoVC.shipping_name = _shipping_name;
        waitPayInfoVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:waitPayInfoVC animated:YES];
    }
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
