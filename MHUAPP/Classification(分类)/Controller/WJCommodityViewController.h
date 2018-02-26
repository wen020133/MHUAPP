//
//  WJCommodityViewController.h
//  MHUAPP
//
//  Created by wenchengjun on 2017/11/28.
//  Copyright © 2017年 wenchengjun. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "WJClassGoodsItem.h"
#import "WJClassMainGoodTypeModel.h"
#import "BaseNetworkViewController.h"

@interface WJCommodityViewController : BaseNetworkViewController<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
/* tableView */
@property (strong , nonatomic)UITableView *tableView;
/* collectionViw */
@property (strong , nonatomic)UICollectionView *collectionView;

/* 左边数据 */
@property (strong , nonatomic) NSMutableArray *arr_collectionList;


/* 左边数据 */
@property (strong , nonatomic)NSMutableArray<WJClassGoodsItem *> *titleItem;
/* 右边数据 */
@property (strong , nonatomic)NSMutableArray<WJClassMainGoodTypeModel *> *mainmodel;

@end
