//
//  WJZhuanTiHDGridFootView.h
//  MHUAPP
//
//  Created by jinri on 2018/4/2.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WJZhuanTiHDGridFootView : UICollectionReusableView

@property(strong,nonatomic) UILabel *lab_manjian;
@property(strong,nonatomic) UILabel *lab_type;

/** 取消点击回调 */
@property (nonatomic, copy) dispatch_block_t newToGetYouhuiquan;
@end
