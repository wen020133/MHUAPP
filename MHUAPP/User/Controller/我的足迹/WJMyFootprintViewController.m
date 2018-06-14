//
//  WJMyFootprintViewController.m
//  MHUAPP
//
//  Created by jinri on 2018/6/6.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import "WJMyFootprintViewController.h"
#import "MJRefresh.h"
#import "WJHomeRefreshGifHeader.h"
#import "UIView+UIViewFrame.h"
#import <UIImageView+WebCache.h>

#import "WJMyFootprintCollectionCell.h"
#import "WJMyFootPrintHeadView.h"
#import "WJGoodDetailViewController.h"

@interface WJMyFootprintViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong , nonatomic) UITableView *myTableView;

@property NSInteger page_Information;



@end

@implementation WJMyFootprintViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [RegularExpressionsMethod ColorWithHexString:kMSVCBackgroundColor];

    [self initSendReplyWithTitle:@"我的足迹" andLeftButtonName:@"ic_back.png" andRightButtonName:nil andTitleLeftOrRight:YES];
    [self.view addSubview:self.myTableView];

    // Do any additional setup after loading the view.
}
-(void)initGetFootmarkClassData
{
     [self requestGetAPIWithServe:[NSString stringWithFormat:@"%@/%@/%@?id=%ld&user_id=%@",kMSBaseMiYoMeiPortURL,kMSappVersionCode,kMSGetFootmark,_page_Information,[AppDelegate shareAppDelegate].user_id]];
}
-(NSMutableArray *)chuliQianArr{
    if (!_chuliQianArr) {
        _chuliQianArr = [NSMutableArray array];
    }
    return _chuliQianArr;
}
-(NSMutableArray *)setItem{
    if (!_setItem) {
        _setItem = [NSMutableArray array];
    }
    return _setItem;
}

-(void)getProcessData
{
    [_myTableView.mj_header endRefreshing];
    [_myTableView.mj_footer endRefreshing];
    if([[self.results objectForKey:@"code"] integerValue] == 200)
    {

        NSArray *arr_Datalist = [[self.results objectForKey:@"data"] objectForKey:@"data"];
        if (arr_Datalist&&arr_Datalist.count>0) {
            if(_page_Information==1)
            {
                NSMutableArray *mutableObject = [arr_Datalist mutableCopy];
                self.chuliQianArr = mutableObject;
            }else
            {
                [self.chuliQianArr addObjectsFromArray:arr_Datalist];
            }
            [self editTheArray:_chuliQianArr];
            [_myTableView reloadData];
            if(arr_Datalist.count<[kMSPULLtableViewCellNumber integerValue])
            {
                [_myTableView.mj_footer endRefreshingWithNoMoreData];
            }
            else{
                _myTableView.mj_footer.hidden = NO;
            }
        }
        else
        {
            [_myTableView.mj_footer endRefreshingWithNoMoreData];
        }

    }
    else
    {
        [self requestFailed:@"获取数据失败"];
    }
}
-(void)editTheArray :(NSMutableArray *)chuliqianArr
{
    NSMutableArray *allTimeArr = [NSMutableArray array];
    NSMutableArray *tempArray = [NSMutableArray array];
    for (NSDictionary *goodsDic in chuliqianArr) {
            NSString *dateTitle = [self timeStamp2Date:goodsDic[@"add_time"]];
            [allTimeArr addObject:dateTitle]; //取出所有数据的时间。yyyy-MM-dd
        }
    NSArray *allTimeNewArr = [self arrayWithMemberIsOnly:allTimeArr]; //排除重复的值

        for (NSString *nowTim in allTimeNewArr) {
            NSMutableArray *arr = [[NSMutableArray alloc] init];


            for (NSDictionary *ordersDicTwo in chuliqianArr) {
              //第一个for循环 取某个值和总数据（chuliqianArr）的比较相同就丢ordersDicTwo进arr
                NSString *twoTim = [self timeStamp2Date:ordersDicTwo[@"add_time"]];
                if([twoTim isEqualToString:nowTim]){
                    [arr addObject:ordersDicTwo];
                }
            }

            [tempArray addObject:@{@"dateTitle":nowTim,@"goodsInfo":arr}];
         //第二个for循环把对应某个dateTitle的值 加入对应的数组
        }
     _setItem = tempArray;
//    //数组倒序
//    _setItem = (NSMutableArray *)[[_setItem reverseObjectEnumerator]allObjects];
}

-(NSString *)timeStamp2Date:(NSString *)datestr
{
    NSTimeInterval interval   =[datestr doubleValue];
    NSDate *date   = [NSDate dateWithTimeIntervalSince1970:interval];

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString  = [formatter stringFromDate: date];
    return dateString;
}
//去除数组中重复的
-(NSArray *)arrayWithMemberIsOnly:(NSArray *)array
{
    NSMutableArray *categoryArray =[[NSMutableArray alloc] init];
    for (unsigned i = 0; i < [array count]; i++) {
        @autoreleasepool {
            if ([categoryArray containsObject:[array objectAtIndex:i]]==NO) {
                [categoryArray addObject:[array objectAtIndex:i]];
            }
        }
    }
    return categoryArray;
}
-(UITableView *)myTableView
{
    if (!_myTableView) {
        _myTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];

        _myTableView.delegate = self;
        _myTableView.dataSource = self;

        _myTableView.rowHeight = 100;
        _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _myTableView.backgroundColor = kMSColorFromRGB(245, 246, 248);

        [self.myTableView registerClass:[WJMyFootPrintHeadView class] forHeaderFooterViewReuseIdentifier:@"WJMyFootPrintHeadView"];

        self.myTableView.frame = CGRectMake(0, 0, kMSScreenWith, kMSScreenHeight - kMSNaviHight);

        self.myTableView.mj_header = [WJHomeRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRereshingCirclefoot)];
        [_myTableView.mj_header beginRefreshing];
          self.myTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRereshingCirclefoot)];
    }
    return _myTableView;
}


-(void)headerRereshingCirclefoot
{
    [_myTableView.mj_header endRefreshing];
    [_myTableView.mj_footer endRefreshing];
    _page_Information = 1;
    [self initGetFootmarkClassData];
}

-(void)footerRereshingCirclefoot
{
    [_myTableView.mj_header endRefreshing];
    [_myTableView.mj_footer endRefreshing];
    _page_Information ++;
    [self initGetFootmarkClassData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *arrAllkeys = _setItem[section][@"goodsInfo"];
    return arrAllkeys.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
     return _setItem.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WJMyFootprintCollectionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WJMyFootprintCollectionCell"];
    if (cell == nil) {
        cell = [[WJMyFootprintCollectionCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"WJMyFootprintCollectionCell"];
    }

    NSArray *arrAllkeys = _setItem[indexPath.section][@"goodsInfo"];
    NSDictionary *dic = [[arrAllkeys objectAtIndex:indexPath.row] objectForKey:@"goods"];
    if (![dic isEqual:[NSNull null]]) {
        NSString *str_url = [dic objectForKey:@"original_img"];
        if (![str_url isEqual:[NSNull null]]) {
            [cell.contentImg sd_setImageWithURL:[NSURL URLWithString:str_url] placeholderImage:[UIImage imageNamed:@"default_nomore.png"] completed:nil];
            NSString *price =@"";
            price = [NSString stringWithFormat:@"￥%@",[[[arrAllkeys objectAtIndex:indexPath.row] objectForKey:@"goods"] objectForKey:@"shop_price"]];
            cell.price.text = price;
            
            
            NSString *saleCount = [NSString stringWithFormat:@"%@",[[[arrAllkeys objectAtIndex:indexPath.row] objectForKey:@"goods"] objectForKey:@"goods_name"]];
            cell.title.text  = saleCount;
        }
    }
    
    
   
    return cell;


}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    WJMyFootPrintHeadView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"WJMyFootPrintHeadView"];

        NSDate *senddate=[NSDate date];
        NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
        [dateformatter setDateFormat:@"yyyy-MM-dd"];
        NSString * locationString=[dateformatter stringFromDate:senddate];
        NSString *dateStr = _setItem[section][@"dateTitle"];
        if ([locationString isEqualToString:dateStr]) {
            headerView.titleLabel.text = @"今天";
        }
        else
        {
            headerView.titleLabel.text = dateStr;
        }

    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return 40;
}

//section底部间距
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 5;

}
//section底部视图
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, kMSScreenWith, 5)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"点击了商品第%zd",indexPath.row);
    WJGoodDetailViewController *dcVc = [[WJGoodDetailViewController alloc] init];
     NSArray *arrAllkeys = _setItem[indexPath.section][@"goodsInfo"];
    dcVc.goods_id = [[arrAllkeys objectAtIndex:indexPath.row] objectForKey:@"goods_id"];
    dcVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:dcVc animated:YES];
}
-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {

    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSMutableArray *arrAllkeys = _setItem[indexPath.section][@"goodsInfo"];

         [self requestDeleteAPIWithServe:[NSString stringWithFormat:@"%@/%@/%@?user_id=%@&str=%@",kMSBaseMiYoMeiPortURL,kMSappVersionCode,kMSDeleteFootmark,[AppDelegate shareAppDelegate].user_id,[[arrAllkeys objectAtIndex:indexPath.row] objectForKey:@"footmark_id"]]];
            //    删除




    }
}
-(void)noOrderListData
{
    UIView *backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kMSScreenWith, kMSScreenHeight - kMSNaviHight)];
    backgroundView.tag = 1000;
    [self.myTableView addSubview:backgroundView];

    //默认图片
    UIImageView *img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"cart_default_bg"]];
    img.center = CGPointMake(kMSScreenWith/2.0, backgroundView.height/2.0 - 140);
    img.bounds = CGRectMake(0, 0, 247.0/187 * 100, 100);
    [backgroundView addSubview:img];

    UILabel *warnLabel = [[UILabel alloc]init];
    warnLabel.center = CGPointMake(kMSScreenWith/2.0, backgroundView.height/2.0 - 70);
    warnLabel.bounds = CGRectMake(0, 0, kMSScreenWith, 30);
    warnLabel.textAlignment = NSTextAlignmentCenter;
    warnLabel.text = @"您还没有浏览过任何商品";
    warnLabel.font = [UIFont systemFontOfSize:16];
    warnLabel.textColor = [RegularExpressionsMethod ColorWithHexString:@"706F6F"];
    [backgroundView addSubview:warnLabel];
}
-(void)deleteProcessData
{
    if([[self.results objectForKey:@"code"] integerValue] == 200)
    {
        [self headerRereshingCirclefoot];
    }
    else
    {
        [SVProgressHUD showErrorWithStatus:[self.results objectForKey:@"msg"]];
        return;
    }
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
