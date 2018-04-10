//
//  WJJingXuanDianPuViewController.m
//  MHUAPP
//
//  Created by jinri on 2018/4/8.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import "WJJingXuanDianPuViewController.h"
#import "MJRefresh.h"
#import "WJJingxuanDianPuHeadView.h"
#import "SLCommentsModel.h"
#import "WJJingXuanDianPuCollectionViewCell.h"
#import "WJJingXuanDPfootView.h"
#import "WJJingXuanDPTuiJianCell.h"

@interface WJJingXuanDianPuViewController ()
{
    CGFloat _cellHeight;
}
@end

@implementation WJJingXuanDianPuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSendReplyWithTitle:@"精选店铺" andLeftButtonName:@"ic_back.png" andRightButtonName:@"goodInfo_message" andTitleLeftOrRight:YES];
    self.view.backgroundColor = [RegularExpressionsMethod ColorWithHexString:kMSVCBackgroundColor];
    self.arr_Type = [NSArray arrayWithObjects:@"地区",@"人气",@"星级",@"店铺类型", nil];


    self.arr_infomationresults = [NSMutableArray array];

    self.page_Information=1;
    [self addhotsellControlView];

    [self.view addSubview:self.collectionV];
    // Do any additional setup after loading the view.
}
-(UICollectionView *)collectionV
{
    if (!_collectionV) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        _collectionV = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 44, kMSScreenWith, kMSScreenHeight-kMSNaviHight-44) collectionViewLayout:layout];

        _collectionV.backgroundColor = [UIColor clearColor];
        _collectionV.delegate = self;
        _collectionV.dataSource = self;
        _collectionV.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        [_collectionV registerClass:[WJJingxuanDianPuHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"WJJingxuanDianPuHeadView"];
        [_collectionV registerClass:[WJJingXuanDPTuiJianCell class] forCellWithReuseIdentifier:@"WJJingXuanDPTuiJianCell"];

        [_collectionV registerClass:[WJJingXuanDianPuCollectionViewCell class] forCellWithReuseIdentifier:@"WJJingXuanDianPuCollectionViewCell"];

        [_collectionV registerClass:[WJJingXuanDPfootView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"WJJingXuanDPfootView"];
    }
    return _collectionV;
}

-(void)addhotsellControlView
{
    _menu_ScrollView = [[WJJingXuanMenuView alloc]initWithFrame:CGRectMake(0, 0, kMSScreenWith, 44) withTitles:self.arr_Type ];
    _menu_ScrollView.jingxuanShopClickBlock = ^(NSInteger selectTag) {

    };
    [self.view addSubview:_menu_ScrollView];
}
-(void)showright
{
    if (self.menu_ScrollView.hidden) {

        [UIView animateWithDuration:0.2 animations:^{
            self.menu_ScrollView.hidden = NO;
            self.collectionV.frame = CGRectMake(0, 44, kMSScreenWith, kMSScreenHeight-kMSNaviHight-44);
        }];

    }
    else
    {
        [UIView animateWithDuration:0.2 animations:^{
        self.menu_ScrollView.hidden = YES;
        self.collectionV.frame = CGRectMake(0, 0, kMSScreenWith, kMSScreenHeight-kMSNaviHight);
            }];
    }
}
- (void)getinfomationRefresh
{

    // 下拉刷新
    self.collectionV.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRereshingCircle)];
    [self.collectionV.mj_header beginRefreshing];
    // 上拉刷新
    self.collectionV.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRereshingCircle)];

}
-(void)headerRereshingCircle
{
    [self.collectionV.mj_header endRefreshing];
    [self.collectionV.mj_footer endRefreshing];
    _page_Information = 1;
    [self initinfomationClassDataCount];
}

-(void)footerRereshingCircle
{
    _page_Information ++;
    [self initinfomationClassData];
}
-(void)initinfomationClassData
{
    _serverType = 2;
    NSMutableDictionary *infos = [NSMutableDictionary dictionary];
    [infos setValue:kMSPULLtableViewCellNumber forKey:@"forum_sum"];
    [infos setValue:[NSString stringWithFormat:@"%ld",_page_Information] forKey:@"forum_page"];
//    [self requestAPIWithServe:[kMSBaseLargeCollectionPortURL stringByAppendingString:kMSForumExchange] andInfos:infos];
}

-(void)initinfomationClassDataCount
{
    _serverType = 1;
//    NSMutableDictionary *infos = [NSMutableDictionary dictionary];
//    [self requestAPIWithServe:[kMSBaseLargeCollectionPortURL stringByAppendingString:kMSFriendsSumtribune] andInfos:infos];
}

-(void)processData
{
    [self.collectionV.mj_header endRefreshing];
    [self.collectionV.mj_footer endRefreshing];
    if([[self.results objectForKey:@"code"] integerValue] == 200)
    {
        switch (_serverType) {
            case KGetServerSum:
            {
                self.totleCount_Information = [[self.results objectForKey:@"data"]  integerValue];
                if (self.totleCount_Information>0) {
                    [self initinfomationClassData];
                }
            }
                break;
            case KGetDataList:
            {

                NSMutableArray *arr_Datalist = [NSMutableArray array];
                arr_Datalist = [self.results objectForKey:@"data"];
                NSMutableArray *entities = [NSMutableArray array];
                if (![arr_Datalist isEqual:[NSNull null]]) {
                    for (NSDictionary *dict in arr_Datalist) {
                        SLCommentsModel *model = [[SLCommentsModel alloc]init];
                        model.imageArr = ConvertNullString([dict objectForKey:@"img_path"]);
                        NSLog(@"图片arr===%@",model.imageArr);

                        model.headerIconStr = ConvertNullString([[dict objectForKey:@"info"] objectForKey:@"user_img"]);
                        model.headerIconStr =[model.headerIconStr stringByReplacingOccurrencesOfString:@".." withString:@""];
                        model.str_userName = [[dict objectForKey:@"info"] objectForKey:@"user_name"];
                        model.str_huifu = [NSString stringWithFormat:@"%@",[[dict objectForKey:@"info"] objectForKey:@"comm_sum"]];
                        model.str_dianzan = [NSString stringWithFormat:@"%@",[[dict objectForKey:@"info"] objectForKey:@"tribune_lick"]];
                        model.txtContentStr = [[dict objectForKey:@"info"] objectForKey:@"tribune_content"];
                        model.titleStr = [[dict objectForKey:@"info"] objectForKey:@"tribune_title"];
                        model.str_uid = [NSString stringWithFormat:@"%@",[[dict objectForKey:@"info"] objectForKey:@"user_id"]];
                        model.dateStr = [[dict objectForKey:@"info"] objectForKey:@"add_time"];
                        model.str_pid = ConvertNullString([[dict objectForKey:@"info"] objectForKey:@"tribune_id"]);
                        [entities addObject:model];
                    }

                    if(_page_Information==1)
                    {
                        self.arr_infomationresults= entities;
                    }else
                    {
                        [self.arr_infomationresults addObjectsFromArray:entities];
                    }
                    [self.collectionV reloadData];
                    if (self.page_Information*10 >= self.totleCount_Information)
                    {
                        [self.collectionV.mj_footer endRefreshingWithNoMoreData];
                    }
                    else{
                        self.collectionV.mj_footer.hidden = NO;
                    }
                }
            }
                break;
            default:
                break;
        }


    }
    else
    {
        [SVProgressHUD showErrorWithStatus:[self.results objectForKey:@"msg"]];
        return;
    }
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;

    if([kind isEqualToString:UICollectionElementKindSectionHeader])
    {
        if(indexPath.section == 0)// 顶部滚动广告
        {
            WJJingxuanDianPuHeadView *head = [self.collectionV dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"WJJingxuanDianPuHeadView" forIndexPath:indexPath];
            head.model = self.arr_Type[indexPath.row];
            reusableview = head;
        }
    }
    if (kind == UICollectionElementKindSectionFooter) {
        if (indexPath.section == 0) {
            WJJingXuanDPfootView *footview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"WJJingXuanDPfootView" forIndexPath:indexPath];
            footview.Menu_titles = self.arr_Type;
            [footview setUIScrollView];
            footview.goToHuoDongClassTypeAction = ^(NSInteger typeID) {

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
#pragma mark - head宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return (section == 0) ?  CGSizeMake(kMSScreenWith, 160)  : CGSizeZero;
}

#pragma mark - foot宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    if (section == 0) {
        return CGSizeMake(kMSScreenWith, 80);
    }
    return CGSizeZero;
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
        return 4;
    }

}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        return CGSizeMake(kMSScreenWith, 240);
    }
    else
    {
        return CGSizeMake(kMSScreenWith, 200);
    }

}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *gridcell = nil;
    if (indexPath.section == 0) {

        WJJingXuanDPTuiJianCell *cell = [self.collectionV dequeueReusableCellWithReuseIdentifier:@"WJJingXuanDPTuiJianCell" forIndexPath:indexPath];

        gridcell = cell;

    }

    else
    {
        WJJingXuanDianPuCollectionViewCell *cell = [self.collectionV dequeueReusableCellWithReuseIdentifier:@"WJJingXuanDianPuCollectionViewCell" forIndexPath:indexPath];
        gridcell = cell;
    }
    return gridcell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

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
