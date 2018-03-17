//
//  BadgeButton.h
//  MHUAPP
//
//  Created by jinri on 2018/3/16.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BadgeButton : UIButton

-(void)showBadgeWithNumber:(NSInteger)badgeNumber;

-(void)hideBadge;

@end
