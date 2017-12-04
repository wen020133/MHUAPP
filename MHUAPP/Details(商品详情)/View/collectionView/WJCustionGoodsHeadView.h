//
//  WJCustionGoodsHeadView.h
//  MHUAPP
//
//  Created by jinri on 2017/12/1.
//  Copyright © 2017年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WJCustionGoodsHeadView : UICollectionReusableView

/** 筛选点击回调 */
@property (nonatomic , copy) void(^filtrateClickBlock)(NSInteger selectTag);

@end
