//
//  WJDetailPartCommentHeadView.h
//  MHUAPP
//
//  Created by jinri on 2018/4/19.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DCZuoWenRightButton.h"

@interface WJDetailPartCommentHeadView : UICollectionReusableView
/* 更多 */
@property (strong , nonatomic) DCZuoWenRightButton *quickButton;
/* title */
@property (strong , nonatomic) UILabel *titleLabel;

/** 更多点击 */
@property (nonatomic, copy) dispatch_block_t moreClickBlock;
@end
