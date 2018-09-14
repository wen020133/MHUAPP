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
#import "PayViewController.h"
#import "WJHongBaoStoreCell.h"


@interface WJWirteOrderClassViewController ()

@property (strong,nonatomic)UITableView *myTableView;
@property  NSInteger serverType;
@end

@implementation WJWirteOrderClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [RegularExpressionsMethod ColorWithHexString:kMSVCBackgroundColor];
     [self initSendReplyWithTitle:@"填写订单" andLeftButtonName:@"ic_back.png" andRightButtonName:nil andTitleLeftOrRight:YES];

    
    
    [self.view addSubview:self.myTableView];
    [self getGoodsInfoCreatData];
    [self setupCustomBottomView];

    [[NSNotificationCenter defaultCenter] addObserver:self

                                             selector:@selector(selectAddressNote:)
                                                 name:@"selectAddressNote"
                                               object:nil];
    // Do any additional setup after loading the view.
}
-(void)selectAddressNote:(NSNotification *)notification
{
    _str_Name = [notification.userInfo objectForKey:@"consignee"];
    _str_telephone = [notification.userInfo objectForKey:@"mobile"];
    _str_address = [notification.userInfo objectForKey:@"assemble_site"];
    _str_site_id = [notification.userInfo objectForKey:@"site_id"];
    [self.myTableView reloadData];
}

-(void)getGoodsInfoCreatData
{
    _serverType = 1;
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *uid = [[userDefaults objectForKey:@"userList"] objectForKey:@"uid" ];
    
    NSMutableArray *arr_recId = [NSMutableArray array];
    for (WJCartGoodsModel *model in _dataArray) {
        [arr_recId addObject:model.rec_id];
    }
//    NSString *attString =  [arr_recId componentsJoinedByString:@","];
    NSMutableDictionary *infos = [NSMutableDictionary dictionary];
    [infos setObject:uid forKey:@"user_id"];
    [infos setObject:_is_cart forKey:@"is_cart"];
    [infos setObject:arr_recId forKey:@"rec_id"];
    [self requestAPIWithServe:[kMSBaseMiYoMeiPortURL stringByAppendingString:kMSOrderCheckOut] andInfos:infos];
}


-(UITableView *)myTableView
{
    if (!_myTableView) {
        _myTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];

        _myTableView.delegate = self;
        _myTableView.dataSource = self;

        _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _myTableView.backgroundColor = self.view.backgroundColor;

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
    backgroundView.frame = CGRectMake(0, kMSScreenHeight -  kTabBarHeight-kMSNaviHight, kMSScreenWith, 49);

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


//        totlePrice = [model.count_price doubleValue];
        double price = [model.goods_price doubleValue];
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
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *uid = [[userDefaults objectForKey:@"userList"] objectForKey:@"uid" ];
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
    [infos setObject:uid forKey:@"user_id"];
//    [infos setObject:_str_address forKey:@"assemble_site"];
//    [infos setObject:_str_Name forKey:@"consignee"];
//    [infos setObject:_str_telephone forKey:@"mobile"];
    [infos setObject:_str_site_id forKey:@"address_id"];
    [infos setObject:attString forKey:@"products"];
    [self requestAPIWithServe:[kMSBaseMiYoMeiPortURL stringByAppendingString:kMSPlaceAnOrder] andInfos:infos];
}
-(void)processData
{
    if([[self.results objectForKey:@"code"] integerValue] == 200)
    {
        switch (_serverType) {
            case 1:
                {
                    id address_default = self.results[@"data"][@"address_default"];
                    if (address_default&&[address_default isKindOfClass:[NSDictionary class] ]) {
                        _str_Name = [address_default objectForKey:@"consignee"];
                        _str_telephone = [address_default objectForKey:@"mobile"];
                        _str_address = [address_default objectForKey:@"assemble_site"];
                        _str_site_id = [address_default objectForKey:@"site_id"];
                    }
                }
                break;
                case 2:
            {
                PayViewController *pay = [[PayViewController alloc]init];
                pay.orderNo = self.results[@"data"][@"orderNo"];
                pay.oPrice = self.results[@"data"][@"oPrice"];
                self.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:pay animated:YES];
            }
            default:
                break;
        }
        
        
       
    }
    else
    {
        [SVProgressHUD showErrorWithStatus:[self.results objectForKey:@"msg"]];
        return;
    }
    NSLog(@"msg ===  %@",self.results[@"msg"]);
}

#pragma mark --- UITableViewDataSource & UITableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return (section==1)? self.dataArray.count:1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return [RegularExpressionsMethod dc_calculateTextSizeWithText:_str_address WithTextFont:16 WithMaxW:kMSScreenWith-70].height+60;
    }
    else if(indexPath.section==1)
        return 100;
    else
    {
//        if([_is_use_bonus integerValue]==1)
//        {
            return 200;
//        }
//        else
//        {
//            return 200;
//        }
    }
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
         cell.listModel = self.dataArray[indexPath.row];
         return cell;
    }
    else
    {
        WJHongBaoStoreCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WJHongBaoStoreCell"];
        if (cell == nil) {
            cell = [[WJHongBaoStoreCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"WJHongBaoStoreCell"];
        }
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
