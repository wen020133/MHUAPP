//
//  WJCartShopModel.m
//  MHUAPP
//
//  Created by jinri on 2018/1/25.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import "WJCartShopModel.h"
#import "WJCartGoodsModel.h"

@implementation WJCartShopModel

- (void)configGoodsArrayWithArray:(NSArray*)array; {
    if (array.count > 0) {
        NSMutableArray *dataArray = [NSMutableArray arrayWithCapacity:0];
        for (NSDictionary *dic in array) {
            WJCartGoodsModel *model = [[WJCartGoodsModel alloc]init];

            model.goods_number = [[dic objectForKey:@"goods_number"] integerValue];
            model.goods_id = [dic objectForKey:@"goods_id"];
            model.goods_name = [dic objectForKey:@"goods_name"];
            model.count_price = [NSString stringWithFormat:@"%@",[dic objectForKey:@"count_price"]];
            model.goods_attr = [dic objectForKey:@"goods_attr"];
            model.rec_id = [dic objectForKey:@"rec_id"];
            model.youhui = [dic objectForKey:@"youhui"];
            model.market_price = [NSString stringWithFormat:@"%@",[dic objectForKey:@"market_price"]];
            [dataArray addObject:model];
        }

        _goodsArray = [dataArray mutableCopy];
    }
}
@end
