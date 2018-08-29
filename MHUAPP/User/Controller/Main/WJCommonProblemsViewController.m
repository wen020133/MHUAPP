//
//  WJCommonProblemsViewController.m
//  MHUAPP
//
//  Created by wenchengjun on 2018/6/14.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import "WJCommonProblemsViewController.h"
#import "WJUserInfoListCel.h"
#import "WJCommonProblemsItem.h"
#import "RigisterProtocolViewController.h"

@interface WJCommonProblemsViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) UITableView *infoTableView;
@property (strong, nonatomic) NSMutableArray <WJCommonProblemsItem *> *arr_typeName;
@end

@implementation WJCommonProblemsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [RegularExpressionsMethod ColorWithHexString:kMSVCBackgroundColor];

     [self initSendReplyWithTitle:@"常见问题" andLeftButtonName:@"ic_back.png" andRightButtonName:nil andTitleLeftOrRight:YES];
    [self initkMSGetArticleClassData];
    [self.view addSubview:self.infoTableView];
    // Do any additional setup after loading the view.
}

-(void)initkMSGetArticleClassData
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *uid = [[userDefaults objectForKey:@"userList"] objectForKey:@"uid" ];
    [self requestGetAPIWithServe:[NSString stringWithFormat:@"%@/%@/%@?user_id=%@",kMSBaseMiYoMeiPortURL,kMSappVersionCode,kMSetArticle,uid]];
}
-(void)getProcessData
{
    if([[self.results objectForKey:@"code"] integerValue] == 200)
    {
        id arr = [self.results objectForKey:@"data"];
        if([arr isKindOfClass:[NSArray class]])
        {
            _arr_typeName =   [WJCommonProblemsItem mj_objectArrayWithKeyValuesArray:arr];
            [_infoTableView reloadData];
        }
    }
    else
    {
        [self requestFailed:@"获取数据失败"];
    }
}

-(UITableView *)infoTableView
{
    if (!_infoTableView) {
        _infoTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kMSScreenWith, kMSScreenHeight-kMSNaviHight)];
        _infoTableView.delegate = self;
        _infoTableView.dataSource = self;
        _infoTableView.backgroundColor =[UIColor clearColor];
        _infoTableView.showsHorizontalScrollIndicator = NO;
        _infoTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        [_infoTableView registerClass:[WJUserInfoListCel class] forCellReuseIdentifier:@"WJUserInfoListCel"];
            }
    return _infoTableView;
}

#pragma mark - UITableViewDelegate UITableViewDataSource Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arr_typeName.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIndentifier = @"WJUserInfoListCel";
    WJUserInfoListCel *cell = (WJUserInfoListCel *)[tableView dequeueReusableCellWithIdentifier:CellIndentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.nameLabel.text = self.arr_typeName[indexPath.row].title;
//    cell.contentLabel.text = self.arr_typeName[indexPath.row].content;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RigisterProtocolViewController *MainWebV = [[RigisterProtocolViewController alloc]init];
    MainWebV.str_content = self.arr_typeName[indexPath.row].content;
    MainWebV.str_title = self.arr_typeName[indexPath.row].title;
    MainWebV.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:MainWebV animated:YES];
    self.hidesBottomBarWhenPushed = YES;
    
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
