//
//  WJIntegralListViewController.m
//  MHUAPP
//
//  Created by jinri on 2018/3/31.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import "WJIntegralListViewController.h"
#import "WJJiFenItemCell.h"
#import "WJJIFenListCollectionViewCell.h"
#import "WJSSPTTypeHeadView.h"
#import "WJJRPTItem.h"
#import "AppDelegate.h"
#import <MJRefresh.h>

#import "WJIntegralInfoClassViewController.h"
#import "WJIntegralOrderListViewController.h"
#import "WJWordLabelViewController.h"

@interface WJIntegralListViewController ()

//@property (strong, nonatomic) NSArray *arr_HotSellType;
@property (strong, nonatomic) NSMutableArray <WJJRPTItem *> *arr_jiFen;
/** 主题标题 */
@property (nonatomic,strong) NSArray *defaultTitleArr;

@end

@implementation WJIntegralListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSendReplyWithTitle:@"积分商城" andLeftButtonName:@"ic_back.png" andRightButtonName:nil andTitleLeftOrRight:YES];
    self.view.backgroundColor = [RegularExpressionsMethod ColorWithHexString:kMSVCBackgroundColor];
    [self changeDefaultArray];
    [self getUpIntegralData];
    [self.view addSubview:self.collectionView];
    // Do any additional setup after loading the view.
}

-(void)getUpIntegralData
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *uid = [[userDefaults objectForKey:@"userList"] objectForKey:@"uid" ];
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(1);
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_t group = dispatch_group_create();
    WEAKSELF
    dispatch_group_async(group, queue, ^{
        NSLog(@"处理事件1");
        [weakSelf getServiceData:kMSGetIntegralList];
        dispatch_semaphore_signal(semaphore);
    });
    dispatch_group_async(group, queue, ^{
        NSLog(@"处理事件2");
        [weakSelf getServiceData:[NSString stringWithFormat:@"%@?user_id=%@",kMSGetIntegral,uid]];
        dispatch_semaphore_signal(semaphore);
    });

    dispatch_group_notify(group, queue, ^{
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        dispatch_group_notify(group, dispatch_get_main_queue(), ^{

        });
    });

}
-(void)getServiceData:(NSString *)urlString
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/xml",@"text/html", nil];


    NSString *url  = [NSString stringWithFormat:@"%@/%@/%@",kMSBaseMiYoMeiPortURL,kMSappVersionCode,urlString];
    NSLog(@"url====%@",url);

    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD dismiss];
        if([[responseObject objectForKey:@"code"] integerValue] == 200)
        {
            NSLog(@"%@====%@",urlString,responseObject);
            if ([urlString isEqualToString:kMSGetIntegralList]) {
                id arr = [responseObject objectForKey:@"data"];
                if([arr isKindOfClass:[NSArray class]])
                {
                    _arr_jiFen =   [WJJRPTItem mj_objectArrayWithKeyValuesArray:arr];
                     [_collectionView reloadData];
                }

            }
           else {
                _str_IntegralNum = [NSString stringWithFormat:@"%@",[responseObject objectForKey:@"data"]];
                [_collectionView reloadData];
            }
        }
        else
        {
            [SVProgressHUD showErrorWithStatus:[responseObject objectForKey:@"msg"]];
            return;
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 失败，关闭网络指示器
        NSLog(@"ada===%@",[error localizedDescription]);
        NSString *str_error = [error localizedDescription];
        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:str_error];
        return;
    }];
    [_collectionView.mj_header endRefreshing];
}

-(void)processData
{

    if([[self.results objectForKey:@"code"] integerValue] == 200)
    {
        [self jxt_showAlertWithTitle:@"签到成功" message:nil appearanceProcess:^(JXTAlertController * _Nonnull alertMaker) {
            alertMaker.
            addActionCancelTitle(@"确定");
        } actionsBlock:^(NSInteger buttonIndex, UIAlertAction * _Nonnull action, JXTAlertController * _Nonnull alertSelf) {
            if (buttonIndex == 0) {
                NSLog(@"cancel");
            }
        }];
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        NSString *uid = [[userDefaults objectForKey:@"userList"] objectForKey:@"uid" ];
        NSDate *senddate=[NSDate date];
        NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
        [dateformatter setDateFormat:@"YYYY-MM-dd"];
        NSString * locationString=[dateformatter stringFromDate:senddate];
        [userDefaults setValue:locationString forKey:@"tabbarDate"];
        [userDefaults setValue:[NSString stringWithFormat:@"%@111",uid] forKey:@"isQiandao"];
        [userDefaults synchronize];

        _str_IntegralNum = [NSString stringWithFormat:@"%d", [_str_IntegralNum intValue]+1];
        [self changeDefaultArray];
        [_collectionView reloadData];

    }
    else
    {
        [SVProgressHUD showErrorWithStatus:[self.results objectForKey:@"msg"]];
        return;
    }
}
//-(void)addhotsellControlView
//{
//    _menu_jifenScrollView = [[MenuScrollView alloc]initWithFrame:CGRectMake(0, 0, kMSScreenWith, 44) withTitles:self.arr_HotSellType withScrollViewWidth:kMSScreenWith];
//    _menu_jifenScrollView.delegate = self;
//    [self.view addSubview:_menu_jifenScrollView];
//}

-(void)changeDefaultArray
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *uid = [[userDefaults objectForKey:@"userList"] objectForKey:@"uid" ];
    NSString *qiandaoIs = [userDefaults objectForKey:@"isQiandao"];
    NSDate *senddate=[NSDate date];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYY-MM-dd"];
    NSString * locationString=[dateformatter stringFromDate:senddate];
    if ([locationString isEqualToString:[userDefaults objectForKey:@"tabbarDate"]]) {
        if ([qiandaoIs isEqualToString:[NSString stringWithFormat:@"%@111",uid]]) {
            _defaultTitleArr = @[@"积分25000",@"兑换记录",@"已签到",@"如何赚积分"];
        }
        else
        {
            _defaultTitleArr = @[@"积分25000",@"兑换记录",@"签到",@"如何赚积分"];
        }
    }
    else
    {
        _defaultTitleArr = @[@"积分25000",@"兑换记录",@"签到",@"如何赚积分"];
        [userDefaults setValue:@"00" forKey:@"isQiandao"];

    }

    [userDefaults setValue:locationString forKey:@"tabbarDate"];

    [userDefaults synchronize];
}

-(UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kMSScreenWith, kMSScreenHeight-kMSNaviHight) collectionViewLayout:layout];

        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);

        [_collectionView registerClass:[WJSSPTTypeHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"WJSSPTTypeHeadView"];
        [_collectionView registerClass:[WJJiFenItemCell class] forCellWithReuseIdentifier:@"WJJiFenItemCell"];
        [_collectionView registerClass:[WJJIFenListCollectionViewCell class] forCellWithReuseIdentifier:@"WJJIFenListCollectionViewCell"];
        _collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getUpIntegralData)];

    }
    return _collectionView;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;

    if([kind isEqualToString:UICollectionElementKindSectionHeader])
    {
        if(indexPath.section == 0)// 顶部滚动广告
        {
            WJSSPTTypeHeadView *head = [_collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"WJSSPTTypeHeadView" forIndexPath:indexPath];
            reusableview = head;
        }
    }
    return reusableview;

}
#pragma mark - head宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return (section == 0) ?  CGSizeMake(kMSScreenWith, 120)  : CGSizeZero;
}


//定义每个Section的四边间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0,0, 8, 0);//分别为上、左、下、右
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section;
{
    return 2;
}

//两个cell之间的间距（同一行的cell的间距）
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section;
{
    return 2;
}


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    else
    {
        return _arr_jiFen.count;
    }

}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        return CGSizeMake(kMSScreenWith, 84);
    }
    else
    {
        return CGSizeMake(kMSScreenWith/2-2, 240);
    }

}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *gridcell = nil;
    if (indexPath.section == 0) {

        WJJiFenItemCell *cell = [_collectionView dequeueReusableCellWithReuseIdentifier:@"WJJiFenItemCell" forIndexPath:indexPath];
        cell.defaultTitleArr = _defaultTitleArr;
        [cell setupUI];
        cell.str_IntegralNum = _str_IntegralNum;

        cell.goToJiFenClassTypeAction = ^(NSInteger typeID) {
            switch (typeID) {
                case 1000:
                {

                }
                    break;
                case 1001:
                {
                    WJIntegralOrderListViewController *storeInfo = [[WJIntegralOrderListViewController alloc]init];
                    self.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:storeInfo animated:YES];
                }
                    break;
                    case 1002:
                {
                    
                    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                    NSString *uid = [[userDefaults objectForKey:@"userList"] objectForKey:@"uid" ];
                    NSString *qiandaoIs = [userDefaults objectForKey:@"isQiandao"];
                    NSDate *senddate=[NSDate date];
                    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
                    [dateformatter setDateFormat:@"YYYY-MM-dd"];
                    NSString * locationString=[dateformatter stringFromDate:senddate];
                    if ([locationString isEqualToString:[userDefaults objectForKey:@"tabbarDate"]]) {
                        if ([qiandaoIs isEqualToString:[NSString stringWithFormat:@"%@111",uid]]) {
                               [self alectYiQiandao];
                        }
                        else
                        {
                        NSMutableDictionary *infos = [NSMutableDictionary dictionary];
                        [infos setObject:uid forKey:@"user_id"];
                        [self requestAPIWithServe:[kMSBaseMiYoMeiPortURL stringByAppendingString:kMSRegister] andInfos:infos];
                        }
                    }
                    else
                    {
                        [self alectYiQiandao];
                    }

                }
                    break;
                    case 1003:
                {
                    WJWordLabelViewController *MainWebV = [[WJWordLabelViewController alloc]init];
                    MainWebV.str_content = @" 超值换购，兑换好礼享不停！\n 购买商品即送积分，\n 买多少送多少，多买多送，\n 会员注册送100分，\n 每日签到领取积分，\n 单品晒单前10名送100分，\n 最高积分可兑换OPPO A57智能手机一部！\n 看中的赶紧来拿走吧!";
                    MainWebV.str_title = @"赚积分";
                    MainWebV.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:MainWebV animated:YES];
                    self.hidesBottomBarWhenPushed = YES;
                }
                    break;

                default:
                    break;
            }
        };
        gridcell = cell;

    }

    else
    {
        WJJIFenListCollectionViewCell *cell = [_collectionView dequeueReusableCellWithReuseIdentifier:@"WJJIFenListCollectionViewCell" forIndexPath:indexPath];
        cell.model = _arr_jiFen[indexPath.row];
        gridcell = cell;
    }
    return gridcell;
}
-(void)alectYiQiandao
{
    [self jxt_showAlertWithTitle:@"消息提示" message:@"今天已签到。请明天再来" appearanceProcess:^(JXTAlertController * _Nonnull alertMaker) {
        alertMaker.
        addActionCancelTitle(@"确定");
    } actionsBlock:^(NSInteger buttonIndex, UIAlertAction * _Nonnull action, JXTAlertController * _Nonnull alertSelf) {
        if (buttonIndex == 0) {
            NSLog(@"cancel");
        }
    }];
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    WJIntegralInfoClassViewController *storeInfo = [[WJIntegralInfoClassViewController alloc]init];
    storeInfo.str_title =  _arr_jiFen[indexPath.row].goods_name;
    storeInfo.str_integral = _arr_jiFen[indexPath.row].integral;
    storeInfo.str_supplierId = _arr_jiFen[indexPath.row].goods_id;
    storeInfo.str_userIntegral = _str_IntegralNum;
    storeInfo.listModel =_arr_jiFen[indexPath.row];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:storeInfo animated:YES];
}
-(void)dealloc
{
    NSLog(@"释放了");
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
