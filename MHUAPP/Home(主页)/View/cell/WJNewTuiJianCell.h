//
//  WJNewTuiJianCell.h
//  MHUAPP
//
//  Created by jinri on 2018/2/25.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WJNewTuiJianCell : UICollectionViewCell

/* 推荐商品数据 */
@property (strong , nonatomic) NSArray  *countDownItem;
/* 推荐商品数据 */
- (void)setUpUI;

@property (nonatomic , copy) void(^goToGoodDetailClass)(NSString *good_id);

@end
