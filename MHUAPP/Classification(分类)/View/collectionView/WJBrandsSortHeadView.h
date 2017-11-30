//
//  WJBrandsSortHeadView.h
//  MHUAPP
//
//  Created by jinri on 2017/11/30.
//  Copyright © 2017年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WJClassGoodsItem.h"

@interface WJBrandsSortHeadView : UICollectionReusableView

/* 标题数据 */
@property (strong , nonatomic) WJClassGoodsItem *titleItem;

/* 头部标题Label */
@property (strong , nonatomic)UILabel *headLabel;

@end
