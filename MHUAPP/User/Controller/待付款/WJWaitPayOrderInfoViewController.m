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

@interface WJWaitPayOrderInfoViewController ()
@property (strong,nonatomic)UITableView *myTableView;
@end

@implementation WJWaitPayOrderInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [RegularExpressionsMethod ColorWithHexString:kMSVCBackgroundColor];
    [self initSendReplyWithTitle:@"待付款" andLeftButtonName:@"ic_back.png" andRightButtonName:nil andTitleLeftOrRight:YES];

    [self.view addSubview:self.myTableView];

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

        //        [self.myTableView registerClass:[WJCartTableHeaderView class] forHeaderFooterViewReuseIdentifier:@"WJCartTableHeaderView"];
        self.myTableView.frame = CGRectMake(0, 0, kMSScreenWith, kMSScreenHeight - kMSNaviHight );
    }
    return _myTableView;
}


-(void)countPrice {
    double totlePrice = 0.0;

    for (WJCartGoodsModel *model in _dataArray) {

        double price = [model.count_price doubleValue];

        totlePrice += price * model.goods_number;
    }
}


-(void)processData
{
    if([[self.results objectForKey:@"code"] integerValue] == 200)
    {

    }
    else
    {
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
