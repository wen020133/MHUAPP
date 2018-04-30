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
#import "WJShiShiPinTuanMainViewController.h"
#import "WJHuoDongZhuanTiMainViewController.h"
#import "WJHotSellingViewController.h"
#import "WJIntegralListViewController.h"
#import "WJYouZhiXinPinViewController.h"
#import "WJJingXuanDianPuViewController.h"

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
#import "WJJingXuanShopCell.h"
#import "WJPeopleTuiJianCell.h"
#import "WJNewTuiJianCell.h"
#import "HWScanViewController.h"
#import "WJMainWebClassViewController.h"

#import <MJRefresh.h>
#import "WJHomeRefreshGifHeader.h"

@interface WJHomeMainClassViewController ()

@property (strong, nonatomic) NSArray <WJGoodsDataModel *>  *headImageArr;
@property (strong, nonatomic) NSArray <WJADThirdItem *>  *adImageArr;
@property (strong, nonatomic) NSArray <WJMainZhuanTiHDItem *>  *zhuantiHDImageArr;
@property (strong, nonatomic) NSArray  *peopleTuiJianArr;
@property (strong, nonatomic) NSArray  *miaoshaArr;
@property (strong, nonatomic) NSArray  *jingXuanShopArr;
@end

@implementation WJHomeMainClassViewController

#pragma mark - LifeCyle
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [RegularExpressionsMethod ColorWithHexString:kMSVCBackgroundColor];

    [self setHomeViewUpNav];

    [self.view addSubview:self.collectionV];

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

    [self setUpRecData];

    [self setUpGIFRrfresh];


    // Do any additional setup after loading the view.
}
#pragma mark - 设置头部header
- (void)setUpGIFRrfresh
{
    self.collectionV.mj_header = [WJHomeRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(setUpRecData)];
}

-(void)setUpRecData
{
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(1);
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_async(group, queue, ^{
        NSLog(@"处理事件A");
        [self getServiceData:kMSMainGoods100];
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
        [self getServiceData:kMSGetReputation];
        dispatch_semaphore_signal(semaphore);
    });
    dispatch_group_async(group, queue, ^{
        NSLog(@"处理事件E");
        [self getServiceData:kMSGetToday];
        dispatch_semaphore_signal(semaphore);
    });
    dispatch_group_async(group, queue, ^{
        NSLog(@"处理事件F");
        [self getServiceData:@"getStreet?id=10000"];
        dispatch_semaphore_signal(semaphore);
    });
    dispatch_group_notify(group, queue, ^{
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        dispatch_group_notify(group, dispatch_get_main_queue(), ^{
            [self.collectionV reloadData];
            [self.collectionV.mj_header endRefreshing];
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
          if ([urlString isEqualToString:kMSMainGoods100]) {
         id arr = [responseObject objectForKey:@"data"];
        if([arr isKindOfClass:[NSArray class]])
        {
            self.headImageArr =   [WJGoodsDataModel mj_objectArrayWithKeyValuesArray:arr];
            [self.collectionV reloadData];
        }

        }
        if ([urlString isEqualToString:kMSMainGetAdThird]) {
            id arr = [[[responseObject objectForKey:@"data"] objectAtIndex:0] objectForKey:@"items"];
            if([arr isKindOfClass:[NSArray class]])
            {
                self.adImageArr =   [WJADThirdItem mj_objectArrayWithKeyValuesArray:arr];
            }

        }
        if ([urlString isEqualToString:kMSMainGetTopic]) {
            id arr = [responseObject objectForKey:@"data"];
            if([arr isKindOfClass:[NSArray class]])
            {
                self.zhuantiHDImageArr =   [WJMainZhuanTiHDItem mj_objectArrayWithKeyValuesArray:arr];
            }
        }
        if ([urlString isEqualToString:kMSGetReputation]) {
            id arr = [responseObject objectForKey:@"data"];
            if([arr isKindOfClass:[NSArray class]])
            {
                self.peopleTuiJianArr =  arr;
            }
         }
            if ([urlString isEqualToString:kMSGetToday]) {
                NSLog(@"%@====%@",urlString,responseObject);

                id arr = [responseObject objectForKey:@"data"];
                if([arr isKindOfClass:[NSArray class]])
                {
                    self.miaoshaArr = arr;
                }
            }
            if ([urlString isEqualToString:@"getStreet?id=10000"]) {
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


-(void)setHomeViewUpNav
{
    WJHomeNavTopView *searchBarVc = [[WJHomeNavTopView alloc] initWithFrame:CGRectMake(0, 0, kMSScreenWith, 64)];
    searchBarVc.leftItemClickBlock = ^{
        HWScanViewController *vc = [[HWScanViewController alloc] init];
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        self.hidesBottomBarWhenPushed = NO;
    };
    searchBarVc.rightItemClickBlock = ^{

    };
    searchBarVc.searchButtonClickBlock = ^{
        NSLog(@"点击了搜索");
        WJSearchViewController *ddc = [[WJSearchViewController alloc]init];
        self.hidesBottomBarWhenPushed = YES;
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
        _collectionV = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, kMSScreenWith, kMSScreenHeight-64-49) collectionViewLayout:layout];
        
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
        [_collectionV registerClass:[WJJingXuanShopCell class] forCellWithReuseIdentifier:@"WJJingXuanShopCell"];
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
            WJHomeScrollAdHeadView *head = [self.collectionV dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"WJHomeScrollAdHeadView" forIndexPath:indexPath];
            head.imageArr = self.adImageArr;
            [head setUIInit];
            head.goToADAction = ^(NSInteger index) {
                WJMainWebClassViewController *MainWebV = [[WJMainWebClassViewController alloc]init];
                MainWebV.str_urlHttp = self.adImageArr[index].ad_link;
                MainWebV.str_urlHttp = self.adImageArr[index].ad_name;
                self.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:MainWebV animated:YES];
                self.hidesBottomBarWhenPushed = NO;
            };
            reusableview = head;
        }

       else if(indexPath.section == 1)// 秒杀
        {
            WJCountDownHeadView *head = [self.collectionV dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"WJCountDownHeadView" forIndexPath:indexPath];
            head.end_time = [[self.miaoshaArr objectAtIndex:0] objectForKey:@"end_time"];
            [head setUpUI];
            reusableview = head;
        }
       else if(indexPath.section == 2)// 时时拼团
       {
           WJShiShiPingTuanView *head = [self.collectionV dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"WJShiShiPingTuanView" forIndexPath:indexPath];
           head.titleLabel.text = @"时时拼团";
           reusableview = head;
       }
       else if(indexPath.section == 3)// 专题活动
       {
           WJShiShiPingTuanView *head = [self.collectionV dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"WJShiShiPingTuanView" forIndexPath:indexPath];
           head.titleLabel.text = @"专题活动";
           reusableview = head;
       }
       else if(indexPath.section == 4)// 精选店铺
       {
           WJShiShiPingTuanView *head = [self.collectionV dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"WJShiShiPingTuanView" forIndexPath:indexPath];
           head.titleLabel.text = @"精选店铺";
           reusableview = head;
       }
       else if(indexPath.section == 5)// 人气推荐
       {
           WJShiShiPingTuanView *head = [self.collectionV dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"WJShiShiPingTuanView" forIndexPath:indexPath];
           head.titleLabel.text = @"人气推荐";
           reusableview = head;
       }
       else if(indexPath.section == 6)// 最新推荐
       {
           WJShiShiPingTuanView *head = [self.collectionV dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"WJShiShiPingTuanView" forIndexPath:indexPath];
           head.titleLabel.text = @"最新推荐";
           reusableview = head;
       }
        else
        {
            UICollectionReusableView *common = [self.collectionV dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"common" forIndexPath:indexPath];
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
    return 8;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 7) {
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
            return CGSizeMake(kMSScreenWith, kMSScreenWith/4+80);
    }
        else if(indexPath.section == 1||indexPath.section == 2||indexPath.section == 4||indexPath.section == 6)
        {
            return CGSizeMake(kMSScreenWith, 200);
        }
        else if(indexPath.section ==3)
        {
            return CGSizeMake(kMSScreenWith, 160);
        }
        else if(indexPath.section ==5)
        {
            return CGSizeMake(kMSScreenWith, 250);
        }
    else
    {
        return CGSizeMake(kMSScreenWith/2-1, 200);
    }
    
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *gridcell = nil;
    if (indexPath.section == 0) {
        
            WJGoodsGridViewCell *cell = [self.collectionV dequeueReusableCellWithReuseIdentifier:@"WJGoodsGridViewCell" forIndexPath:indexPath];
//                cell.defaultImgArr = self.headImageArr;
        cell.goToALLTypeAction = ^(NSInteger typeID){//点击了筛选
            [self gotoTypeClassWithID:typeID];
        };
            gridcell = cell;
     
    }
    else if (indexPath.section == 1)
    {
            WJGoodsCountDownCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WJGoodsCountDownCell" forIndexPath:indexPath];
        cell.countDownItem = [[self.miaoshaArr objectAtIndex:0] objectForKey:@"activity"];
        [cell setUpUI];
        cell.goToGoodDetailClass = ^(NSString *good_id) {
            [self gotoGoodDetailWithGoodId:good_id];
        };
            gridcell = cell;
        
    }
    else if (indexPath.section == 2)
    {
        WJShiShiPingTuanCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WJShiShiPingTuanCell" forIndexPath:indexPath];
        gridcell = cell;

    }
    else if (indexPath.section == 3)
    {
        WJZhuanTiHuoDongCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WJZhuanTiHuoDongCell" forIndexPath:indexPath];
        cell.arr_data = self.zhuantiHDImageArr;
        [cell setUpUIZhuanTi];
        gridcell = cell;

    }
    else if (indexPath.section == 4)
    {
        WJJingXuanShopCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WJJingXuanShopCell" forIndexPath:indexPath];
        cell.arr_data = self.jingXuanShopArr;
        [cell setUpUI];
        gridcell = cell;
    }
    else if (indexPath.section == 5)
    {
        WJPeopleTuiJianCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WJPeopleTuiJianCell" forIndexPath:indexPath];
        cell.arr_tuijiandata = self.peopleTuiJianArr;
        [cell setUpUI];
        gridcell = cell;
    }
    else if (indexPath.section == 6)
    {
        WJNewTuiJianCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WJNewTuiJianCell" forIndexPath:indexPath];
        gridcell = cell;
    }
    else
    {
        WJHomeRecommendCollectionViewCell *cell = [self.collectionV dequeueReusableCellWithReuseIdentifier:@"WJHomeRecommendCollectionViewCell" forIndexPath:indexPath];
        cell.model = _headImageArr[indexPath.row];
        gridcell = cell;
    }
    return gridcell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 7) {
        WJGoodDetailViewController *dcVc = [[WJGoodDetailViewController alloc] init];
        dcVc.goods_id = _headImageArr[indexPath.row].goods_id;
//        dcVc.goodTitle = self.headImageArr[indexPath.row].goods_name;
//        dcVc.goodPrice = self.headImageArr[indexPath.row].shop_price;
//        dcVc.goodSubtitle = self.headImageArr[indexPath.row].goods_title;
//        dcVc.shufflingArray = self.headImageArr[indexPath.row].images;
//        dcVc.goodImageView = self.headImageArr[indexPath.row].goods_thumb;
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:dcVc animated:YES];
         self.hidesBottomBarWhenPushed = NO;
    }
}

- (void)gotoGoodDetailWithGoodId:(NSString *)goodId
{
    WJGoodDetailViewController *dcVc = [[WJGoodDetailViewController alloc] init];
    dcVc.goods_id = goodId;
    self.hidesBottomBarWhenPushed = YES;
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
            WJShiShiPinTuanMainViewController *dcVc = [[WJShiShiPinTuanMainViewController alloc] init];
            [self.navigationController pushViewController:dcVc animated:YES];
            self.hidesBottomBarWhenPushed = NO;
        }
            break;
        case 1002:
        {
            self.hidesBottomBarWhenPushed = YES;
            WJHuoDongZhuanTiMainViewController *dcVc = [[WJHuoDongZhuanTiMainViewController alloc] init];
            [self.navigationController pushViewController:dcVc animated:YES];
            self.hidesBottomBarWhenPushed = NO;
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
