//
//  WJSSPTTypeViewController.h
//  MHUAPP
//
//  Created by jinri on 2018/3/27.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseNetworkViewController.h"

@interface WJSSPTTypeViewController : BaseNetworkViewController<UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource>

@property (strong, nonatomic) UICollectionView *collectionV;
@end
