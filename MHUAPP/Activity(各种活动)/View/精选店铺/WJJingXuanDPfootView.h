//
//  WJJingXuanDPfootView.h
//  MHUAPP
//
//  Created by jinri on 2018/4/9.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WJJingXuanDPfootView : UICollectionReusableView

@property (retain, nonatomic) UIScrollView  *scrollView;
@property (retain, nonatomic) NSArray       *Menu_titles;
@property (retain, nonatomic) NSArray       *Menu_content;


/** 去各活动 */
@property (nonatomic , copy) void(^goToHuoDongClassTypeAction)(NSInteger typeID);
-(void)setUIScrollView;
@end
