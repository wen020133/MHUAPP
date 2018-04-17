//
//  WJCountDownHeadView.h
//  MHUAPP
//
//  Created by jinri on 2018/2/24.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WJCountDownHeadView : UICollectionReusableView
@property (strong, nonatomic) NSString *end_time;
@property (strong, nonatomic) NSString *start_time;

- (void)setUpUI;

@end
