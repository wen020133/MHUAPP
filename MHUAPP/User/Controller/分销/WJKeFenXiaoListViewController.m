//
//  WJKeFenXiaoListViewController.m
//  MHUAPP
//
//  Created by wenchengjun on 2018/7/27.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import "WJKeFenXiaoListViewController.h"
#import "WJClassificationCollectionHeadView.h"
#import "WJKeFenxiaoListCell.h"
#import "MenuScrollView.h"
#import "WJDepositCateList.h"
#import "NOMoreDataView.h"
#import <UShareUI/UShareUI.h>


@interface WJKeFenXiaoListViewController ()<UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource,MenuBtnDelegate>

@property (strong, nonatomic) NSMutableArray *arr_Type;
@property (strong, nonatomic) NSMutableArray *arr_TypeID;
@property (strong, nonatomic)  NSMutableArray <WJDepositCateList *> *arr_infomationresults;
@property (strong, nonatomic) MenuScrollView *menu_ScrollView; //分类ScrollView
@property (strong, nonatomic) UICollectionView *collectionV;

@property (strong, nonatomic) NOMoreDataView *noMoreView;
/* 价格升/降 */
@property (strong , nonatomic) NSString *type_price;
/* 佣金升/降 */
@property (strong , nonatomic) NSString *type_com;

@property (assign , nonatomic) NSInteger type_title;
@end

@implementation WJKeFenXiaoListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [RegularExpressionsMethod ColorWithHexString:kMSVCBackgroundColor];
    _arr_Type = [NSMutableArray array];
    _arr_TypeID = [NSMutableArray array];
    _type_title = 0;
    self.arr_infomationresults = [NSMutableArray array];
    [self getDepositCateCategory];
    [self.view addSubview:self.collectionV];
    // Do any additional setup after loading the view.
}

-(void)getDepositCateCategory
{
    _serverType = 1;
    [self requestGetAPIWithServe:[NSString stringWithFormat:@"%@/%@/%@",kMSBaseMiYoMeiPortURL,kMSappVersionCode,kMSDepositCate]];
}
-(void)getProcessData
{
    if([[self.results objectForKey:@"code"] integerValue] == 200)
    {
        if (_serverType ==1) {
            NSMutableArray *arrType = [self.results objectForKey:@"data"];
            if (arrType&&arrType.count>0) {
                //倒序
                arrType=  (NSMutableArray *)[[arrType reverseObjectEnumerator]allObjects];
                for (NSDictionary *dic in arrType) {
                    [_arr_Type addObject:dic[@"cat_name"]];
                    [_arr_TypeID addObject:dic[@"cat_id"]];
                }
                [self addfenXiaoListControlView];
            }
        }
        else if(_serverType == 2)
        {
            [_arr_infomationresults removeAllObjects];
            NSArray *arr_Datalist = [NSArray array];
            arr_Datalist = [self.results objectForKey:@"data"];
            if (arr_Datalist&&arr_Datalist.count>0) {
                [self.noMoreView hide];
                _arr_infomationresults=[WJDepositCateList mj_objectArrayWithKeyValuesArray:arr_Datalist];
            }
            else
            {
                [self.noMoreView hide];
                self.noMoreView = [[NOMoreDataView alloc]initWithFrame:CGRectMake(0, 44, kMSScreenWith, 80) withContent:@"暂无可分销商品." withNODataImage:@"noMore_bg.png"];
                [self.collectionV addSubview:self.noMoreView];
            }
             [self.collectionV reloadData];
        }
        
    }
    else
    {
        [SVProgressHUD showErrorWithStatus:[self.results objectForKey:@"data"]];
        return;
    }
}

-(void)addfenXiaoListControlView
{
    _menu_ScrollView = [[MenuScrollView alloc]initWithFrame:CGRectMake(0, 5, kMSScreenWith, 44) withTitles:_arr_Type  withScrollViewWidth:kMSScreenWith];
    _menu_ScrollView.delegate = self;
    [self.view addSubview:_menu_ScrollView];
    [self getfenXiaoListGoods:_type_title];
    
}

-(UICollectionView *)collectionV
{
    if (!_collectionV) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        _collectionV = [[UICollectionView alloc]initWithFrame:CGRectMake(0,49, kMSScreenWith, kMSScreenHeight-kMSNaviHight-49) collectionViewLayout:layout];
        
        _collectionV.backgroundColor = [UIColor clearColor];
        _collectionV.delegate = self;
        _collectionV.dataSource = self;
        _collectionV.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        [_collectionV registerClass:[WJClassificationCollectionHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"WJClassificationCollectionHeadView"];
        [_collectionV registerClass:[WJKeFenxiaoListCell class] forCellWithReuseIdentifier:@"WJKeFenxiaoListCell"];
    }
    return _collectionV;
}

-(void)getfenXiaoListGoods:(NSInteger)tag
{
   
    _serverType = 2;
    if (_type_com.length>0) {
         [self requestGetAPIWithServe:[NSString stringWithFormat:@"%@/%@/%@?id=%@&com=%@",kMSBaseMiYoMeiPortURL,kMSappVersionCode,kMSDistributionList,_arr_TypeID[tag],_type_com]];
    }
    else if (_type_price.length>0)
    {
         [self requestGetAPIWithServe:[NSString stringWithFormat:@"%@/%@/%@?id=%@&price=%@",kMSBaseMiYoMeiPortURL,kMSappVersionCode,kMSDistributionList,_arr_TypeID[tag],_type_price]];
    }
    else
    {
       [self requestGetAPIWithServe:[NSString stringWithFormat:@"%@/%@/%@?id=%@",kMSBaseMiYoMeiPortURL,kMSappVersionCode,kMSDistributionList,_arr_TypeID[tag]]];
    }
}
- (void)didSelectedButtonWithTag:(NSInteger)currTag
{
    [self getfenXiaoListGoods:currTag];
    _type_title = currTag;
    _type_price = @"";
    _type_com = @"";
    _menu_ScrollView.selectIndex = 0;
}
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    
    if([kind isEqualToString:UICollectionElementKindSectionHeader])
    {
        if(indexPath.section == 0)// 顶部滚动广告
        {
            WJClassificationCollectionHeadView *head = [self.collectionV dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"WJClassificationCollectionHeadView" forIndexPath:indexPath];
            head.filtrateClickBlock = ^(NSInteger selectTag) {
                switch (selectTag) {
                    case 1000:
                        {
                            _type_price = @"";
                            _type_com = @"";
                        }
                        break;
                    case 1001:
                    {
                        _type_price = @"";
                        _type_com = @"";
                    }
                        break;
                    case 1002:
                    {
                        _type_price = @"1";
                        _type_com = @"";
                    }
                        break;
                    case 1003:
                    {
                        _type_com = @"1";
                         _type_price = @"";
                    }
                        break;
                    case 1004:
                    {
                        _type_price = @"2";
                        _type_com = @"";
                    }
                        break;
                    case 1005:
                    {
                        _type_com = @"2";
                         _type_price = @"";
                    }
                        break;
                    default:
                        break;
                }
                [self getfenXiaoListGoods:_type_title];
            };
            reusableview = head;
        }
    }
    return reusableview;
    
}



-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    
    return CGSizeMake(kMSScreenWith, 50);
    
}


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.arr_infomationresults.count;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section;
{
    return 1;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(kMSScreenWith, 100);
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    WJKeFenxiaoListCell *cell = [self.collectionV dequeueReusableCellWithReuseIdentifier:@"WJKeFenxiaoListCell" forIndexPath:indexPath];
    cell.btn_fenXiao.tag = indexPath.row;
    cell.model  = self.arr_infomationresults[indexPath.row];
    cell.filtraFenXiaoClickBlock = ^(NSInteger selectTag) {
        //创建分享消息对象
        UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
        
        //设置文本
        messageObject.text = self.arr_infomationresults[selectTag].goods_name;
        
        UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:self.arr_infomationresults[selectTag].goods_name descr:nil thumImage:self.arr_infomationresults[selectTag].original_img];
        //设置网页地址
        shareObject.webpageUrl = [NSString stringWithFormat:@"https://www.miyomei.com/goods.php?id=%@&u=%@",self.arr_infomationresults[selectTag].goods_id,[AppDelegate shareAppDelegate].user_id] ;
        
        
        //分享消息对象设置分享内容对象
        messageObject.shareObject = shareObject;
        
        [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_QQ),@(UMSocialPlatformType_WechatSession)]];
        [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
            // 根据获取的platformType确定所选平台进行下一步操作
            
            //调用分享接口
            [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
                if (error) {
                    NSString *str_error = [error localizedDescription];
                    [self requestFailed:str_error];
                }else{
                    NSLog(@"response data is %@",data);
                }
            }];
        }];
    };
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
