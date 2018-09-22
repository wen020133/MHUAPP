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
//#import "WJHongBaoStoreCell.h"
#import "WJHongBaoStoreView.h"
#import "WJCartGoodsModel.h"
#import "WJCartShopModel.h"


@interface WJWirteOrderClassViewController ()

@property (strong,nonatomic)UITableView *myTableView;
@property  NSInteger serverType;


/*立即购买数据源*/
@property (strong,nonatomic)NSMutableArray *new_dataArray;
/* 红包数组 */
@property (strong, nonatomic) NSArray *arr_bonus;

/* 订单可用积分 */
@property (strong, nonatomic) NSString *str_order_integral;
/* 可用余额 */
@property (strong, nonatomic) NSString *str_user_money;
/* 用户含有积分 */
@property (strong, nonatomic) NSString *str_pay_points;

@property (strong, nonatomic) WJHongBaoStoreView *hongBaoView;
@end

@implementation WJWirteOrderClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [RegularExpressionsMethod ColorWithHexString:kMSVCBackgroundColor];
     [self initSendReplyWithTitle:@"填写订单" andLeftButtonName:@"ic_back.png" andRightButtonName:nil andTitleLeftOrRight:YES];

    _bonus_id= @"0";
    self.arr_bonus =[NSArray array];
    [self getGoodsInfoCreatData];
    [self setupCustomBottomView];

    [[NSNotificationCenter defaultCenter] addObserver:self

                                             selector:@selector(selectAddressNote:)
                                                 name:@"selectAddressNote"
                                               object:nil];
    [self.view addSubview:self.myTableView];

    // Do any additional setup after loading the view.
}

#pragma mark - 初始化数组
- (NSMutableArray *)new_dataArray {
    if (_new_dataArray == nil) {
        _new_dataArray = [NSMutableArray arrayWithCapacity:0];
    }
    
    return _new_dataArray;
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
    if ([_is_cart isEqualToString:@"1"]) {
        NSMutableDictionary *infos = [NSMutableDictionary dictionary];
        [infos setObject:uid forKey:@"user_id"];
        [infos setObject:_is_cart forKey:@"is_cart"];
        [infos setObject:arr_recId forKey:@"rec_id"];
        [self requestAPIWithServe:[kMSBaseMiYoMeiPortURL stringByAppendingString:kMSOrderCheckOut] andInfos:infos];
    }
    else
    {
        NSMutableDictionary *infos = [NSMutableDictionary dictionary];
        [infos setObject:uid forKey:@"user_id"];
        [infos setObject:_is_cart forKey:@"is_cart"];
        [infos setObject:_goods_id forKey:@"goods_id"];
        [infos setObject:_goods_attr_id forKey:@"goods_attr_id"];
        [infos setObject:_goods_number forKey:@"goods_number"];
        [self requestAPIWithServe:[kMSBaseMiYoMeiPortURL stringByAppendingString:kMSOrderCheckOut] andInfos:infos];
    }
   
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
        self.myTableView.frame = CGRectMake(0, 0, kMSScreenWith, kMSScreenHeight - kMSNaviHight-kTabBarHeight);
    }
    return _myTableView;
}
#pragma mark -- 自定义底部视图
- (void)setupCustomBottomView {

    UIView *backgroundView = [[UIView alloc]init];
    backgroundView.backgroundColor = kMSCellBackColor;
    [self.view addSubview:backgroundView];
    backgroundView.frame = CGRectMake(0, kMSScreenHeight -  kTabBarHeight-kMSNaviHight, kMSScreenWith, kTabBarHeight);

    _youhuiPriceLabel = [[UILabel alloc]init];
    _youhuiPriceLabel.font = [UIFont systemFontOfSize:16];
    _youhuiPriceLabel.textColor = [RegularExpressionsMethod ColorWithHexString:BASEPINK];
    [backgroundView addSubview:_youhuiPriceLabel];
    _youhuiPriceLabel.attributedText = [self WJyouHuiSetString:@"¥0.00"];
    CGFloat maxWidth = kMSScreenWith - 30;
    _youhuiPriceLabel.frame = CGRectMake( 20, 0, maxWidth - 10, 49);
    
    
        //结算按钮
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = [RegularExpressionsMethod ColorWithHexString:BASEPINK];
        btn.frame = CGRectMake(kMSScreenWith - 100, 0, 100, 49);
        [btn setTitle:@"提交订单" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(goToPayClassClick:) forControlEvents:UIControlEventTouchUpInside];
        [backgroundView addSubview:btn];

        //实付款
        _totlePriceLabel = [[UILabel alloc]init];
        _totlePriceLabel.font = [UIFont systemFontOfSize:16];
        _totlePriceLabel.textColor = [RegularExpressionsMethod ColorWithHexString:BASEPINK];
        [backgroundView addSubview:_totlePriceLabel];
        _totlePriceLabel.frame = CGRectMake(DCMargin, 0, kMSScreenWith - 118, 49);
        _totlePriceLabel.textAlignment = NSTextAlignmentRight;
    [self countPrice];
}

- (NSMutableAttributedString*)WJyouHuiSetString:(NSString*)string {
    
    NSString *text = [NSString stringWithFormat:@"已优惠:%@",string];
    NSMutableAttributedString *LZString = [[NSMutableAttributedString alloc]initWithString:text];
    NSRange rang = [text rangeOfString:@"已优惠:"];
    [LZString addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:rang];
    [LZString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:rang];
    return LZString;
}


-(void)countPrice {
     _totlePrice = 0.0;
    _integralPrice = 0.0;
    _hongbaoPrice = 0.0;
    if ([_is_cart isEqualToString:@"1"]) {
        for (WJCartGoodsModel *model in _dataArray) {
            
            double price = [model.goods_price doubleValue];
            _totlePrice += price * model.goods_number;
        }
    }
    else
    {
        _totlePrice = [[[self.results objectForKey:@"data"]objectForKey:@"order_amount"] doubleValue];
    }
    

    NSString *string = [NSString stringWithFormat:@"￥%.2f",_totlePrice];
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
    if([_is_cart isEqualToString:@"1"])
    {
       for (WJCartGoodsModel *model in _dataArray) {
             [arr_recId addObject:model.rec_id];
        }
    }
    else
    {
        WJCartShopModel *model = [self.new_dataArray objectAtIndex:0];
        for (WJCartGoodsModel *item in model.goodsArray) {
            [arr_recId addObject:item.rec_id];
        }
    }
//    NSString *attString =  [arr_recId componentsJoinedByString:@","];
    
    _serverType = 2;
    NSMutableDictionary *infos = [NSMutableDictionary dictionary];
    [infos setObject:uid forKey:@"user_id"];
//    [infos setObject:_str_address forKey:@"assemble_site"];
//    [infos setObject:_str_Name forKey:@"consignee"];
//    [infos setObject:_str_telephone forKey:@"mobile"];
    [infos setObject:_str_site_id forKey:@"address_id"];
    [infos setObject:@"0" forKey:@"surplus"];
    [infos setObject:[NSString stringWithFormat:@"%.0f",_integralPrice] forKey:@"integral"];
     [infos setObject:_bonus_id forKey:@"bonus_id"];
    [infos setObject:arr_recId forKey:@"rec_id"];
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
                        _str_site_id = [address_default objectForKey:@"address_id"];
                    }
                    self.arr_bonus = self.results[@"data"][@"bonus"];
                    self.str_order_integral = self.results[@"data"][@"order_integral"];
                    self.str_user_money = self.results[@"data"][@"user_money"];
                    self.str_pay_points = self.results[@"data"][@"pay_points"];
                    float height_hongbao= 0.0f;
                    if (self.arr_bonus&&self.arr_bonus.count>0) {
                        height_hongbao = 200;//有红包有积分
                    }
                    else  {
                        if ([self.str_order_integral integerValue]>0)
                        {
                            height_hongbao = 150;// 没红包有积分
                        }
                        else
                        {
                            height_hongbao= 0.0f;//没红包没积分
                        }
                    }
//                    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"19",@"type_id",@"满100减10",@"type_name",@"10.00",@"type_money",@"6786",@"bonus_id",@"00",@"supplier_id", nil];
//                    self.arr_bonus = [NSArray arrayWithObject:dic];
//                     height_hongbao = 200;
                    self.hongBaoView = [[WJHongBaoStoreView alloc]initWithFrame:CGRectMake(0, 0, kMSScreenWith, height_hongbao) withBouns:self.arr_bonus withUserStore:self.str_pay_points withServerStore:self.str_order_integral withViewHeight:height_hongbao];
                    WEAKSELF
                    self.hongBaoView.jifenStoreClickBlock = ^(double storeNum) {
                        NSString *string = [NSString stringWithFormat:@"￥%.2f",storeNum/100+_hongbaoPrice];
                        weakSelf.youhuiPriceLabel.attributedText = [weakSelf WJyouHuiSetString:string];
                        weakSelf.integralPrice = storeNum;
                        
                        
                        NSString *stringTotle = [NSString stringWithFormat:@"￥%.2f",weakSelf.totlePrice-storeNum/100-_hongbaoPrice];
                        weakSelf.totlePriceLabel.attributedText = [weakSelf LZSetString:stringTotle];
                    };
                    self.hongBaoView.bonusIdClickBlock = ^(NSInteger bonusId) {
                        weakSelf.bonus_id = [[weakSelf.arr_bonus objectAtIndex:bonusId] objectForKey:@"bonus_id"];

                        _hongbaoPrice = [[[weakSelf.arr_bonus objectAtIndex:bonusId] objectForKey:@"type_money"] floatValue];
                        
                        NSString *string = [NSString stringWithFormat:@"￥%.2f",weakSelf.integralPrice/100+_hongbaoPrice];
                        weakSelf.youhuiPriceLabel.attributedText = [weakSelf WJyouHuiSetString:string];
                        
                        
                        NSString *stringTotle = [NSString stringWithFormat:@"￥%.2f",weakSelf.totlePrice-weakSelf.integralPrice/100-_hongbaoPrice];
                        weakSelf.totlePriceLabel.attributedText = [weakSelf LZSetString:stringTotle];
                    };
                    id arr_data = [[self.results objectForKey:@"data"] objectForKey:@"goods_list"];
                    if ([arr_data isKindOfClass:[NSArray class]]) {
                        NSArray *dataArr = arr_data;
                        for (int aa=0; aa<dataArr.count; aa++) {
                            NSArray *arr_goods = [[dataArr objectAtIndex:aa] objectForKey:@"goods"];
                            if (arr_goods&&arr_goods.count>0) {
                                WJCartShopModel *model = [[WJCartShopModel alloc]init];
                                model.supplier_id = [[dataArr objectAtIndex:aa] objectForKey:@"supplier_id"];
                                model.supplier_name = [[dataArr objectAtIndex:aa] objectForKey:@"supplier_name"];
                                model.supplier_logo = [[dataArr objectAtIndex:aa] objectForKey:@"logo"];
                                [model configGoodsArrayWithArray:arr_goods];
                                
                                [self.new_dataArray addObject:model];
                                
                            }
                        }
                        }
                    [self countPrice];
                    
                    self.myTableView.tableFooterView = self.hongBaoView;
                    [self.myTableView reloadData];
                }
                break;
                case 2:
            {
                id data_arr = self.results[@"data"];
                if ([data_arr isKindOfClass:[NSDictionary class]]) {
                    PayViewController *pay = [[PayViewController alloc]init];
                    pay.orderNo = self.results[@"data"][@"orderNo"];
                    pay.oPrice = self.results[@"data"][@"oPrice"];
                    self.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:pay animated:YES];
                }
                else
                {
                    [SVProgressHUD showErrorWithStatus:[self.results objectForKey:@"msg"]];
                }
               
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
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([_is_cart isEqualToString:@"1"]) {
        return (section==1)? self.dataArray.count:1;
    }
    else
    {
        if(self.new_dataArray.count>0)
        {
         WJCartShopModel *model = [self.new_dataArray objectAtIndex:0];
            return model.goodsArray.count;
        }
        return 0;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return [RegularExpressionsMethod dc_calculateTextSizeWithText:_str_address WithTextFont:16 WithMaxW:kMSScreenWith-70].height+60;
    }
    else
        return 100;
//    else
//    {
//        if([_is_use_bonus integerValue]==1)
//        {
//            return 200;
//        }
//        else
//        {
//            return 0;
//        }
//    }
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
        if ([_is_cart isEqualToString:@"1"]) {
         cell.listModel = self.dataArray[indexPath.row];
        }
        else
        {
            WJCartShopModel *shopModel = self.new_dataArray[0];
            WJCartGoodsModel *model = [shopModel.goodsArray objectAtIndex:indexPath.row];
            cell.listModel = model;
        }
         return cell;
    }
//    else
//    {
//        WJHongBaoStoreCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WJHongBaoStoreCell"];
//        if (cell == nil) {
//            cell = [[WJHongBaoStoreCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"WJHongBaoStoreCell"];
//        }
//        return cell;
//    }
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
