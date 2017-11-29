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

@end
