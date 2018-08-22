//
//  WJShiShiPingTuanView.h
//  MHUAPP
//
//  Created by jinri on 2018/2/25.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DCZuoWenRightButton.h"


@interface WJShiShiPingTuanView : UICollectionReusableView
/* title */
@property (strong , nonatomic) UILabel *titleLabel;
/* 更多 */
@property (strong , nonatomic) DCZuoWenRightButton *quickButton;

@end
