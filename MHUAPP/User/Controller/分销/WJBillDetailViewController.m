//
//  WJBillDetailViewController.m
//  MHUAPP
//
//  Created by jinri on 2018/9/28.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import "WJBillDetailViewController.h"

@interface WJBillDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *infoTableView;
@property (strong, nonatomic) NSArray *arr_typeName;
@property (strong, nonatomic) NSMutableArray *arr_valueStr;

@property (strong, nonatomic) UIView *view_head;
/* 图片 */
@property (strong , nonatomic) UIImageView *headImageView;
/* 方式 */
@property (strong , nonatomic) UILabel *typeLabel;
/* 金额 */
@property (strong , nonatomic) UILabel *priceLabel;


@end

@implementation WJBillDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [RegularExpressionsMethod ColorWithHexString:kMSVCBackgroundColor];
    [self initSendReplyWithTitle:@"账单详情" andLeftButtonName:@"ic_back.png" andRightButtonName:nil andTitleLeftOrRight:YES];
    self.arr_typeName = [NSArray arrayWithObjects:@"姓名：",@"提现金额：",@"收款类型：",@"收款账号：",@"手机号：",@"我的备注：",@"管理员备注：",@"状态：", nil];
    NSString *price = [NSString stringWithFormat:@"￥%@元",_billItem.amount];
    NSString *payment = @"";
     if ([_billItem.ewm_type integerValue]==2) {
         payment = @"微信";
     }
    else
    {
          payment = @"支付宝";
    }

    self.arr_valueStr = [NSMutableArray arrayWithObjects:_billItem.real_name,price,payment,_billItem.account_name,_billItem.phone,_billItem.user_note,_billItem.admin_note,_billItem.pay_status, nil];
    [self.view addSubview:self.infoTableView];
    
    // Do any additional setup after loading the view.
}
-(UITableView *)infoTableView
{
    if (!_infoTableView) {
        _infoTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kMSScreenWith, kMSScreenHeight-kMSNaviHight) style:UITableViewStylePlain];
        _infoTableView.delegate = self;
        _infoTableView.dataSource = self;
        _infoTableView.backgroundColor =[UIColor clearColor];
        _infoTableView.showsHorizontalScrollIndicator = NO;  _infoTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        _infoTableView.tableHeaderView = self.view_head;
    }
    return _infoTableView;
}

-(UIView *)view_head
{
    if (!_view_head) {
        _view_head = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kMSScreenWith, 130)];
        _view_head.backgroundColor = [RegularExpressionsMethod ColorWithHexString:kMSVCBackgroundColor];
        UIImageView *imagback = ImageViewInit(0, 0, kMSScreenWith, 130);
        imagback.backgroundColor = kMSCellBackColor;
        [_view_head addSubview:imagback];

        _headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kMSScreenWith/2-25, 15, 50, 50)];
        _headImageView.contentMode = UIViewContentModeScaleAspectFill;
        _headImageView.userInteractionEnabled = YES;
        _headImageView.layer.masksToBounds = YES;
        _headImageView.layer.cornerRadius = 25;
        [_view_head addSubview:_headImageView];

        _typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(kMSScreenWith/2-100, 70, 200, 21)];
        _typeLabel.font = PFR15Font;
        _typeLabel.textColor = [RegularExpressionsMethod ColorWithHexString:BASEBLACKCOLOR];
        _typeLabel.textAlignment = NSTextAlignmentCenter;
        [_view_head addSubview:_typeLabel];

        if ([_billItem.ewm_type integerValue]==2) {
            _headImageView.image = [UIImage imageNamed:@"login_weixin.png"];
            _typeLabel.text = [NSString stringWithFormat: @"分销提现到--微信"];
        }
        else
        {
            _headImageView.image = [UIImage imageNamed:@"login_zfb.png"];
            _typeLabel.text = [NSString stringWithFormat: @"分销提现到--支付宝"];
        }
        _priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(kMSScreenWith/2-100, 100, 200, 21)];
        _priceLabel.font = PFR18Font;
        _priceLabel.textColor = [RegularExpressionsMethod ColorWithHexString:BASEPINK];
        _priceLabel.textAlignment = NSTextAlignmentCenter;
        _priceLabel.text = [NSString stringWithFormat:@"￥%@",_billItem.amount];
        [_view_head addSubview:_priceLabel];

        UIImageView *line3 = ImageViewInit(20, 129, kMSScreenWith-40, 1);
        line3.backgroundColor = [RegularExpressionsMethod ColorWithHexString:@"E6E6E6"];
        [_view_head addSubview:line3];
    }
    return _view_head;

}


#pragma mark - UITableViewDelegate UITableViewDataSource Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arr_typeName.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier0 = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier0];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier0];
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    UILabel *label_type = LabelInit(20, DCMargin, 80, 28);
    label_type.textColor = [RegularExpressionsMethod ColorWithHexString:BASEBLACKCOLOR];
    label_type.font = Font(13);
    label_type.text = self.arr_typeName[indexPath.row];
    [cell addSubview:label_type];


    UILabel *label_value = LabelInit(110, DCMargin, 200, 28);
    label_value.font = Font(14);
    label_value.text = self.arr_valueStr[indexPath.row];
    [cell addSubview:label_value];
    return cell;
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
