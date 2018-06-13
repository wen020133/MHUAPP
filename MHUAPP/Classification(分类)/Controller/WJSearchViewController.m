//
//  WJSearchViewController.m
//  MHUAPP
//
//  Created by jinri on 2017/11/30.
//  Copyright © 2017年 wenchengjun. All rights reserved.
//

#import "WJSearchViewController.h"
#import "HXSearchBar.h"
#import "WJGoodDetailViewController.h"
#import "WJStoreInfoClassViewController.h"


@interface WJSearchViewController ()<UISearchBarDelegate>
@property (strong, nonatomic) HXSearchBar *searchBar;
@property NSInteger int_goodOrshop;
@end

@implementation WJSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[RegularExpressionsMethod ColorWithHexString:kMSVCBackgroundColor];
    [self addSearchBar];
    self.int_goodOrshop = 0;
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
    self.navigationItem.titleView = self.searchBar;

    //取消按钮
    self.searchBar.cancleButton.backgroundColor = [UIColor clearColor];
    [self.searchBar.cancleButton setTitle:@"取消" forState:UIControlStateNormal];
    [self.searchBar.cancleButton setTitleColor:kMSCellBackColor forState:UIControlStateNormal];
    self.searchBar.cancleButton.titleLabel.font = [UIFont systemFontOfSize:16];

}


- (void)didSelectedMuluBtnWithTag:(NSInteger)currTag
{
    self.int_goodOrshop = currTag;
    [self getGoodsOrShopDataList:self.searchBar.searchBarTextField.text];
}
-(void)getGoodsOrShopDataList:(NSString *)text
{
    [self.noMoreView hide];
    if (self.int_goodOrshop==0) {
        NSMutableDictionary *infos = [NSMutableDictionary dictionary];
        [infos setObject:text forKey:@"keywords"];
        [self requestAPIWithServe:[kMSBaseLargeCollectionPortURL stringByAppendingString:kMSGoodsfuzzyquery] andInfos:infos];
    }
    else {
        NSMutableDictionary *infos = [NSMutableDictionary dictionary];
        [infos setObject:text forKey:@"store_keywords"];
        [self requestAPIWithServe:[kMSBaseLargeCollectionPortURL stringByAppendingString:kMSGoodsStoreQuery] andInfos:infos];
    }

}
//取消按钮点击的回调
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [self.view endEditing:YES];
    [self.searchBar resignFirstResponder];
    [self.navigationController popViewControllerAnimated:YES];
}
- (BOOL)disablesAutomaticKeyboardDismissal
{
    return NO;
}


- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
   [self.searchBar becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.searchBar resignFirstResponder];
}

#pragma mark - UISearchBar Delegate

//已经开始编辑时的回调
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
     NSLog(@"searchText开始");
    if (searchBar.text.length>0) {
        self.menuScrollView.hidden = NO;
        [self getGoodsOrShopDataList:searchBar.text];
    }
    else
    {
        self.tab_infoView.hidden = YES;
    }
}

//编辑文字改变的回调
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    NSLog(@"searchText:%@",searchText);
    if (searchText.length>0) {
        self.menuScrollView.hidden = NO;
        [self getGoodsOrShopDataList:searchText];
    }
    else
    {
        self.tab_infoView.hidden = YES;
    }

}
-(void)processData
{
    if([[self.results objectForKey:@"code"] integerValue] == 200)
    {

        self.arr_items = nil;
        [self.arr_items removeAllObjects];
        id data = [self.results objectForKey:@"data"];
        if ([data isKindOfClass:[NSArray class]]) {
            _arr_items = data;
            self.noMoreView.hidden = YES;
            self.tab_infoView.hidden = NO;
            [self.view addSubview:self.menuScrollView];
            [self.tab_infoView reloadData];
        }
        else
        {
            self.tab_infoView.hidden = YES;

              self.noMoreView = [[NOMoreDataView alloc]initWithFrame:CGRectMake(0, 44, kMSScreenWith, 80) withContent:@"暂无数据." withNODataImage:@"noMore_bg.png"];
            self.noMoreView.hidden = NO;
             [self.view addSubview:self.noMoreView];
        }
    }
    else
    {
        self.tab_infoView.hidden = YES;
        self.noMoreView = [[NOMoreDataView alloc]initWithFrame:CGRectMake(0, 44, kMSScreenWith, 80) withContent:@"暂无数据." withNODataImage:@"noMore_bg.png"];
        self.noMoreView.hidden = NO;
        [self.view addSubview:self.noMoreView];
    }
}
-(UITableView *)tab_infoView
{
    if (!_tab_infoView) {
        self.tab_infoView = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, kMSScreenWith, kMSScreenHeight-kMSNaviHight-44) style:UITableViewStylePlain];
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

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
    [self.searchBar resignFirstResponder];
}

-(MuluScrollView *)menuScrollView
{
    if (!_menuScrollView) {
        NSArray *arrType = [NSArray arrayWithObjects:@"商品",@"店铺", nil];
        _menuScrollView = [[MuluScrollView alloc]initWithFrame:CGRectMake(0, 0, kMSScreenWith, 44) withTitles:arrType];
        _menuScrollView.delegate = self;
    }
    return _menuScrollView;
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
    if (self.int_goodOrshop==0) {
        cell.textLabel.text = [NSString stringWithFormat:@"%@",[[self.arr_items objectAtIndex:indexPath.row] objectForKey:@"goods_name"]];
    }
    else
    {
      cell.textLabel.text = [NSString stringWithFormat:@"%@",[[self.arr_items objectAtIndex:indexPath.row] objectForKey:@"supplier_name"]];
    }
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.view endEditing:YES];
    [self.searchBar resignFirstResponder];
  if (self.int_goodOrshop==0) {
    WJGoodDetailViewController *dcVc = [[WJGoodDetailViewController alloc] init];
    dcVc.goods_id = [[self.arr_items objectAtIndex:indexPath.row] objectForKey:@"goods_id"];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:dcVc animated:YES];
  }
else
{
    WJStoreInfoClassViewController *storeInfo = [[WJStoreInfoClassViewController alloc]init];
    storeInfo.storeId = [[self.arr_items objectAtIndex:indexPath.row] objectForKey:@"supplier_id"];
    storeInfo.storeLogo = [[self.arr_items objectAtIndex:indexPath.row] objectForKey:@"goods_id"];;
    storeInfo.storeName = [[self.arr_items objectAtIndex:indexPath.row] objectForKey:@"supplier_name"];;
    storeInfo.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:storeInfo animated:YES];
}
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
