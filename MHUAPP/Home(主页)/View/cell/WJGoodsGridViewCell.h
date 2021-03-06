//
//  WJGoodsGridViewCell.h
//  MHUAPP
//
//  Created by wenchengjun on 2017/11/28.
//  Copyright © 2017年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WJGoodsGridViewCell : UICollectionViewCell<UIScrollViewDelegate>

/** 滑动视图 */
@property (strong, nonatomic) UIScrollView *scrollView;

/** 主题图片 */
@property (nonatomic,strong) NSArray *defaultImgArr;
/** 主题标题 */
@property (nonatomic,strong) NSArray *defaultTitleArr;

/** 去各活动 */
@property (nonatomic , copy) void(^goToALLTypeAction)(NSInteger typeID);
@end
