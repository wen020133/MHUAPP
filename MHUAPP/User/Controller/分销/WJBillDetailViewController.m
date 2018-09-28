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

@end

@implementation WJBillDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [RegularExpressionsMethod ColorWithHexString:kMSVCBackgroundColor];
    [self initSendReplyWithTitle:@"账单详情" andLeftButtonName:@"ic_back.png" andRightButtonName:nil andTitleLeftOrRight:YES];
    self.arr_typeName = [NSArray arrayWithObjects:@"姓名：",@"提现金额：",@"收款类型：",@"收款账号：",@"手机号：",@"我的备注：",@"管理员备注：",@"状态：", nil];
    self.arr_valueStr = [NSMutableArray arrayWithObjects:@"",@"",@"",@"",@"",@"",@"",@"", nil];
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
        _infoTableView.showsHorizontalScrollIndicator = NO;
        _infoTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    }
    return _infoTableView;
}
-(void)setBillItem:(WJMoneyListItem *)billItem
{
    
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
    UILabel *label_type = LabelInit(DCMargin, DCMargin, 80, 28);
    label_type.textColor = [RegularExpressionsMethod ColorWithHexString:BASEBLACKCOLOR];
    label_type.font = Font(14);
    label_type.text = self.arr_typeName[indexPath.row];
    [cell addSubview:label_type];


    UILabel *label_value = LabelInit(96, DCMargin, 200, 28);
    label_value.font = Font(15);
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
