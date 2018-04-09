//
//  WJMyStoreViewController.m
//  MHUAPP
//
//  Created by jinri on 2018/4/8.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import "WJMyStoreViewController.h"
#import "WJMyStoreTableCell.h"
@interface WJMyStoreViewController ()

@end

@implementation WJMyStoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [RegularExpressionsMethod ColorWithHexString:kMSVCBackgroundColor];
    [self initSendReplyWithTitle:@"我的积分" andLeftButtonName:@"ic_back.png" andRightButtonName:nil andTitleLeftOrRight:YES];
    self.arr_Type = [NSArray arrayWithObjects:@"全部",@"收入",@"支出",nil];
    [self.view addSubview:self.mainTableView];
    // Do any additional setup after loading the view.
}

-(UIView *)view_head
{
    if (!_view_head) {
        _view_head = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kMSScreenWith, 164)];
        _view_head.backgroundColor = [RegularExpressionsMethod ColorWithHexString:kMSVCBackgroundColor];
        
        UIImageView *imagback = ImageViewInit(0, 0, kMSScreenWith, 120);
        imagback.backgroundColor = kMSCellBackColor;
         imagback.image = [UIImage imageNamed:@"main_sspt_haowuyiqipin.jpg"];
        [_view_head addSubview:imagback];

        _menu_ScrollView = [[MunuView alloc]initWithFrame:CGRectMake(0, 120, kMSScreenWith, 44) withTitles:self.arr_Type];
        _menu_ScrollView.delegate = self;
        [_view_head addSubview:_menu_ScrollView];


    }
    return _view_head;

}
- (void)didSelectedButtonWithTag:(NSInteger)currTag
{

}

-(UITableView *)mainTableView
{
    if (!_mainTableView) {

        self.mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kMSScreenWith, kMSScreenHeight-kMSNaviHight-44)];
        self.mainTableView.backgroundColor = [UIColor clearColor];
        self.mainTableView.delegate = self;
        self.mainTableView.dataSource = self;
        [self.mainTableView registerClass:[WJMyStoreTableCell class] forCellReuseIdentifier:@"WJMyStoreTableCell"];
        self.mainTableView.alwaysBounceVertical = YES;

        self.mainTableView.tableHeaderView = self.view_head;
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
    WJMyStoreTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WJMyStoreTableCell" forIndexPath:indexPath];
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
