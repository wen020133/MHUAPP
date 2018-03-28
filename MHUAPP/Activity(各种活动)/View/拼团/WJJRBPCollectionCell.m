//
//  WJJRBPCollectionCell.m
//  MHUAPP
//
//  Created by jinri on 2018/3/28.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import "WJJRBPCollectionCell.h"
#import "WJJinRiBiPinCollectionViewCell.h"
#import "UIView+UIViewFrame.h"
#import "WJJRPTItem.h"

@interface WJJRBPCollectionCell ()<UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout>

/* collection */
@property (strong , nonatomic)UICollectionView *collectionView;
/* 推荐商品数据 */
@property (strong , nonatomic)NSMutableArray<WJJRPTItem *> *countDownItem;

@end


@implementation WJJRBPCollectionCell

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

        [_collectionView registerClass:[WJJinRiBiPinCollectionViewCell class] forCellWithReuseIdentifier:@"WJJinRiBiPinCollectionViewCell"];
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
//    _countDownItem = [WJXianShiMiaoShaModel mj_objectArrayWithFilename:@"ClasiftyGoods.plist"];
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
    WJJinRiBiPinCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WJJinRiBiPinCollectionViewCell" forIndexPath:indexPath];
    cell.model = _countDownItem[indexPath.row];
    return cell;
}

#pragma mark - <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    NSLog(@"点击了计时商品%zd",indexPath.row);

}
@end
