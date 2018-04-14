//
//  WJMyFollowViewController.m
//  MHUAPP
//
//  Created by jinri on 2018/4/12.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import "WJMyFollowViewController.h"
#import "WJMyFollowTableViewCell.h"

@interface WJMyFollowViewController ()

@end

@implementation WJMyFollowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [RegularExpressionsMethod ColorWithHexString:kMSVCBackgroundColor];
    [self initSendReplyWithTitle:@"我的关注" andLeftButtonName:@"ic_back.png" andRightButtonName:@"编辑" andTitleLeftOrRight:NO];
    self.arr_Type = [NSArray arrayWithObjects:@"全部商品",@"销量优先",nil];
    // Do any additional setup after loading the view.
}
-(void)showright
{

}
#pragma mark -- 自定义底部视图
- (void)setupCustomBottomView {

    UIView *backgroundView = [[UIView alloc]init];
    backgroundView.backgroundColor = kMSCellBackColor;
    backgroundView.tag = 1000 + 1;
    [self.view addSubview:backgroundView];

    //当有tabBarController时,在tabBar的上面
        backgroundView.frame = CGRectMake(0, kMSScreenHeight -  2*49-kMSNaviHight, kMSScreenWith, 49);


    //全选按钮
    UIButton *selectAll = [UIButton buttonWithType:UIButtonTypeCustom];
    selectAll.titleLabel.font = [UIFont systemFontOfSize:16];
    selectAll.frame = CGRectMake(10, 5, 80, 49 - 10);
    [selectAll setTitle:@" 全选" forState:UIControlStateNormal];
    [selectAll setImage:[UIImage imageNamed:@"user_weigouxuan"] forState:UIControlStateNormal];
    [selectAll setImage:[UIImage imageNamed:@"shipcart_seleHigh"] forState:UIControlStateSelected];
    [selectAll setTitleColor:[RegularExpressionsMethod ColorWithHexString:@"666666"] forState:UIControlStateNormal];
    [selectAll addTarget:self action:@selector(selectAllBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [backgroundView addSubview:selectAll];
    self.allSellectedButton = selectAll;

    //结算按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [RegularExpressionsMethod ColorWithHexString:BASEPINK];
    btn.frame = CGRectMake(kMSScreenWith - 80, 0, 80, 49);
    [btn setTitle:@"去结算" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(goToPayButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [backgroundView addSubview:btn];


}
-(void)addScrollViewHead
{
    _menu_ScrollView = [[MunuView alloc]initWithFrame:CGRectMake(0, 0, kMSScreenWith, 44) withTitles:self.arr_Type];
    _menu_ScrollView.delegate = self;
    [self.view addSubview:_menu_ScrollView];
}

-(UITableView *)mainTableView
{
    if (!_mainTableView) {

        self.mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, kMSScreenWith, kMSScreenHeight-kMSNaviHight-44)];
        self.mainTableView.backgroundColor = [UIColor clearColor];
        self.mainTableView.delegate = self;
        self.mainTableView.dataSource = self;
        [self.mainTableView registerClass:[WJMyFollowTableViewCell class] forCellReuseIdentifier:@"WJMyFollowTableViewCell"];
        self.mainTableView.alwaysBounceVertical = YES;

    }
    return _mainTableView;
}

#pragma mark TableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return 2;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return NO;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WJMyFollowTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WJMyFollowTableViewCell" forIndexPath:indexPath];
    return cell;
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
