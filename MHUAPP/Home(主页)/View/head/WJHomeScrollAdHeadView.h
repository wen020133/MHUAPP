//
//  WJHomeScrollAdHeadView.h
//  MHUAPP
//
//  Created by wenchengjun on 2017/11/28.
//  Copyright © 2017年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WJADThirdItem.h"

@interface WJHomeScrollAdHeadView : UICollectionReusableView
@property (strong, nonatomic) NSArray <WJADThirdItem *>  *imageArr;

-(void)setUIInit;

/** 去各活动 */
@property (nonatomic , copy) void(^goToADAction)(NSInteger index);
@end
