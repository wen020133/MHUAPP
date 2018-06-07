//
//  WJEveryDayMastRobView.h
//  MHUAPP
//
//  Created by wenchengjun on 2018/2/24.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WJADThirdItem.h"

@interface WJEveryDayMastRobView : UICollectionReusableView

@property (strong, nonatomic) NSArray <WJADThirdItem *>  *imageArr;

/** 去各活动 */
@property (nonatomic , copy) void(^goToADAction)(NSInteger index);
@end
