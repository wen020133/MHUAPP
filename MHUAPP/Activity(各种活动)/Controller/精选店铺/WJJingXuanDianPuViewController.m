//
//  WJJingXuanDianPuViewController.m
//  MHUAPP
//
//  Created by jinri on 2018/4/8.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import "WJJingXuanDianPuViewController.h"
#import "MJRefresh.h"
#import "SLCommentsModel.h"
#import "WJJingXuanDianPuCollectionViewCell.h"
//#import "WJJingXuanDPfootView.h"
//#import "WJJingXuanDPTuiJianCell.h"

@interface WJJingXuanDianPuViewController ()
{
    CGFloat _cellHeight;
}
@end

@implementation WJJingXuanDianPuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSendReplyWithTitle:@"精选店铺" andLeftButtonName:@"ic_back.png" andRightButtonName:nil andTitleLeftOrRight:YES];
    self.view.backgroundColor = [RegularExpressionsMethod ColorWithHexString:kMSVCBackgroundColor];
    _arr_Type = [NSMutableArray array];
    _arr_TypeID = [NSMutableArray array];

    self.arr_infomationresults = [NSMutableArray array];

    self.page_Information=1;

    [self getStreetCategory];
    [self.view addSubview:self.collectionV];
    // Do any additional setup after loading the view.
}
-(void)getStreetCategory
{
    _serverType = 1;
    [self requestGetAPIWithServe:[NSString stringWithFormat:@"%@/%@/%@",kMSBaseMiYoMeiPortURL,kMSappVersionCode,kMSGetStreetCategory]];
}

-(void)getProcessData
{
    if([[self.results objectForKey:@"code"] integerValue] == 200)
    {
        if (_serverType ==1) {
            NSArray *arrType = [self.results objectForKey:@"data"];
            if (arrType&&arrType.count>0) {
                for (NSDictionary *dic in arrType) {
                    [_arr_Type addObject:dic[@"str_name"]];
                    [_arr_TypeID addObject:dic[@"str_id"]];
                }
                [self addhotsellControlView];
            }
        }
        else
        {
            NSArray *arr_Datalist = [NSArray array];
            arr_Datalist = [self.results objectForKey:@"data"];
            NSMutableArray *entities = [NSMutableArray array];
            if (arr_Datalist&&arr_Datalist.count>0) {
                for (NSDictionary *dict in arr_Datalist) {
                    SLCommentsModel *model = [[SLCommentsModel alloc]init];
                    model.may_goods = [dict objectForKey:@"may_goods"];
                    NSLog(@"图片arr===%@",model.may_goods);
                    model.logo = ConvertNullString([dict objectForKey:@"logo"]);
                    model.supplier_name = [dict  objectForKey:@"supplier_name"];
                    model.supplier_title = [NSString stringWithFormat:@"%@",[dict  objectForKey:@"supplier_title"]];
                    model.supplier_id = [NSString stringWithFormat:@"%@",[dict objectForKey:@"supplier_id"]];
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
//                if (self.page_Information*10 >= self.totleCount_Information)
//                {
//                    [self.collectionV.mj_footer endRefreshingWithNoMoreData];
//                }
//                else{
//                    self.collectionV.mj_footer.hidden = NO;
//                }
            }
        }

    }
    else
    {
        [SVProgressHUD showErrorWithStatus:[self.results objectForKey:@"msg"]];
        return;
    }
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
//        [_collectionV registerClass:[WJJingxuanDianPuHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"WJJingxuanDianPuHeadView"];
//        [_collectionV registerClass:[WJJingXuanDPTuiJianCell class] forCellWithReuseIdentifier:@"WJJingXuanDPTuiJianCell"];

        [_collectionV registerClass:[WJJingXuanDianPuCollectionViewCell class] forCellWithReuseIdentifier:@"WJJingXuanDianPuCollectionViewCell"];

//        [_collectionV registerClass:[WJJingXuanDPfootView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"WJJingXuanDPfootView"];
    }
    return _collectionV;
}
- (void)didSelectedButtonWithTag:(NSInteger)currTag
{
    [self getStreetGoods:currTag];
}

-(void)addhotsellControlView
{
    
    _menu_ScrollView = [[MenuScrollView alloc]initWithFrame:CGRectMake(0, 0, kMSScreenWith, 44) withTitles:_arr_Type  withScrollViewWidth:kMSScreenWith];
    _menu_ScrollView.delegate = self;
    [self.view addSubview:_menu_ScrollView];

    [self getStreetGoods:0];
    
}
-(void)getStreetGoods:(NSInteger)tag
{
    _serverType = 2;
    [self requestGetAPIWithServe:[NSString stringWithFormat:@"%@/%@/%@?id=%@",kMSBaseMiYoMeiPortURL,kMSappVersionCode,kMSGetStreetGoods,_arr_TypeID[tag]]];
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







//-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
//{
//    UICollectionReusableView *reusableview = nil;
//
//    if([kind isEqualToString:UICollectionElementKindSectionHeader])
//    {
//        if(indexPath.section == 0)// 顶部滚动广告
//        {
//            WJJingxuanDianPuHeadView *head = [self.collectionV dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"WJJingxuanDianPuHeadView" forIndexPath:indexPath];
//            head.model = self.arr_Type[indexPath.row];
//            reusableview = head;
//        }
//    }
//    if (kind == UICollectionElementKindSectionFooter) {
//        if (indexPath.section == 0) {
//            WJJingXuanDPfootView *footview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"WJJingXuanDPfootView" forIndexPath:indexPath];
//            footview.Menu_titles = self.arr_Type;
//            [footview setUIScrollView];
//            footview.goToHuoDongClassTypeAction = ^(NSInteger typeID) {
//
//            };
//            reusableview = footview;
//        }
//    }
//    return reusableview;
//
//}



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
//#pragma mark - head宽高
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
//    return (section == 0) ?  CGSizeMake(kMSScreenWith, 160)  : CGSizeZero;
//}

#pragma mark - foot宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    if (section == 0) {
        return CGSizeMake(kMSScreenWith, 80);
    }
    return CGSizeZero;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _arr_infomationresults.count;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SLCommentsModel *model = _arr_infomationresults[indexPath.row];
    if (model.may_goods.count>0) {
        return CGSizeMake(kMSScreenWith, 200+(kMSScreenWith-DCMargin*2)/4);
    }
    else
    return CGSizeMake(kMSScreenWith, 176);
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{

    WJJingXuanDianPuCollectionViewCell *cell = [self.collectionV dequeueReusableCellWithReuseIdentifier:@"WJJingXuanDianPuCollectionViewCell" forIndexPath:indexPath];
    cell.model = _arr_infomationresults[indexPath.row];
    return cell;
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
