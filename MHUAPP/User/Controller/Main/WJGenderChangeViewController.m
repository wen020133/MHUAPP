//
//  WJGenderChangeViewController.m
//  MHUAPP
//
//  Created by jinri on 2018/1/12.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import "WJGenderChangeViewController.h"

@interface WJGenderChangeViewController ()
{
    NSInteger indexPathRow;
}
@end

@implementation WJGenderChangeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [RegularExpressionsMethod ColorWithHexString:kMSVCBackgroundColor];
    [self initSendReplyWithTitle:@"修改性别" andLeftButtonName:@"ic_back.png" andRightButtonName:nil andTitleLeftOrRight:YES];
    [self.view addSubview:self.tab_content];
    self.arr_type = [NSArray arrayWithObjects:@"男",@"女",@"保密", nil];
    indexPathRow = 0;
    // Do any additional setup after loading the view.
}

-(UITableView *)tab_content
{
    if (!_tab_content) {
        _tab_content = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kMSScreenWith, kMSScreenHeight) style:UITableViewStylePlain];
        _tab_content.backgroundColor = [UIColor clearColor];
        _tab_content.separatorColor = [UIColor lightGrayColor];
        _tab_content.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tab_content.scrollEnabled = NO;
        _tab_content.delegate = self;
        _tab_content.dataSource = self;

    }
    return _tab_content;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return self.arr_type.count;
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    NSString *identifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    cell.textLabel.text = [self.arr_type objectAtIndex:indexPath.row];
    cell.tintColor = [UIColor redColor];
    if (indexPathRow == indexPath.row) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
     [RegularExpressionsMethod dc_setUpAcrossPartingLineWith:cell WithColor:[[UIColor lightGrayColor]colorWithAlphaComponent:0.15]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //   取消选中单元格
    [tableView deselectRowAtIndexPath:indexPath animated:NO];

    //   如果点击的这行之前点击过一次 直接返回
    //    if(indexPath.row==self.indexPath)  return;

    //   1.取得点击的那一行的单元格（旧）
    UITableViewCell *oldCell =[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:indexPathRow inSection:0]];
    //   隐藏对号
    oldCell.accessoryType = UITableViewCellAccessoryNone;

    //   2.取得点击的那一行的单元格（新）
    UITableViewCell *newCell = [tableView cellForRowAtIndexPath:indexPath];

    //   显示对号
    newCell.accessoryType = UITableViewCellAccessoryCheckmark;

    //   将点击的行号记录到全局
    indexPathRow=indexPath.row;
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
