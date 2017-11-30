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
    HXSearchBar *searchBar = [[HXSearchBar alloc] initWithFrame:CGRectMake(10, 0, kMSScreenWith -80, 44)];
    searchBar.backgroundColor = [UIColor clearColor];
    //输入框提示
    searchBar.searchBarTextField.placeholder = @"快速查找商品";
    //光标颜色
    searchBar.cursorColor = [UIColor redColor];
    //TextField
    searchBar.searchBarTextField.layer.cornerRadius = 4;
    searchBar.searchBarTextField.layer.masksToBounds = YES;
    //清除按钮图标
    searchBar.clearButtonImage = [UIImage imageNamed:@"demand_delete"];
    self.navigationItem.titleView = searchBar;

    UIButton *cancleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancleButton.backgroundColor = [UIColor clearColor];
    [cancleButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancleButton setTitleColor:[RegularExpressionsMethod ColorWithHexString:BASEBLACKCOLOR] forState:UIControlStateNormal];
    cancleButton.titleLabel.font = [UIFont systemFontOfSize:19];
     [cancleButton addTarget:self action:@selector(HiddenSerVCrightAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* rightButtonItem = [[UIBarButtonItem alloc] init];
    rightButtonItem.customView = cancleButton;
    self.navigationItem.rightBarButtonItem = rightButtonItem;

}
-(void)HiddenSerVCrightAction
{
    [self.navigationController popViewControllerAnimated:NO];
}

#pragma mark - UISearchBar Delegate

//已经开始编辑时的回调
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {

}

//编辑文字改变的回调
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    NSLog(@"searchText:%@",searchText);
}

//搜索按钮
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {

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
