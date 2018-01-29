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

            model.count = [[dic objectForKey:@"count"] integerValue];
            model.goodsID = [dic objectForKey:@"goodsId"];
            model.goodsName = [dic objectForKey:@"goodsName"];
            model.price = [NSString stringWithFormat:@"%@",[dic objectForKey:@"realPrice"]];

            [dataArray addObject:model];
        }

        _goodsArray = [dataArray mutableCopy];
    }
}
@end
