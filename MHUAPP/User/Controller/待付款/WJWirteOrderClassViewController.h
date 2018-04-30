//
//  WJWirteOrderClassViewController.h
//  MHUAPP
//
//  Created by jinri on 2018/4/27.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseNetworkViewController.h"
#import "WJCartGoodsModel.h"


@interface WJWirteOrderClassViewController : BaseNetworkViewController<UITableViewDelegate,UITableViewDataSource>

@property (strong,nonatomic) NSArray<WJCartGoodsModel *> *dataArray;

@end
