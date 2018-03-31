//
//  WJIntegralListViewController.h
//  MHUAPP
//
//  Created by jinri on 2018/3/31.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuScrollView.h"
#import "BaseNetworkViewController.h"

@interface WJIntegralListViewController : BaseNetworkViewController<MenuBtnDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource>
@property (strong, nonatomic) MenuScrollView *menu_jifenScrollView; //分类ScrollView

@property (strong, nonatomic) UICollectionView *collectionV;
@end
