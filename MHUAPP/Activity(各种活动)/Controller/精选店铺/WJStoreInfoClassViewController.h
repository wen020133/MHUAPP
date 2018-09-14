//
//  WJStoreInfoClassViewController.h
//  MHUAPP
//
//  Created by wenchengjun on 2018/5/13.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseNetworkViewController.h"

@interface WJStoreInfoClassViewController : BaseNetworkViewController<UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource>

@property (assign ,nonatomic) NSString *storeId;
@property (assign ,nonatomic) NSString *storeLogo;
@property (assign ,nonatomic) NSString *storeName;

@property (strong ,nonatomic) NSString *is_attention;
@end
