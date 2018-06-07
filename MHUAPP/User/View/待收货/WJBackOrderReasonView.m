//
//  WJBackOrderReasonView.m
//  MHUAPP
//
//  Created by jinri on 2018/6/4.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import "WJBackOrderReasonView.h"
#import "WJBackOrderReasonTableCell.h"

@interface WJBackOrderReasonView()<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) NSArray       *Menu_titles;
@property (strong, nonatomic) UITableView *myTableView;
@property (strong, nonatomic) UIView *view_foot;
@property (strong, nonatomic) UIView *view_head;
@end

@implementation WJBackOrderReasonView

- (id)initWithFrame:(CGRect)frame withTitles:(NSArray *)arr
{
    self = [super initWithFrame:frame];
    if (self) {
        _Menu_titles = [[NSArray alloc]initWithArray:arr];
        [self initTableView];
    }
    return self;
}
-(void)initTableView
{
    self.backgroundColor = kMSColorFromRGB(127, 127, 127);
    [self addSubview:self.myTableView];
}
-(UITableView *)myTableView
{
    if (!_myTableView) {
        _myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 140, kMSScreenWith, kMSScreenHeight-140-kMSNaviHight) style:UITableViewStylePlain];
        _myTableView.backgroundColor = [RegularExpressionsMethod ColorWithHexString:kMSVCBackgroundColor];
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
        _myTableView.sectionHeaderHeight = 0;
        _myTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _myTableView.tableHeaderView = self.view_head;
        _myTableView.tableFooterView = self.view_foot;

    }
    return _myTableView;
}

#pragma mark TableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _Menu_titles.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 40;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    WJBackOrderReasonTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WJBackOrderReasonTableCell"];
        if (cell == nil) {
            cell = [[WJBackOrderReasonTableCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"WJBackOrderReasonTableCell"];
        }
    cell.titleLabel.text =_Menu_titles[indexPath.row];
    if (_selectIndexPathRow==indexPath.row) {
        cell.button.image =[UIImage imageNamed:@"shipcart_seleHigh"];
    }
    else
    {
        cell.button.image =[UIImage imageNamed:@"user_weigouxuan"];
    }
        return cell;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WJBackOrderReasonTableCell *selectCell = [_myTableView cellForRowAtIndexPath:indexPath];
    selectCell.select = YES;
    _selectIndexPathRow = indexPath.row;
    [_myTableView reloadData];
}

-(UIView *)view_head
{
    if (!_view_head) {
        _view_head = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kMSScreenWith, 80)];
       _view_head.backgroundColor = [RegularExpressionsMethod ColorWithHexString:kMSVCBackgroundColor];

        UILabel *label = [[UILabel alloc]init];
        label.frame = CGRectMake(40, 20, kMSScreenWith - 100, 40);
        label.font = Font(22);
        label.text = @"退款原因";
        label.textColor = [RegularExpressionsMethod ColorWithHexString:BASEBLACKCOLOR];
        [_view_head addSubview:label];

        UIButton *saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
        saveButton.frame = CGRectMake(kMSScreenWith-35, DCMargin, 25, 25);
        [saveButton setImage:[UIImage imageNamed:@"user_close"] forState:UIControlStateNormal];
        [saveButton addTarget:self action:@selector(hideThisViewNOSelect) forControlEvents:UIControlEventTouchUpInside];
        [_view_head addSubview:saveButton];
    }
    return _view_head;
}

-(UIView *)view_foot
{
    if (!_view_foot) {
        _view_foot = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kMSScreenWith, 100)];
        _view_foot.backgroundColor = [RegularExpressionsMethod ColorWithHexString:kMSVCBackgroundColor];

        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(20, 20, kMSScreenWith-40, 48);
        [btn setBackgroundColor:[UIColor redColor]];
        [btn setTitle:@"确定" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.layer.cornerRadius = 5.0;
        btn.titleLabel.font = PFR18Font;
        [btn addTarget:self action:@selector(hideThisView) forControlEvents:UIControlEventTouchUpInside];
        [_view_foot addSubview:btn];
    }
    return _view_foot;
}

- (void)hideThisView
{
    if ([self.delegate respondsToSelector:@selector(didSelectedReasonBUttonWithString:)])
{
    [self.delegate didSelectedReasonBUttonWithString:[_Menu_titles objectAtIndex:_selectIndexPathRow]];
}
    [self removeFromSuperview];
}
-(void)hideThisViewNOSelect
{
    [self removeFromSuperview];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
