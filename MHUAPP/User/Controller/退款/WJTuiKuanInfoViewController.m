//
//  WJTuiKuanInfoViewController.m
//  MHUAPP
//
//  Created by jinri on 2018/6/20.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import "WJTuiKuanInfoViewController.h"
#import "WJWriteListTableCell.h"
#import <UIImageView+WebCache.h>
#import "UIView+UIViewFrame.h"
#import "WJTuiKuanThridTableCell.h"

@interface WJTuiKuanInfoViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong,nonatomic)UITableView *myTableView;

@end

@implementation WJTuiKuanInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [RegularExpressionsMethod ColorWithHexString:kMSVCBackgroundColor];
    [self initSendReplyWithTitle:@"退款中" andLeftButtonName:@"ic_back.png" andRightButtonName:nil andTitleLeftOrRight:YES];
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
        self.myTableView.frame = CGRectMake(0, 0, kMSScreenWith, kMSScreenHeight - kMSNaviHight );
    }
    return _myTableView;
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
    if(indexPath.section ==0)
        return 100;
    else
        return 270;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
     if (indexPath.section==0)
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


        cell.title.text = _goods_name;
        cell.title.frame = CGRectMake(TAG_Height+15, 5, kMSScreenWith- DCMargin * 4-TAG_Height, 40);



        cell.Num.frame =CGRectMake(kMSScreenWith-10, cell.title.Bottom+25, 50, 20);
        cell.Num.text =  [NSString stringWithFormat:@"x%@",_back_goods_number];
        return cell;
    }
    else
    {
        WJTuiKuanThridTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WJTuiKuanThridTableCell"];
        if (cell == nil) {
            cell = [[WJTuiKuanThridTableCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"WJTuiKuanThridTableCell"];
        }
         cell.str_orderNo = _order_sn;
         cell.str_back_id = _back_id;
        NSDateFormatter *stampFormatter = [[NSDateFormatter alloc] init];
        [stampFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
        NSDate *stampDate = [NSDate dateWithTimeIntervalSince1970:[_add_time doubleValue]];
        cell.lab_add_time.text =[NSString stringWithFormat:@"申请时间：%@",[stampFormatter stringFromDate:stampDate]];

        cell.totalPayPrice.text = [NSString stringWithFormat:@"共1件商品 合计：￥%@",_count_price];
        cell.lab_postscript.text =[NSString stringWithFormat:@"退款原因：%@",_str_postscript];


        cell.lab_IsShouhuo.text =[NSString stringWithFormat:@"是否收货：%@",@"是"];

        cell.lab_IsTuihuo.text =[NSString stringWithFormat:@"是否退货：%@", @"是"];
        cell.lab_tuiKuanPrice.text = [NSString stringWithFormat:@"退款金额：￥%@  （包含运费）",_count_price];
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
