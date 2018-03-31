//
//  WJJiFenItemCell.h
//  MHUAPP
//
//  Created by jinri on 2018/3/31.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WJJiFenItemCell : UICollectionViewCell
/** 主题图片 */
@property (nonatomic,strong) NSArray *defaultImgArr;
/** 主题标题 */
@property (nonatomic,strong) NSArray *defaultTitleArr;

/** 去各活动 */
@property (nonatomic , copy) void(^goToJiFenClassTypeAction)(NSInteger typeID);
@end
