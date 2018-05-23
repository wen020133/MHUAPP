//
//  WJGoodsCountDownCell.m
//  MHUAPP
//
//  Created by jinri on 2018/2/24.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import "WJGoodsCountDownCell.h"
#import <UIImageView+WebCache.h>
#import "UIView+UIViewFrame.h"
#import "WJXianShiMiaoShaCell.h"
#import "WJGoodDetailViewController.h"

@interface WJGoodsCountDownCell ()<UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout>

/* collection */
@property (strong , nonatomic)UICollectionView *collectionView;


@end

@implementation WJGoodsCountDownCell

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

        [_collectionView registerClass:[WJXianShiMiaoShaCell class] forCellWithReuseIdentifier:@"WJXianShiMiaoShaCell"];
    }
    return _collectionView;
}

#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {

    self = [super initWithFrame:frame];
    if (self) {

    }
    return self;
}

- (void)setUpUI
{
    self.backgroundColor = [UIColor whiteColor];
    self.collectionView.backgroundColor = self.backgroundColor;
    
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
    WJXianShiMiaoShaCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WJXianShiMiaoShaCell" forIndexPath:indexPath];
    NSString *urlStr = [NSString stringWithFormat:@"%@",_countDownItem[indexPath.row][@"goods"][@"goods_thumb"]];
    [cell.img_content sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:@"home_banner_img.png"] completed:nil];
    cell.lab_title.text = _countDownItem[indexPath.row][@"goods"] [@"goods_name"];
    cell.lab_price.text = [NSString stringWithFormat:@"￥%@",_countDownItem[indexPath.row][@"goods_price"]];

    NSString *oldprice = _countDownItem[indexPath.row][@"goods"] [@"shop_price"];
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:oldprice
                                                                                attributes:@{NSStrikethroughStyleAttributeName : @(NSUnderlineStyleSingle)}];
    cell.oldPriceLabel.attributedText = attrStr;

    NSString *kill_num = _countDownItem[indexPath.row][@"kill_num"];
    NSString *goods_num = _countDownItem[indexPath.row][@"goods_num"];
    NSInteger num =  [kill_num integerValue]-[goods_num integerValue];
    cell.lab_count.text = [NSString stringWithFormat:@"%ld人已付款",num];
    return cell;
}

#pragma mark - <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    NSString *good_id = _countDownItem[indexPath.row][@"goods_id"];
   !_goToGoodDetailClass ? : _goToGoodDetailClass(good_id);
}
@end
