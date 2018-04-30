//
//  WJFeatureHeaderView.h
//  MHUAPP
//
//  Created by jinri on 2018/1/10.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WJFeatureItem.h"

@interface WJFeatureHeaderView : UICollectionReusableView

/** 标题数据 */
@property (nonatomic, strong) WJFeatureItem *headTitle;

/* 属性标题 */
@property (strong , nonatomic)UILabel *headerLabel;
/* 底部View */
@property (strong , nonatomic)UIView *bottomView;

@end
