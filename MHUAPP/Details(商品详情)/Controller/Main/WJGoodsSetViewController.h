//
//  WJGoodsSetViewController.h
//  MHUAPP
//
//  Created by jinri on 2017/12/1.
//  Copyright © 2017年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseNetworkViewController.h"


@interface WJGoodsSetViewController : BaseNetworkViewController
/* 分类标题*/
@property (strong , nonatomic) NSString *goodTypeName;
/* 分类ID*/
@property (assign , nonatomic) NSString *category_id;
/* 价格升/降 */
@property (strong , nonatomic) NSString *type_sort;
/* 销量升/降 */
@property (strong , nonatomic) NSString *type_market;
/* 查询类型*/
@property (strong , nonatomic) NSString *str_type;
@property NSInteger page_Information;


@end
