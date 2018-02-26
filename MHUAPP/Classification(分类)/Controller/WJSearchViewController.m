//
//  WJSearchViewController.m
//  MHUAPP
//
//  Created by jinri on 2017/11/30.
//  Copyright © 2017年 wenchengjun. All rights reserved.
//

#import "WJSearchViewController.h"
#import "HXSearchBar.h"

@interface WJSearchViewController ()<UISearchBarDelegate>
@property (strong, nonatomic) HXSearchBar *searchBar;

@end

@implementation WJSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[RegularExpressionsMethod ColorWithHexString:kMSVCBackgroundColor];
    [self addSearchBar];
    // Do any additional setup after loading the view.
}
//添加搜索条
- (void)addSearchBar {

    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.leftBarButtonItem.customView.hidden=YES;
    //加上 搜索栏
    self.searchBar = [[HXSearchBar alloc] initWithFrame:CGRectMake(10, 0, kMSScreenWith -80, 44)];
    self.searchBar.backgroundColor = [UIColor clearColor];
    //输入框提示
    self.searchBar.searchBarTextField.placeholder = @"快速查找商品";
    //光标颜色
    self.searchBar.cursorColor = [UIColor redColor];
    self.searchBar.delegate = self;
    //TextField
    self.searchBar.searchBarTextField.layer.cornerRadius = 4;
    self.searchBar.searchBarTextField.layer.masksToBounds = YES;
    if (@available(iOS 11.0, *))
    {
        [self.searchBar.heightAnchor constraintLessThanOrEqualToConstant:kEVNScreenNavigationBarHeight].active = YES;
    }
    else
    {

    }
    //清除按钮图标
    self.searchBar.clearButtonImage = [UIImage imageNamed:@"demand_delete"];
    self.navigationItem.titleView = self.searchBar;

    UIButton *cancleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancleButton.backgroundColor = [UIColor clearColor];
    [cancleButton setTitle:@"取消" forState:UIControlStateNormal];
//    [cancleButton setTitleColor:[RegularExpressionsMethod ColorWithHexString:BASEBLACKCOLOR] forState:UIControlStateNormal];
    cancleButton.titleLabel.font = [UIFont systemFontOfSize:19];
     [cancleButton addTarget:self action:@selector(HiddenSerVCrightAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* rightButtonItem = [[UIBarButtonItem alloc] init];
    rightButtonItem.customView = cancleButton;
    self.navigationItem.rightBarButtonItem = rightButtonItem;

}

-(void)HiddenSerVCrightAction
{
     [self.searchBar resignFirstResponder];
//    [self.navigationController popViewControllerAnimated:NO];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
   [self.searchBar becomeFirstResponder];
}



#pragma mark - UISearchBar Delegate

//已经开始编辑时的回调
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
     NSLog(@"searchText开始");
}
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    return YES;
}
- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    return NO;
}
//编辑文字改变的回调
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    NSLog(@"searchText:%@",searchText);

    NSMutableDictionary *infos = [NSMutableDictionary dictionary];
    [infos setObject:searchText forKey:@"keywords"];
    [self requestAPIWithServe:[kMSBaseLargeCollectionPortURL stringByAppendingString:kMSGoodsfuzzyquery] andInfos:infos];
}
-(void)processData
{
    if([[self.results objectForKey:@"code"] integerValue] == 200)
    {
        self.arr_items = nil;
        self.arr_items = [self.results objectForKey:@"data"];
        if (self.arr_items) {
            self.tab_infoView.hidden = NO;
            [self.tab_infoView reloadData];
        }
        else
        {
            self.tab_infoView.hidden = YES;
        }
    }
    else
    {
        return;
    }
}
-(UITableView *)tab_infoView
{
    if (!_tab_infoView) {
        self.tab_infoView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kMSScreenWith, kMSScreenHeight-kMSNaviHight) style:UITableViewStylePlain];
        self.tab_infoView.separatorStyle =UITableViewCellSeparatorStyleNone;
        self.tab_infoView.backgroundColor = [UIColor clearColor];
        self.tab_infoView.dataSource = self;
        self.tab_infoView.delegate = self;
        [self.view addSubview:self.tab_infoView];
    }
    return _tab_infoView;
}
//搜索按钮
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
      NSLog(@"searchText开始了");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arr_items.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIndentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIndentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIndentifier];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@",[[self.arr_items objectAtIndex:indexPath.row] objectForKey:@"goods_name"]];
    return cell;
}/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
