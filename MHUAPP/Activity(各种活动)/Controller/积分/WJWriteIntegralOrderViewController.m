//
//  WJWriteIntegralOrderViewController.m
//  MHUAPP
//
//  Created by wenchengjun on 2018/5/18.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import "WJWriteIntegralOrderViewController.h"
#import "AddAddressViewController.h"
#import "WJShopAddressTableViewCell.h"
#import "WJWirteIntegralTabelCell.h"
#import "UIView+UIViewFrame.h"
#import "AppDelegate.h"

@interface WJWriteIntegralOrderViewController ()

@property (strong,nonatomic)UITableView *myTableView;

@end

@implementation WJWriteIntegralOrderViewController

-(void)viewWillAppear:(BOOL)animated
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *mobile = [[userDefaults objectForKey:@"userAddress"] objectForKey:@"mobile"];
    if (mobile&&mobile.length>1) {
        _str_Name = [[userDefaults objectForKey:@"userAddress"] objectForKey:@"consignee"];
        _str_address = [[userDefaults objectForKey:@"userAddress"] objectForKey:@"assemble_site"];
        _str_telephone = mobile;
    }
    else
    {
        _str_telephone = @"请选择收货地址";
    }
    [userDefaults synchronize];
    [_myTableView reloadData];
    
    [super viewWillAppear:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [RegularExpressionsMethod ColorWithHexString:kMSVCBackgroundColor];
    [self initSendReplyWithTitle:@"填写订单" andLeftButtonName:@"ic_back.png" andRightButtonName:nil andTitleLeftOrRight:YES];
    
    
    [self.view addSubview:self.myTableView];
    
    [self setupCustomBottomView];
    

    // Do any additional setup after loading the view.
}

-(UITableView *)myTableView
{
    if (!_myTableView) {
        _myTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
        
        _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _myTableView.backgroundColor = kMSColorFromRGB(245, 246, 248);
        _myTableView.frame = CGRectMake(0, 0, kMSScreenWith, kMSScreenHeight - kMSNaviHight );
    }
    return _myTableView;
}
#pragma mark -- 自定义底部视图
- (void)setupCustomBottomView {
    
    UIView *backgroundView = [[UIView alloc]init];
    backgroundView.backgroundColor = kMSCellBackColor;
    [self.view addSubview:backgroundView];
    backgroundView.frame = CGRectMake(0, kMSScreenHeight -  kTabBarHeight-kMSNaviHight, kMSScreenWith, kTabBarHeight);
    
    //结算按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [RegularExpressionsMethod ColorWithHexString:BASEPINK];
    btn.frame = CGRectMake(kMSScreenWith - 100, 0, 100, 49);
    [btn setTitle:@"确定兑换" forState:UIControlStateNormal];
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
    _totlePriceLabel.attributedText = [self LZSetString:_str_integral];
}
- (NSMutableAttributedString*)LZSetString:(NSString*)string {
    
    NSString *text = [NSString stringWithFormat:@"积分:%@",string];
    NSMutableAttributedString *LZString = [[NSMutableAttributedString alloc]initWithString:text];
    NSRange rang = [text rangeOfString:@"积分:"];
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
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *uid = [[userDefaults objectForKey:@"userList"] objectForKey:@"uid" ];
    NSMutableDictionary *infos = [NSMutableDictionary dictionary];
    [infos setObject:uid forKey:@"user_id"];
    [infos setObject:_str_address forKey:@"assemble_site"];
    [infos setObject:_str_Name forKey:@"consignee"];
    [infos setObject:_str_telephone forKey:@"mobile"];
    [infos setObject:_listItem.goods_id forKey:@"id"];
    [infos setObject:_str_goods_sn forKey:@"norm"];
    [infos setObject:@"1" forKey:@"num"];
    [self requestAPIWithServe:[kMSBaseMiYoMeiPortURL stringByAppendingString:kMSPostOrderIntegral] andInfos:infos];
}
-(void)processData
{
    if([[self.results objectForKey:@"code"] integerValue] == 200)
    {
        [self jxt_showAlertWithTitle:nil message:@"兑换成功" appearanceProcess:^(JXTAlertController * _Nonnull alertMaker) {
            alertMaker.
            addActionCancelTitle(@"知道了").
            addActionDestructiveTitle(@"查看订单");
        } actionsBlock:^(NSInteger buttonIndex, UIAlertAction * _Nonnull action, JXTAlertController * _Nonnull alertSelf) {
            if ([action.title isEqualToString:@"知道了"]) {
                NSLog(@"cancel");
            }
            else if ([action.title isEqualToString:@"查看订单"]) {
            }
        }];
    }
    else
    {
        [SVProgressHUD showErrorWithStatus:[self.results objectForKey:@"msg"]];
        return;
    }
}

#pragma mark --- UITableViewDataSource & UITableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
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
        cell.lab_Name.text = _str_Name;
        cell.lab_telephone.text = _str_telephone;
        cell.str_address = _str_address;
        cell.lab_address.text = _str_address;
        
        return cell;
    }
    else
    {
        WJWirteIntegralTabelCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WJWirteIntegralTabelCell"];
        if (cell == nil) {
            cell = [[WJWirteIntegralTabelCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"WJWirteIntegralTabelCell"];
        }
        cell.listModel = _listItem;
        cell.lab_type.text = _str_goods_sn;
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
