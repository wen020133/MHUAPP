//
//  WJHomeMainClassViewController.h
//  MHUAPP
//
//  Created by wenchengjun on 2017/11/28.
//  Copyright © 2017年 wenchengjun. All rights reserved.
//


#import <UIKit/UIKit.h>


@interface WJHomeMainClassViewController : UIViewController<UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource>


@property (strong, nonatomic) UICollectionView *collectionV;

@property (strong, nonatomic) UIImageView *backTopImageView;

@end
