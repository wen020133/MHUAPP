//
//  WJClassificationCollectionHeadView.h
//  MHUAPP
//
//  Created by wenchengjun on 2018/7/27.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WJClassificationCollectionHeadView : UICollectionReusableView
/** 筛选点击回调 */
@property (nonatomic , copy) void(^filtrateClickBlock)(NSInteger selectTag);
@property (nonatomic , strong) UIImageView *img_upPrice;
@property (nonatomic , strong) UIImageView *img_downPrice;
@property (nonatomic , strong) UIImageView *img_upCom;
@property (nonatomic , strong) UIImageView *img_downCom;
@end
