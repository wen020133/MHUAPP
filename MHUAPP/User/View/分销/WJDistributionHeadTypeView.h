//
//  WJDistributionHeadTypeView.h
//  MHUAPP
//
//  Created by wenchengjun on 2018/7/27.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WJDistributionHeadTypeView : UIView
/* 图片 */
@property (strong , nonatomic) UIImageView *img_content;
/** 主题图片 */
@property (nonatomic,strong) NSArray *defaultImgArr;
/** 主题标题 */
@property (nonatomic,strong) NSArray *defaultTitleArr;

/** 去各活动 */
@property (nonatomic , copy) void(^goToSelectClassTypeAction)(NSInteger typeID);

@end
