//
//  WJGoodCommentViewController.h
//  MHUAPP
//
//  Created by jinri on 2017/12/4.
//  Copyright © 2017年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseNetworkViewController.h"

@interface WJGoodCommentViewController : BaseNetworkViewController<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property NSInteger page_Information;
@property (strong, nonatomic)  UICollectionView *collectionV;
/* 商品ID */
@property (assign , nonatomic) NSString *goods_id;
@end
