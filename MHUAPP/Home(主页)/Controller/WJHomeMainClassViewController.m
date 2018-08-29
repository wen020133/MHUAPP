//
//  WJHomeMainClassViewController.m
//  MHUAPP
//
//  Created by wenchengjun on 2017/11/28.
//  Copyright © 2017年 wenchengjun. All rights reserved.
//

#import "WJHomeMainClassViewController.h"

#import "WJSecondsKillViewController.h"
#import "WJSearchViewController.h"

#import "WJGoodDetailViewController.h"
#import "WJSSPTDetailClassViewController.h"
//#import "WJShiShiPinTuanMainViewController.h"  //有分类的拼团
#import "WJSSPTTypeViewController.h"    //没有分类的拼团

#import "WJHuoDongZhuanTiMainViewController.h"
#import "WJHotSellingViewController.h"
#import "WJIntegralListViewController.h"
#import "WJYouZhiXinPinViewController.h"
#import "WJJingXuanDianPuViewController.h"
#import "WJLoginClassViewController.h"

#import "WJADThirdItem.h"
#import "WJGoodsDataModel.h"
#import "WJMainZhuanTiHDItem.h"
#import "WJHomeScrollAdHeadView.h"
#import "WJGoodsGridViewCell.h"
#import "WJGoodsGridModel.h"
#import "WJHomeRecommendCollectionViewCell.h"
#import "WJHomeNavTopView.h"
#import "WJEveryDayMastRobView.h"
#import "WJGoodsCountDownCell.h"
#import "WJCountDownHeadView.h"
#import "WJShiShiPingTuanView.h"
#import "WJShiShiPingTuanCell.h"
#import "WJZhuanTiHuoDongCell.h"
//#import "WJJingXuanShopCell.h"
#import "WJPeopleTuiJianCell.h"
#import "WJNewTuiJianCell.h"
#import "HWScanViewController.h"
#import "WJMainWebClassViewController.h"

#import <MJRefresh.h>
#import "WJHomeRefreshGifHeader.h"


#import "AESCrypt.h"
#import "SRWebSocket.h"
#import "WJToast.h"

@interface WJHomeMainClassViewController ()<SRWebSocketDelegate>

@property (strong, nonatomic) NSMutableArray <WJGoodsDataModel *>  *headImageArr;
@property (strong, nonatomic) NSArray <WJADThirdItem *>  *adImageArr;
@property (strong, nonatomic) NSArray <WJMainZhuanTiHDItem *>  *zhuantiHDImageArr;

@property (strong, nonatomic) NSArray  *newshangshiArr;
@property (strong, nonatomic) NSArray  *miaoshaArr;
@property (strong, nonatomic) NSArray  *jingXuanShopArr;

@property NSInteger page_Information;

@property(nonatomic,strong) SRWebSocket *webSocket;
@end

@implementation WJHomeMainClassViewController

#pragma mark - LifeCyle
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self Reconnect];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

//初始化
- (void)Reconnect{
    
    NSLog(@"1221---open");
    
    self.webSocket.delegate = nil;
    [self.webSocket close];
    
    NSString *str_url = @"";
    str_url =  @"wss://www.miyomei.com:8080/order";
    self.webSocket = [[SRWebSocket alloc] initWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str_url]]];
    self.webSocket.delegate = self;
    
    [self.webSocket open];
}



- (void)viewDidDisappear:(BOOL)animated{
    // Close WebSocket
    self.webSocket.delegate = nil;
    [self.webSocket close];
    self.webSocket = nil;
}

//连接成功
//代理方法实现
#pragma mark - SRWebSocketDelegate
- (void)webSocketDidOpen:(SRWebSocket *)webSocket{
    NSLog(@"Websocket Connected");
}
//连接失败
- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error{
    NSLog(@":( Websocket Failed With Error %@", error);
    
    self.title = @"Connection Failed! (see logs)";
    self.webSocket = nil;
}
//接收到新消息的处理
- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message{
   
    NSLog(@"%@--askl",message);
    NSData *jsonData = [message dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *err;
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
    }
    else
    {
        WEAKSELF
        [WJToast showToastWithMessage:[dic objectForKey:@"user_name"] checkCouponButtonClickedBlock:^{
            WJGoodDetailViewController *dcVc = [[WJGoodDetailViewController alloc] init];
            dcVc.goods_id = dic[@"goods_id"];;
            dcVc.hidesBottomBarWhenPushed = YES;
            [weakSelf.navigationController pushViewController:dcVc animated:YES];
            weakSelf.hidesBottomBarWhenPushed = NO;
        }];
    }
    
}
//连接关闭
- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean{
    NSLog(@"Closed Reason:%@",reason);
    self.title = @"Connection Closed! (see logs)";
    self.webSocket = nil;
}

- (void)webSocket:(SRWebSocket *)webSocket didReceivePong:(NSData *)pongPayload{
    
    NSString *reply = [[NSString alloc] initWithData:pongPayload encoding:NSUTF8StringEncoding];
    NSLog(@"reply==%@",reply);
}


- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [RegularExpressionsMethod ColorWithHexString:kMSVCBackgroundColor];
    self.page_Information = 1;
    [self setHomeViewUpNav];
    self.headImageArr = [NSMutableArray array];
    
    [self setUpRecData];
    
    [self.view addSubview:self.collectionV];

//    NSString *encryptedData = [AESCrypt encrypt:@"123456" password:@"miyomei2018"];
//    NSString *message = [AESCrypt decrypt:encryptedData password:@"miyomei2018"];
//    NSLog(@"654321==%@  ",encryptedData);

    //返回顶部
    CGRect loginImageViewRect = CGRectMake(kMSScreenWith - 40,kMSScreenHeight-kMSNaviHight - 100 , 27, 27);
    _backTopImageView = [[UIImageView alloc] initWithFrame:loginImageViewRect];
    _backTopImageView.image = [UIImage imageNamed:@"img_backTop"];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]init];
    [tap addTarget:self action:@selector(backTop)];
    [_backTopImageView addGestureRecognizer:tap];
    _backTopImageView.userInteractionEnabled = YES;
    [self.view addSubview:_backTopImageView];
    _backTopImageView.hidden = YES;

    

    [self setUpGIFRrfresh];


    // Do any additional setup after loading the view.
}
#pragma mark - 设置头部header
- (void)setUpGIFRrfresh
{
    _collectionV.mj_header = [WJHomeRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(setUpRecData)];
    _collectionV.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footGoodsRereshingCircle)];
}

-(void)setUpRecData
{
    self.page_Information = 1;
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(1);
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_async(group, queue, ^{
        NSLog(@"处理事件A");
        [self getServiceData:@"goods?id=1"];
        dispatch_semaphore_signal(semaphore);
    });
    dispatch_group_async(group, queue, ^{
        NSLog(@"处理事件B");
        [self getServiceData:kMSMainGetTopic];
        dispatch_semaphore_signal(semaphore);
    });
    dispatch_group_async(group, queue, ^{
        NSLog(@"处理事件C");
        [self getServiceData:kMSMainGetAdThird];
        dispatch_semaphore_signal(semaphore);
    });
    dispatch_group_async(group, queue, ^{
        NSLog(@"处理事件D");
        [self getServiceData:@"getIsNewGoods?id=1"];
        dispatch_semaphore_signal(semaphore);
    });
    dispatch_group_async(group, queue, ^{
        NSLog(@"处理事件E");
        [self getServiceData:kMSGetToday];
        dispatch_semaphore_signal(semaphore);
    });
//    dispatch_group_async(group, queue, ^{
//        NSLog(@"处理事件F");
//        [self getServiceData:@"getStreet?id=10000"];
//        dispatch_semaphore_signal(semaphore);
//    });
    dispatch_group_notify(group, queue, ^{
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
//        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        dispatch_group_notify(group, dispatch_get_main_queue(), ^{
            [_collectionV reloadData];
            [_collectionV.mj_header endRefreshing];
        });
    });

}
-(void)getServiceData:(NSString *)urlString
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/xml",@"text/html", nil];


    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970];  //  *1000 是精确到毫秒，不乘就是精确到秒
    NSString *timeString = [NSString stringWithFormat:@"%.0f",a ]; //转为字符型
    NSString *token = [[NSString stringWithFormat:@"mhupro_%@_mhupro",[timeString md5]] md5];
    NSString *url  = @"";
    if ([urlString containsString:@"id="]) {
        url  = [NSString stringWithFormat:@"%@/%@/%@&time=%@&token=%@",kMSBaseMiYoMeiPortURL,kMSappVersionCode,urlString,timeString,token];
    }
    else
    {
        url  = [NSString stringWithFormat:@"%@/%@/%@?time=%@&token=%@",kMSBaseMiYoMeiPortURL,kMSappVersionCode,urlString,timeString,token];
    }
    NSLog(@"url====%@",url);

    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         [SVProgressHUD dismiss];
        if([[responseObject objectForKey:@"code"] integerValue] == 200)
        {
          if ([urlString isEqualToString:@"goods?id=1"]) {
            NSLog(@"%@====%@",urlString,responseObject);
         id arr = [responseObject objectForKey:@"data"];
        if([arr isKindOfClass:[NSArray class]])
        {
            self.headImageArr =   [WJGoodsDataModel mj_objectArrayWithKeyValuesArray:arr];
            [_collectionV reloadData];
        }

        }
        if ([urlString isEqualToString:kMSMainGetAdThird]) {
            id arr = [[[responseObject objectForKey:@"data"] objectAtIndex:0] objectForKey:@"items"];
            NSLog(@"%@====%@",urlString,responseObject);
            if([arr isKindOfClass:[NSArray class]])
            {
                self.adImageArr =   [WJADThirdItem mj_objectArrayWithKeyValuesArray:arr];
                [_collectionV reloadData];
            }

        }
        if ([urlString isEqualToString:kMSMainGetTopic]) {
            id arr = [responseObject objectForKey:@"data"];
            if([arr isKindOfClass:[NSArray class]])
            {
                _zhuantiHDImageArr =   [WJMainZhuanTiHDItem mj_objectArrayWithKeyValuesArray:arr];
            }
        }
        if ([urlString isEqualToString:@"getIsNewGoods?id=1"]) {
            NSLog(@"%@====%@",urlString,responseObject);
            id arr = [[responseObject objectForKey:@"data"] objectForKey:@"data"];
            if([arr isKindOfClass:[NSArray class]])
            {
                _newshangshiArr =  arr;
                 [_collectionV reloadData];
            }
         }
            if ([urlString isEqualToString:kMSGetToday]) {

                id arr = [responseObject objectForKey:@"data"];
                if([arr isKindOfClass:[NSArray class]])
                {
                    self.miaoshaArr = arr;
                }
            }
            if ([urlString isEqualToString:@"getStreet?id=10000"]) {
//                NSLog(@"%@====%@",urlString,responseObject);
                id arr = [responseObject objectForKey:@"data"];
                if([arr isKindOfClass:[NSArray class]])
                {
                    self.jingXuanShopArr = arr;
                }
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
}

-(void)footGoodsRereshingCircle
{
    _page_Information++;
    [self requestGetAPIWithServe:[NSString stringWithFormat:@"%@/%@/%@?id=%ld",kMSBaseMiYoMeiPortURL,kMSappVersionCode,kMSMainGoods100,_page_Information]];
}
-(void)getProcessData
{
    [_collectionV.mj_header endRefreshing];
    [_collectionV.mj_footer endRefreshing];
    if([[self.results objectForKey:@"code"] integerValue] == 200)
    {
        
        NSMutableArray *arr_Datalist = [NSMutableArray array];
        arr_Datalist = [self.results objectForKey:@"data"];
        NSMutableArray *entities = [NSMutableArray array];
        if (![arr_Datalist isKindOfClass:[NSNull class]]&&arr_Datalist.count>0) {
            entities = [WJGoodsDataModel mj_objectArrayWithKeyValuesArray:arr_Datalist];

            if(_page_Information==1)
            {
                 self.headImageArr = entities;
            }else
            {
                [self.headImageArr addObjectsFromArray:entities];
            }
            [_collectionV reloadData];
            if(entities.count<[kMSPULLtableViewCellNumber integerValue])
            {
                [_collectionV.mj_footer endRefreshingWithNoMoreData];
            }
            else{
                _collectionV.mj_footer.hidden = NO;
            }
        }
        else
        {
           
            [_collectionV.mj_footer endRefreshingWithNoMoreData];
        }
        
    }
    else
    {
        [self requestFailed:[self.results objectForKey:@"msg"]];
    }
}
-(void)setHomeViewUpNav
{
    WJHomeNavTopView *searchBarVc = [[WJHomeNavTopView alloc] initWithFrame:CGRectMake(0, 0, kMSScreenWith, kMSNaviHight)];
    searchBarVc.leftItemClickBlock = ^{
         self.tabBarController.selectedIndex = 1;
//        HWScanViewController *vc = [[HWScanViewController alloc] init];
//        self.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:vc animated:YES];
//        self.hidesBottomBarWhenPushed = NO;
    };
    searchBarVc.rightItemClickBlock = ^{
        self.tabBarController.selectedIndex = 2;
    };
    searchBarVc.searchButtonClickBlock = ^{
        NSLog(@"点击了搜索");
        WJSearchViewController *ddc = [[WJSearchViewController alloc]init];
        ddc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:ddc animated:YES];
        self.hidesBottomBarWhenPushed = NO;

    };
    [self.view addSubview:searchBarVc];
}

- (void)backTop{
    [_collectionV scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:NO];
}


#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //判断回到顶部按钮是否隐藏
    _backTopImageView.hidden = (scrollView.contentOffset.y > 250) ? NO : YES;
}


-(UICollectionView *)collectionV
{
    if (!_collectionV) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        _collectionV = [[UICollectionView alloc]initWithFrame:CGRectMake(0, kMSNaviHight, kMSScreenWith, kMSScreenHeight-kMSNaviHight-kTabBarHeight) collectionViewLayout:layout];
        
        _collectionV.backgroundColor = [UIColor clearColor];
        _collectionV.delegate = self;
        _collectionV.dataSource = self;
        _collectionV.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        [_collectionV registerClass:[WJHomeScrollAdHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"WJHomeScrollAdHeadView"];
        [_collectionV registerClass:[WJCountDownHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"WJCountDownHeadView"];
        [_collectionV registerClass:[WJShiShiPingTuanView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"WJShiShiPingTuanView"];
         [_collectionV registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"common"];
        [_collectionV registerClass:[WJGoodsGridViewCell class] forCellWithReuseIdentifier:@"WJGoodsGridViewCell"];
        
        [_collectionV registerClass:[WJEveryDayMastRobView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"WJEveryDayMastRobView"];
         [_collectionV registerClass:[WJPeopleTuiJianCell class] forCellWithReuseIdentifier:@"WJPeopleTuiJianCell"];
         [_collectionV registerClass:[WJNewTuiJianCell class] forCellWithReuseIdentifier:@"WJNewTuiJianCell"];
        
       [_collectionV registerClass:[WJGoodsCountDownCell class] forCellWithReuseIdentifier:@"WJGoodsCountDownCell"];
        [_collectionV registerClass:[WJZhuanTiHuoDongCell class] forCellWithReuseIdentifier:@"WJZhuanTiHuoDongCell"];
        [_collectionV registerClass:[WJShiShiPingTuanCell class] forCellWithReuseIdentifier:@"WJShiShiPingTuanCell"];
       [_collectionV registerClass:[WJHomeRecommendCollectionViewCell class] forCellWithReuseIdentifier:@"WJHomeRecommendCollectionViewCell"];
//        [_collectionV registerClass:[WJJingXuanShopCell class] forCellWithReuseIdentifier:@"WJJingXuanShopCell"];
    }
    return _collectionV;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    
    if([kind isEqualToString:UICollectionElementKindSectionHeader])
    {
        if(indexPath.section == 0)// 顶部滚动广告
        {
            WJHomeScrollAdHeadView *head = [_collectionV dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"WJHomeScrollAdHeadView" forIndexPath:indexPath];
            head.imageArr = _adImageArr;
            [head setUIInit];
            WEAKSELF
            head.goToADAction = ^(NSInteger index) {
                WJMainWebClassViewController *MainWebV = [[WJMainWebClassViewController alloc]init];
                MainWebV.str_urlHttp = _adImageArr[index].ad_link;
                MainWebV.str_title = _adImageArr[index].ad_name;
                MainWebV.hidesBottomBarWhenPushed = YES;
                [weakSelf.navigationController pushViewController:MainWebV animated:YES];
                weakSelf.hidesBottomBarWhenPushed = NO;
            };
            reusableview = head;
        }

       else if(indexPath.section == 1)// 秒杀
        {
            WJCountDownHeadView *head = [_collectionV dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"WJCountDownHeadView" forIndexPath:indexPath];
            if (self.miaoshaArr.count>0) {
                head.end_time = [[self.miaoshaArr objectAtIndex:0] objectForKey:@"end_time"];
                [head setUpUI];
            }
           
            reusableview = head;
        }
//       else if(indexPath.section == 2)// 时时拼团
//       {
//           WJShiShiPingTuanView *head = [_collectionV dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"WJShiShiPingTuanView" forIndexPath:indexPath];
//           head.titleLabel.text = @"时时拼团";
//           reusableview = head;
//       }
//       else if(indexPath.section == 3)// 专题活动
//       {
//           WJShiShiPingTuanView *head = [_collectionV dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"WJShiShiPingTuanView" forIndexPath:indexPath];
//           head.titleLabel.text = @"专题活动";
//           reusableview = head;
//       }
//       else if(indexPath.section == 4)// 精选店铺
//       {
//           WJShiShiPingTuanView *head = [_collectionV dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"WJShiShiPingTuanView" forIndexPath:indexPath];
//           head.titleLabel.text = @"精选店铺";
//           reusableview = head;
//       }
       else if(indexPath.section == 2)// 新品上市
       {
           WJShiShiPingTuanView *head = [_collectionV dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"WJShiShiPingTuanView" forIndexPath:indexPath];
           head.titleLabel.text = @"新品上市";
           [head.quickButton addTarget:self action:@selector(gotoNewClassView) forControlEvents:UIControlEventTouchUpInside
            ];
           reusableview = head;
       }
//       else if(indexPath.section == 5)// 最新推荐
//       {
//           WJShiShiPingTuanView *head = [_collectionV dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"WJShiShiPingTuanView" forIndexPath:indexPath];
//           head.titleLabel.text = @"最新推荐";
//           reusableview = head;
//       }
        else
        {
            UICollectionReusableView *common = [_collectionV dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"common" forIndexPath:indexPath];
            common.backgroundColor = kMSCellBackColor;

//            UIImageView *imgageV = ImageViewInit(kMSScreenWith/2-40, 12, 16, 16);
//            imgageV.image = [UIImage imageNamed:@"home_Like_icon"];
//            [common addSubview:imgageV];

            UILabel *more = LabelInit(kMSScreenWith/2-40, 0, 80, 40);
            more.textColor = [RegularExpressionsMethod ColorWithHexString:BASELITTLEBLACKCOLOR];
            more.text = @"猜你喜欢";
            [common addSubview:more];
            more.font = PFR16Font;

            reusableview = common;
        }
        
    }
    if (kind == UICollectionElementKindSectionFooter) {
        if (indexPath.section == 0) {
            WJEveryDayMastRobView *footview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"WJEveryDayMastRobView" forIndexPath:indexPath];
            footview.imageArr = _adImageArr;
            WEAKSELF
            footview.goToADAction = ^(NSInteger index) {
                WJMainWebClassViewController *MainWebV = [[WJMainWebClassViewController alloc]init];
                MainWebV.str_urlHttp = _adImageArr[index].ad_link;
                MainWebV.str_urlHttp = _adImageArr[index].ad_name;
                MainWebV.hidesBottomBarWhenPushed = YES;
                [weakSelf.navigationController pushViewController:MainWebV animated:YES];
                weakSelf.hidesBottomBarWhenPushed = NO;
            };
            reusableview = footview;
        }
    }
        return reusableview;
    
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
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return CGSizeMake(kMSScreenWith, kMSScreenWith/2);
    }
    else if(section ==1)
    {
        if(self.miaoshaArr&&self.miaoshaArr.count>0)
        {
     NSArray *arr = [[self.miaoshaArr objectAtIndex:0] objectForKey:@"activity"];
        if (arr.count<1) {
            return CGSizeZero;
        }
            else
            {
                return CGSizeMake(kMSScreenWith, 40);
            }
        }
        else
        {
            return CGSizeZero;
        }
    }
    else
        return CGSizeMake(kMSScreenWith, 40);  //推荐适合的宽高

}

#pragma mark - foot宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    if (section == 0) {
        return CGSizeMake(kMSScreenWith, 200);
    }
    return CGSizeZero;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 4;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 3) {
        return self.headImageArr.count;
    }
    else
    {
        return 1;
    }

}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
            return CGSizeMake(kMSScreenWith, kMSScreenWith/4+88);
    }
        else if(indexPath.section == 1)
        {
            if(self.miaoshaArr&&self.miaoshaArr.count>0)
            {
            NSArray *arr = [[self.miaoshaArr objectAtIndex:0] objectForKey:@"activity"];
            if (arr.count<1) {
                return CGSizeZero;
            }
                else
                {
                     return CGSizeMake(kMSScreenWith, 210);
                }
            }
            else
                return CGSizeZero;
           
        }
        else if(indexPath.section ==2)
        {
            return CGSizeMake(kMSScreenWith, 190);
        }
//        else if(indexPath.section ==4)
//        {
//            return CGSizeMake(kMSScreenWith, 250);
//        }
    else
    {
        return CGSizeMake(kMSScreenWith/2-1, 260);
    }
    
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *gridcell = nil;
    if (indexPath.section == 0) {
        
            WJGoodsGridViewCell *cell = [_collectionV dequeueReusableCellWithReuseIdentifier:@"WJGoodsGridViewCell" forIndexPath:indexPath];
//                cell.defaultImgArr = self.headImageArr;
        cell.goToALLTypeAction = ^(NSInteger typeID){//点击了筛选
            [self gotoTypeClassWithID:typeID];
        };
            gridcell = cell;
     
    }
    else if (indexPath.section == 1)
    {
        WJGoodsCountDownCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WJGoodsCountDownCell" forIndexPath:indexPath];
        if (self.miaoshaArr.count>0) {
            cell.countDownItem = [[_miaoshaArr objectAtIndex:0] objectForKey:@"activity"];
            [cell setUpUI];
            cell.goToGoodDetailClass = ^(NSDictionary *dic_goods) {
                [self gotoMiaoShaGoodDetailWithGoodId:dic_goods];
            };
        }
            gridcell = cell;
        
    }
    else if (indexPath.section == 2)  //新品上市
    {
        WJNewTuiJianCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WJNewTuiJianCell" forIndexPath:indexPath];
        cell.countDownItem = _newshangshiArr;
        [cell setUpUI];
        cell.goToGoodDetailClass = ^(NSDictionary *dic_goods) {
            [self goToGoodsDetailWithGoodId:dic_goods];
        };
        gridcell = cell;

    }
//    else if (indexPath.section == 2)
//    {
//        WJShiShiPingTuanCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WJShiShiPingTuanCell" forIndexPath:indexPath];
//        gridcell = cell;
//
//    }
//    else if (indexPath.section == 3)
//    {
//        WJZhuanTiHuoDongCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WJZhuanTiHuoDongCell" forIndexPath:indexPath];
//        cell.arr_data = self.zhuantiHDImageArr;
//        [cell setUpUIZhuanTi];
//        gridcell = cell;
//
//    }
//    else if (indexPath.section == 4)
//    {
//        WJJingXuanShopCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WJJingXuanShopCell" forIndexPath:indexPath];
//        cell.arr_data = self.jingXuanShopArr;
//        [cell setUpUI];
//        gridcell = cell;
//    }
//    else if (indexPath.section == 4)
//    {
//        WJPeopleTuiJianCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WJPeopleTuiJianCell" forIndexPath:indexPath];
//        cell.arr_tuijiandata = self.peopleTuiJianArr;
//        [cell setUpUI];
//        gridcell = cell;
//    }
//    else if (indexPath.section == 5)
//    {
//        WJNewTuiJianCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WJNewTuiJianCell" forIndexPath:indexPath];
//        gridcell = cell;
//    }
    else
    {
        WJHomeRecommendCollectionViewCell *cell = [_collectionV dequeueReusableCellWithReuseIdentifier:@"WJHomeRecommendCollectionViewCell" forIndexPath:indexPath];
        cell.model = _headImageArr[indexPath.row];
        gridcell = cell;
    }
    return gridcell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 3) {
        WJGoodDetailViewController *dcVc = [[WJGoodDetailViewController alloc] init];
        dcVc.goods_id = _headImageArr[indexPath.row].goods_id;
//        dcVc.goodTitle = self.headImageArr[indexPath.row].goods_name;
//        dcVc.goodPrice = self.headImageArr[indexPath.row].shop_price;
//        dcVc.goodSubtitle = self.headImageArr[indexPath.row].goods_title;
//        dcVc.shufflingArray = self.headImageArr[indexPath.row].images;
//        dcVc.goodImageView = self.headImageArr[indexPath.row].goods_thumb;
        dcVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:dcVc animated:YES];
         self.hidesBottomBarWhenPushed = NO;
    }
}

- (void)gotoMiaoShaGoodDetailWithGoodId:(NSDictionary *)DicGoods
{
    WJSSPTDetailClassViewController *dcVc = [[WJSSPTDetailClassViewController alloc] init];
    dcVc.goods_id = DicGoods[@"goods_id"];
    dcVc.info_id =  DicGoods[@"info_id"];
    dcVc.endTimeStr = [[_miaoshaArr objectAtIndex:0] objectForKey:@"end_time"];
    dcVc.info_classType = @"秒杀";
    dcVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:dcVc animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}
-(void)goToGoodsDetailWithGoodId:(NSDictionary *)DicGoods
{
    WJGoodDetailViewController *dcVc = [[WJGoodDetailViewController alloc] init];
    dcVc.goods_id = DicGoods[@"goods_id"];;
    dcVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:dcVc animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}
-(void)gotoTypeClassWithID:(NSInteger)tag
{
    switch (tag) {
        case 1000:
            {
                self.hidesBottomBarWhenPushed = YES;
                WJSecondsKillViewController *dcVc = [[WJSecondsKillViewController alloc] init];
                [self.navigationController pushViewController:dcVc animated:YES];
                self.hidesBottomBarWhenPushed = NO;
            }
            break;
        case 1001:
        {
            self.hidesBottomBarWhenPushed = YES;
            WJSSPTTypeViewController *dcVc = [[WJSSPTTypeViewController alloc] init];
            [self.navigationController pushViewController:dcVc animated:YES];
            self.hidesBottomBarWhenPushed = NO;
        }
            break;
        case 1002:
        {
            [self jxt_showAlertWithTitle:@"消息提示" message:@"活动暂未开放。敬请期待！" appearanceProcess:^(JXTAlertController * _Nonnull alertMaker) {
                alertMaker.
                addActionCancelTitle(@"确定");
            } actionsBlock:^(NSInteger buttonIndex, UIAlertAction * _Nonnull action, JXTAlertController * _Nonnull alertSelf) {
                if (buttonIndex == 0) {
                    NSLog(@"cancel");
                }

                NSLog(@"%@--%@", action.title, action);
            }];
//            self.hidesBottomBarWhenPushed = YES;
//            WJHuoDongZhuanTiMainViewController *dcVc = [[WJHuoDongZhuanTiMainViewController alloc] init];
//            [self.navigationController pushViewController:dcVc animated:YES];
//            self.hidesBottomBarWhenPushed = NO;
        }
            break;
        case 1003:
        {
            self.hidesBottomBarWhenPushed = YES;
            WJJingXuanDianPuViewController *dcVc = [[WJJingXuanDianPuViewController alloc] init];
            [self.navigationController pushViewController:dcVc animated:YES];
            self.hidesBottomBarWhenPushed = NO;
        }
            break;
        case 1004:
        {
            self.hidesBottomBarWhenPushed = YES;
            WJHotSellingViewController *dcVc = [[WJHotSellingViewController alloc] init];
            [self.navigationController pushViewController:dcVc animated:YES];
            self.hidesBottomBarWhenPushed = NO;
        }
            break;
        case 1005:
        {
            self.hidesBottomBarWhenPushed = YES;
            WJYouZhiXinPinViewController *dcVc = [[WJYouZhiXinPinViewController alloc] init];
            [self.navigationController pushViewController:dcVc animated:YES];
            self.hidesBottomBarWhenPushed = NO;
        }
            break;
        case 1006:
        {
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            
            NSString *loginState = [userDefaults objectForKey:@"loginState"];
            if(![loginState isEqualToString:@"1"])
            {
                WJLoginClassViewController *land = [[WJLoginClassViewController alloc]init];
                UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:land];
                [nav.navigationBar setIsMSNavigationBar];
                [self presentViewController:nav animated:NO completion:^{
                }];
                return;
            }
            
            self.hidesBottomBarWhenPushed = YES;
            WJIntegralListViewController *dcVc = [[WJIntegralListViewController alloc] init];
            [self.navigationController pushViewController:dcVc animated:YES];
            self.hidesBottomBarWhenPushed = NO;
        }
            break;
        case 1007:
        {
            self.tabBarController.selectedIndex = 1;
        }
            break;
        default:
            break;
    }
}

-(void)gotoNewClassView
{
    self.hidesBottomBarWhenPushed = YES;
    WJHotSellingViewController *dcVc = [[WJHotSellingViewController alloc] init];
    [self.navigationController pushViewController:dcVc animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
