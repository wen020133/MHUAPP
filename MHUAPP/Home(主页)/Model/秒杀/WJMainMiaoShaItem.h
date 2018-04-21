//
//  WJMainMiaoShaItem.h
//  MHUAPP
//
//  Created by jinri on 2018/4/17.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WJXianShiMiaoShaModel.h"

@interface WJMainMiaoShaItem : NSObject
/* 名字 */
@property (strong , nonatomic) NSString *goods_price;
/* ID */
@property (strong , nonatomic) NSString *goods_id;
/* 商品秒杀库存 */
@property (strong , nonatomic) NSString *kill_num;
/* 秒杀原有库存 */
@property (strong , nonatomic) NSString *goods_num;

/*字典 */
@property (strong , nonatomic) NSDictionary *goods;
@end
