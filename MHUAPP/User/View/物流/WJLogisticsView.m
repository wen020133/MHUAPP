//
//  WJLogisticsView.m
//  MHUAPP
//
//  Created by jinri on 2018/5/8.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import "WJLogisticsView.h"
#import "WJLogisticsCustomTableCell.h"
#import "WJLogisticsModel.h"

@interface WJLogisticsView()<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic)NSMutableArray *dataArray;

@property (strong, nonatomic)UITableView *table;

@end

@implementation WJLogisticsView
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

-(instancetype)initWithDatas:(NSArray *)array
{
    self = [super init];
    if (self) {
        [self.dataArray addObjectsFromArray:array];
    }
    return self;
}
-(instancetype)init
{
    self = [super init];
    if (self) {
        [self setupUI];
    }
    return self;
}
- (void)reloadDataWithDatas:(NSArray *)array {

    [self.dataArray addObjectsFromArray:array];
    [self.table reloadData];
}
- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }

    return _dataArray;
}

- (void)setWltype:(NSString *)wltype {
    _wltype = wltype;
    self.headerView.wltype = wltype;
}
-(void)setNumber:(NSString *)number {
    _number = number;
    self.headerView.number = number;
}
- (void)setCompany:(NSString *)company {
    _company = company;
    self.headerView.company = company;
}

- (void)setImageUrl:(NSString *)imageUrl {
    _imageUrl = imageUrl;
    self.headerView.imageUrl = imageUrl;
}
- (void)setDatas:(NSArray *)datas {
    if (_datas == datas) {

        _datas = datas;
    }

    [self.table reloadData];
}


- (void)setupUI
{
    UITableView *table = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    table.delegate = self;
    table.dataSource = self;
    table.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:table];
    [table setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    self.table = table;

    [table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];

    //创建TableView的头视图
    self.headerView=[[WJLogisticsTableHeadView alloc]initWithFrame:CGRectMake(0, 0, kMSScreenWith, 103)];;

    self.headerView.userInteractionEnabled=YES;
    self.table.tableHeaderView=self.headerView;

    //注册cell
    [self.table registerClass:[WJLogisticsCustomTableCell class] forCellReuseIdentifier:@"cellLog"];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    WJLogisticsCustomTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellLog"];

    //判断最后一个cell和第一个cell显示
    if (indexPath.row == 0) {
        cell.hasUpLine = NO;
        cell.currented = YES;
    } else {
        cell.hasUpLine = YES;
        cell.currented = NO;
    }

    if (indexPath.row == self.dataArray.count - 1) {
        cell.hasDownLine = NO;
    } else {
        cell.hasDownLine = YES;
    }

    WJLogisticsModel *model = [self.dataArray objectAtIndex:indexPath.row];

    [cell reloadDataWithModel:model];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    WJLogisticsModel *model = [self.dataArray objectAtIndex:indexPath.row];

    return model.height;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {

    return 1;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
