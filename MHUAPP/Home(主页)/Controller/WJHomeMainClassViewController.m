//
//  WJHomeMainClassViewController.m
//  MHUAPP
//
//  Created by wenchengjun on 2017/11/28.
//  Copyright © 2017年 wenchengjun. All rights reserved.
//

#import "WJHomeMainClassViewController.h"
#import "WJHomeScrollAdHeadView.h"
#import "WJGoodsGridViewCell.h"
#import "WJGoodsGridModel.h"
#import "WJHomeTOPCollectionViewCell.h"
#import "WJHomeRecommendCollectionViewCell.h"

#import "WJGoodsDataModel.h"
#import "WJSecondsKillViewController.h"


@interface WJHomeMainClassViewController ()

@property (strong, nonatomic) NSArray *arr_Type;
@property (strong, nonatomic) NSArray *headImageArr;

@end

@implementation WJHomeMainClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSendReplyWithTitle:@"M H U" andLeftButtonName:nil andRightButtonName:nil andTitleLeftOrRight:YES];
    self.view.backgroundColor = [RegularExpressionsMethod ColorWithHexString:kMSVCBackgroundColor];
    self.arr_Type = [NSArray arrayWithObjects:@"首页",@"吹风机",@"直发器",@"电动牙刷",@"个护",@"其他", nil];
    self.headImageArr = [NSArray arrayWithObjects:@"da", nil];
//    [self.view addSubview:self.menuScrollView];
    [self.view addSubview:self.collectionV];
    self.headImageArr = [WJGoodsDataModel mj_objectArrayWithFilename:@"HomeHighGoods.plist"];

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
    // Do any additional setup after loading the view.
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
//-(MenuScrollView *)menuScrollView
//{
//    if (!_menuScrollView) {
//        _menuScrollView = [[MenuScrollView alloc]initWithFrame:CGRectMake(0, 0, kMSScreenWith, 44) withTitles:self.arr_Type withScrollViewWidth:kMSScreenWith];
//        _menuScrollView.delegate = self;
//        [self.view addSubview:_menuScrollView];
//    }
//    return _menuScrollView;
//}

-(UICollectionView *)collectionV
{
    if (!_collectionV) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        _collectionV = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kMSScreenWith, kMSScreenHeight-kMSNaviHight-49) collectionViewLayout:layout];
        
        _collectionV.backgroundColor = [RegularExpressionsMethod ColorWithHexString:kMSVCBackgroundColor];
        _collectionV.delegate = self;
        _collectionV.dataSource = self;
        _collectionV.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        [_collectionV registerClass:[WJHomeScrollAdHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"WJHomeScrollAdHeadView"];
        [_collectionV registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"TOP"];
         [_collectionV registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"common"];
        [_collectionV registerClass:[WJGoodsGridViewCell class] forCellWithReuseIdentifier:@"WJGoodsGridViewCell"];
        [_collectionV registerClass:[WJHomeTOPCollectionViewCell class] forCellWithReuseIdentifier:@"WJHomeTOPCollectionViewCell"];
       [_collectionV registerClass:[WJHomeRecommendCollectionViewCell class] forCellWithReuseIdentifier:@"WJHomeRecommendCollectionViewCell"];
    }
    return _collectionV;
}
- (void)didSelectedButtonWithTag:(NSInteger)currTag
{
    
}
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if([kind isEqualToString:UICollectionElementKindSectionHeader])
    {
        if(indexPath.section == 0)// 顶部滚动广告
        {
            WJHomeScrollAdHeadView *head = [self.collectionV dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"WJHomeScrollAdHeadView" forIndexPath:indexPath];
                head.model = self.headImageArr[0];
            return head;
        }
        else if(indexPath.section == 2)
        {
            UICollectionReusableView *common = [self.collectionV dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"common" forIndexPath:indexPath];
            
            UIView *v = ViewInit(0, 0, kMSScreenWith, 40);
            v.backgroundColor = [RegularExpressionsMethod ColorWithHexString:kMSVCBackgroundColor];
            [common addSubview:v];

            UIView *line = ViewInit(kMSScreenWith/4, 20, kMSScreenWith/2, 1);
            line.backgroundColor = [RegularExpressionsMethod ColorWithHexString:@"#C1C1C1"];
            [common addSubview:line];

            UILabel *more = LabelInit(kMSScreenWith/2-40, 0, 80, 40);
            more.textColor = [RegularExpressionsMethod ColorWithHexString:BASELITTLEBLACKCOLOR];
            more.backgroundColor =[RegularExpressionsMethod ColorWithHexString:kMSVCBackgroundColor];
            more.text = @"为你推荐";
            more.textAlignment = NSTextAlignmentCenter;
            [common addSubview:more];
            more.font = PFR14Font;

            return common;
        }
        else
        {
            UICollectionReusableView *TOP = [self.collectionV dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"TOP" forIndexPath:indexPath];
            
            UIView *v = ViewInit(0, 0, kMSScreenWith, 40);
            v.backgroundColor = [RegularExpressionsMethod ColorWithHexString:kMSVCBackgroundColor];
            [TOP addSubview:v];

            UIView *line = ViewInit(kMSScreenWith/4, 20, kMSScreenWith/2, 1);
            line.backgroundColor = [RegularExpressionsMethod ColorWithHexString:@"#C1C1C1"];
            [TOP addSubview:line];

            UILabel *more = LabelInit(kMSScreenWith/2-24, 0, 48, 40);
            more.textColor = [RegularExpressionsMethod ColorWithHexString:BASELITTLEBLACKCOLOR];
            more.backgroundColor = [RegularExpressionsMethod ColorWithHexString:kMSVCBackgroundColor];
            more.text = @"TOP";
            more.textAlignment = NSTextAlignmentCenter;
            [TOP addSubview:more];
            more.font = PFR14Font;
            


            return TOP;
        }
    }
    else
    {
        return nil;
    }
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 6;

}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return CGSizeMake(kMSScreenWith, kMSScreenWith/2);
    }
    else
    {
        return CGSizeMake(kMSScreenWith, 40);
    }
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 3;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    else if (section==1)
    {
        return self.headImageArr.count;
    }
    else
        return self.headImageArr.count;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
        
            return CGSizeMake(kMSScreenWith, kMSScreenWith/2-40);
        
        else if(indexPath.section == 1)
        {
            return CGSizeMake(kMSScreenWith, 180);
        }
        else
        return CGSizeMake(kMSScreenWith/2, 180);
      
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
            WJGoodsGridViewCell *cell = [self.collectionV dequeueReusableCellWithReuseIdentifier:@"WJGoodsGridViewCell" forIndexPath:indexPath];
//                cell.defaultImgArr = self.headImageArr;
        cell.goToALLTypeAction = ^(NSInteger typeID){//点击了筛选
            [self gotoTypeClassWithID:typeID];
        };
            return cell;
     
    }
    else if (indexPath.section == 1)
    {
        WJHomeTOPCollectionViewCell *cell = [self.collectionV dequeueReusableCellWithReuseIdentifier:@"WJHomeTOPCollectionViewCell" forIndexPath:indexPath];
        cell.model = self.headImageArr[indexPath.row];
        return cell;
    }
    else
    {
        WJHomeRecommendCollectionViewCell *cell = [self.collectionV dequeueReusableCellWithReuseIdentifier:@"WJHomeRecommendCollectionViewCell" forIndexPath:indexPath];
        cell.model = self.headImageArr[indexPath.row];
        return cell;
    }
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

        default:
            break;
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
