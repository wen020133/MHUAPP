//
//  WJOrderShangJiaHeadModel.m
//  MHUAPP
//
//  Created by jinri on 2018/5/3.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import "WJOrderShangJiaHeadModel.h"
#import "WJOrderGoodListModel.h"

@implementation WJOrderShangJiaHeadModel

- (void)configGoodsArrayWithArray:(NSArray*)array; {
    if (array.count > 0) {
        NSMutableArray *dataArray = [NSMutableArray arrayWithCapacity:0];
        for (NSDictionary *dic in array) {
            WJOrderGoodListModel *model = [[WJOrderGoodListModel alloc]init];

            model.goods_number = [[dic objectForKey:@"goods_number"] integerValue];
            model.goods_id = [dic objectForKey:@"goods_id"];
            model.order_id = [dic objectForKey:@"order_id"];
            model.img = [dic objectForKey:@"img"];
            model.goods_name = [dic objectForKey:@"goods_name"];
            model.count_price = [NSString stringWithFormat:@"%@",[dic objectForKey:@"count_price"]];
            model.goods_attr = [dic objectForKey:@"goods_attr"];
            model.rec_id = [dic objectForKey:@"rec_id"];
            model.youhui = [dic objectForKey:@"youhui"];
            model.market_price = [NSString stringWithFormat:@"%@",[dic objectForKey:@"market_price"]];
             model.shop_price = [NSString stringWithFormat:@"%@",[dic objectForKey:@"shop_price"]];
            model.back_goods_number = [NSString stringWithFormat:@"%@",[dic objectForKey:@"back_goods_number"]];
            model.back_goods_price = [NSString stringWithFormat:@"%@",[dic objectForKey:@"back_goods_price"]];
            model.back_id = [NSString stringWithFormat:@"%@",[dic objectForKey:@"back_id"]];
            model.status_back = [NSString stringWithFormat:@"%@",[dic objectForKey:@"status_back"]];
            model.status_refund = [NSString stringWithFormat:@"%@",[dic objectForKey:@"status_refund"]];
            [dataArray addObject:model];
        }

        _goodsArray = [dataArray mutableCopy];
    }
}

@end
