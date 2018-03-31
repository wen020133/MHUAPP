//
//  WJHotSellingViewController.h
//  MHUAPP
//
//  Created by jinri on 2018/3/31.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuScrollView.h"
#import "BaseNetworkViewController.h"


@interface WJHotSellingViewController : BaseNetworkViewController<MenuBtnDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource>

@property (strong, nonatomic) MenuScrollView *menu_HotSellScrollView; //热卖分类ScrollView

@property (strong, nonatomic) UICollectionView *collectionV;
@end
