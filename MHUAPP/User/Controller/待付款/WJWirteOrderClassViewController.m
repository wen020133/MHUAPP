//
//  WJWirteOrderClassViewController.m
//  MHUAPP
//
//  Created by jinri on 2018/4/27.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import "WJWirteOrderClassViewController.h"
#import "AddAddressViewController.h"
#import "WJShopAddressTableViewCell.h"
#import "WJWriteListTableCell.h"
#import "UIView+UIViewFrame.h"
#import "AppDelegate.h"


@interface WJWirteOrderClassViewController ()

@property (strong,nonatomic)UITableView *myTableView;

@end

@implementation WJWirteOrderClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [RegularExpressionsMethod ColorWithHexString:kMSVCBackgroundColor];
     [self initSendReplyWithTitle:@"填写订单" andLeftButtonName:@"ic_back.png" andRightButtonName:nil andTitleLeftOrRight:YES];

    [self.view addSubview:self.myTableView];

    [self setupCustomBottomView];

    [[NSNotificationCenter defaultCenter] addObserver:self

                                             selector:@selector(selectAddressNote:)
                                                 name:@"selectAddressNote"
                                               object:nil];
    // Do any additional setup after loading the view.
}
-(void)selectAddressNote:(NSNotification *)notification
{
    _str_Name = [notification.userInfo objectForKey:@"name"];
    _str_telephone = [notification.userInfo objectForKey:@"telephone"];
    _str_address = [notification.userInfo objectForKey:@"address"];
    [self.myTableView reloadData];
}

-(UITableView *)myTableView
{
    if (!_myTableView) {
        _myTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];

        _myTableView.delegate = self;
        _myTableView.dataSource = self;

        _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _myTableView.backgroundColor = kMSColorFromRGB(245, 246, 248);

//        [self.myTableView registerClass:[WJCartTableHeaderView class] forHeaderFooterViewReuseIdentifier:@"WJCartTableHeaderView"];
        self.myTableView.frame = CGRectMake(0, 0, kMSScreenWith, kMSScreenHeight - kMSNaviHight );
    }
    return _myTableView;
}
#pragma mark -- 自定义底部视图
- (void)setupCustomBottomView {

    UIView *backgroundView = [[UIView alloc]init];
    backgroundView.backgroundColor = kMSCellBackColor;
    [self.view addSubview:backgroundView];
    backgroundView.frame = CGRectMake(0, kMSScreenHeight -  49-kMSNaviHight, kMSScreenWith, 49);

        //结算按钮
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = [RegularExpressionsMethod ColorWithHexString:BASEPINK];
        btn.frame = CGRectMake(kMSScreenWith - 100, 0, 100, 49);
        [btn setTitle:@"提交订单" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(goToPayClassClick:) forControlEvents:UIControlEventTouchUpInside];
        [backgroundView addSubview:btn];

        //合计
        _totlePriceLabel = [[UILabel alloc]init];
        _totlePriceLabel.font = [UIFont systemFontOfSize:16];
        _totlePriceLabel.textColor = [RegularExpressionsMethod ColorWithHexString:BASEPINK];
        [backgroundView addSubview:_totlePriceLabel];
        _totlePriceLabel.frame = CGRectMake(DCMargin, 0, kMSScreenWith - 118, 49);
        _totlePriceLabel.textAlignment = NSTextAlignmentRight;
    [self countPrice];
}

-(void)countPrice {
    double totlePrice = 0.0;

    for (WJCartGoodsModel *model in _dataArray) {

        double price = [model.count_price doubleValue];

        totlePrice += price * model.goods_number;
    }
    NSString *string = [NSString stringWithFormat:@"￥%.2f",totlePrice];
    _totlePriceLabel.attributedText = [self LZSetString:string];
}
- (NSMutableAttributedString*)LZSetString:(NSString*)string {

    NSString *text = [NSString stringWithFormat:@"实付款:%@",string];
    NSMutableAttributedString *LZString = [[NSMutableAttributedString alloc]initWithString:text];
    NSRange rang = [text rangeOfString:@"实付款:"];
    [LZString addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:rang];
    [LZString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:rang];
    return LZString;
}
-(void)goToPayClassClick:(UIButton*)button 
{
    if (_str_address.length<1) {
        [self requestFailed:@"请选择收货地址！"];
        return;
    }
    NSMutableArray *arr_recId = [NSMutableArray array];
    for (WJCartGoodsModel *model in _dataArray) {
        [arr_recId addObject:model.rec_id];
    }
    NSString *attString =  [arr_recId componentsJoinedByString:@","];
    NSMutableDictionary *infos = [NSMutableDictionary dictionary];
    [infos setObject:[AppDelegate shareAppDelegate].user_id forKey:@"user_id"];
    [infos setObject:_str_address forKey:@"assemble_site"];
    [infos setObject:_str_telephone forKey:@"consignee"];
    [infos setObject:_str_Name forKey:@"mobile"];
    [infos setObject:attString forKey:@"products"];
    [self requestAPIWithServe:[kMSBaseMiYoMeiPortURL stringByAppendingString:kMSPlaceAnOrder] andInfos:infos];
}
-(void)processData
{
    if([[self.results objectForKey:@"code"] integerValue] == 200)
    {
        [SVProgressHUD showSuccessWithStatus:@"提交成功~"];
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        [SVProgressHUD dismissWithDelay:1.0];
    }
    else
    {
//        [SVProgressHUD showErrorWithStatus:[self.results objectForKey:@"msg"]];
        return;
    }
}

#pragma mark --- UITableViewDataSource & UITableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return (section==0)? 1:self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
     return (indexPath.section==0)? [RegularExpressionsMethod dc_calculateTextSizeWithText:_str_address WithTextFont:16 WithMaxW:kMSScreenWith-70].height+60:100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section==0) {
        WJShopAddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WJShopAddressTableViewCell"];
        if (cell == nil) {
            cell = [[WJShopAddressTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"WJShopAddressTableViewCell"];
        }
        cell.lab_Name.text = self.str_Name;
        cell.lab_telephone.text = self.str_telephone;
          cell.str_address = self.str_address;
        cell.lab_address.text = self.str_address;

        return cell;
    }
    else
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
    cell.listModel = self.dataArray[indexPath.row];
    return cell;
    }
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
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        AddAddressViewController *addressV = [[AddAddressViewController alloc]init];
        addressV.selectCellIndexpathYES = YES;
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:addressV animated:YES];
    }
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"selectAddressNote" object:nil];
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
