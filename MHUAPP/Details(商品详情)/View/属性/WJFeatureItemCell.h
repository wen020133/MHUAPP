//
//  WJFeatureItemCell.h
//  MHUAPP
//
//  Created by jinri on 2018/1/9.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WJFeatureItem.h"

@interface WJFeatureItemCell : UICollectionViewCell

/* 内容数据 */
@property (nonatomic , copy) WJFeatureItem *content;

/* 属性 */
@property (strong , nonatomic)UILabel *attLabel;

@end
