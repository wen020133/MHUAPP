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
    // Do any additional setup after loading the view.
}
-(UITableView *)myTableView
{
    if (!_myTableView) {
        _myTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];

        _myTableView.delegate = self;
        _myTableView.dataSource = self;

        _myTableView.rowHeight = 100;
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
        UILabel *label = [[UILabel alloc]init];
        label.font = [UIFont systemFontOfSize:16];
        label.textColor = [RegularExpressionsMethod ColorWithHexString:BASEPINK];
        [backgroundView addSubview:label];

        label.attributedText = [self LZSetString:@"¥0.00"];
        label.frame = CGRectMake(DCMargin, 0, kMSScreenWith - 118, 49);
        label.textAlignment = NSTextAlignmentRight;
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
    
}

#pragma mark --- UITableViewDataSource & UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataArray.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
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
