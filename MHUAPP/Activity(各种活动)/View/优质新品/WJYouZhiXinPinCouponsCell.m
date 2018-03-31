//
//  WJYouZhiXinPinCouponsCell.m
//  MHUAPP
//
//  Created by jinri on 2018/3/31.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import "WJYouZhiXinPinCouponsCell.h"
#import "UIView+UIViewFrame.h"
#import "WJJRPTItem.h"

#import "WJYZXPCellForCell.h"


@interface WJYouZhiXinPinCouponsCell ()<UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout>

/* collection */
@property (strong , nonatomic)UICollectionView *collectionView;
/* 推荐商品数据 */
@property (strong , nonatomic)NSMutableArray<WJJRPTItem *> *countDownItem;

@end


@implementation WJYouZhiXinPinCouponsCell
#pragma mark - lazyload
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.minimumLineSpacing = 1;
        layout.itemSize = CGSizeMake(100, 100);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal; //滚动方向
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.frame = self.bounds;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;

        [_collectionView registerClass:[WJYZXPCellForCell class] forCellWithReuseIdentifier:@"WJYZXPCellForCell"];
    }
    return _collectionView;
}

#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {

    self = [super initWithFrame:frame];
    if (self) {

        [self setUpUI];
    }
    return self;
}

- (void)setUpUI
{
    self.backgroundColor = [UIColor whiteColor];
    self.collectionView.backgroundColor = self.backgroundColor;
    _countDownItem = [WJJRPTItem mj_objectArrayWithFilename:@"ClasiftyGoods.plist"];
    [self addSubview:self.collectionView];

}

#pragma mark - 布局
- (void)layoutSubviews
{
    [super layoutSubviews];
}

#pragma mark - Setter Getter Methods
#pragma mark - <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _countDownItem.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    WJYZXPCellForCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WJYZXPCellForCell" forIndexPath:indexPath];
    cell.model = _countDownItem[indexPath.row];
    return cell;
}

#pragma mark - <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    NSLog(@"点击了%zd",indexPath.row);

}
@end
