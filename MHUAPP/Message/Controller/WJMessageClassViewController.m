//
//  WJMessageClassViewController.m
//  MHUAPP
//
//  Created by wenchengjun on 2017/11/28.
//  Copyright © 2017年 wenchengjun. All rights reserved.
//

#import "WJMessageClassViewController.h"

#import "WJMessageHeadView.h"
#import "WJMessageTableViewCell.h"

@interface WJMessageClassViewController ()<UITableViewDelegate,UITableViewDataSource>

/* tableView */
@property (strong , nonatomic)UITableView *tableView;

@end

@implementation WJMessageClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [RegularExpressionsMethod ColorWithHexString:kMSVCBackgroundColor];
    [self initSendReplyWithTitle:@"消息" andLeftButtonName:nil andRightButtonName:nil andTitleLeftOrRight:YES];
     [self.view addSubview:self.tableView];
    // Do any additional setup after loading the view.
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kMSScreenWith, kMSScreenHeight-49-kMSNaviHight) style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.scrollEnabled = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[WJMessageHeadView class] forHeaderFooterViewReuseIdentifier:@"WJMessageHeadView"];
        [_tableView registerClass:[WJMessageTableViewCell class] forCellReuseIdentifier:@"WJMessageTableViewCell"];
    }
    return _tableView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return 90;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {

    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    WJMessageHeadView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"WJMessageHeadView"];

    return view;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WJMessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WJMessageTableViewCell"];
    if (cell == nil) {
        cell = [[WJMessageTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"WJMessageTableViewCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
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
