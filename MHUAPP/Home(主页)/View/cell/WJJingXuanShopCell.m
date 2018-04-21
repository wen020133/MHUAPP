//
//  WJJingXuanShopCell.m
//  MHUAPP
//
//  Created by jinri on 2018/2/25.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import "WJJingXuanShopCell.h"
#import "WJJingXuanShopSonCell.h"
#import "UIView+UIViewFrame.h"
#import "WJJingXuanShopItem.h"

@interface WJJingXuanShopCell ()<UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout>

/* collection */
@property (strong , nonatomic)UICollectionView *collectionView;
@property (strong, nonatomic) NSArray <WJJingXuanShopItem *>  *jingXuanItem;

@end


@implementation WJJingXuanShopCell


#pragma mark - lazyload
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.minimumLineSpacing = 1;
        layout.itemSize = CGSizeMake(self.height * 0.65, self.height * 0.9);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal; //滚动方向
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];

        _collectionView.frame = self.bounds;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;

        [_collectionView registerClass:[WJJingXuanShopSonCell class] forCellWithReuseIdentifier:@"WJJingXuanShopSonCell"];
    }
    return _collectionView;
}

#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {

    self = [super initWithFrame:frame];
    if (self) {

//        [self setUpUI];
    }
    return self;
}

- (void)setUpUI
{
    self.backgroundColor = [UIColor whiteColor];
    self.collectionView.backgroundColor = self.backgroundColor;
   self.jingXuanItem =  [WJJingXuanShopItem mj_objectArrayWithKeyValuesArray:self.arr_data];
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
    return self.jingXuanItem.count;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(kMSScreenWith/2-20, 200);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    WJJingXuanShopSonCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WJJingXuanShopSonCell" forIndexPath:indexPath];
    cell.model = self.jingXuanItem[indexPath.row];
    return cell;
}

#pragma mark - <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    NSLog(@"点击了计时商品%zd",indexPath.row);

}

@end
