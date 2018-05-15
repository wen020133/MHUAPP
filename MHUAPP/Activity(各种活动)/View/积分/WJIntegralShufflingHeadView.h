//
//  WJIntegralShufflingHeadView.h
//  MHUAPP
//
//  Created by jinri on 2018/5/14.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WJIntegralShufflingHeadView : UICollectionReusableView
/** 轮播数组 */
@property (nonatomic, copy) NSArray *shufflingArray;
/* title */
@property (strong , nonatomic) NSString *str_title;

@end
