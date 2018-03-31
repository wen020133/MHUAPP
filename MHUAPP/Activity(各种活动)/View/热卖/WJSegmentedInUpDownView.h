//
//  WJSegmentedInUpDownView.h
//  MHUAPP
//
//  Created by jinri on 2018/3/31.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WJSegmentedInUpDownView : UIView

@property (retain, nonatomic) NSArray       *Menu_titles;

@property (assign, nonatomic) NSInteger     selectIndex;

/** 去各活动 */
@property (nonatomic , copy) void(^selectAction)(NSInteger typeID);


@end
